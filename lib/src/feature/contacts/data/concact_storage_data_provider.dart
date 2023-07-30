import 'package:contacts_app/objectbox.g.dart';
import 'package:contacts_app/src/common/database/objectbox/app_database.dart';
import 'package:contacts_app/src/feature/contacts/model/contact.dart';
import 'package:contacts_app/src/feature/contacts/model/contact_mapper.dart';

abstract interface class ContactStorageDataProvider {
  Future<List<Contact>> getContacts();
  Future<void> deleteContact(String contactId);
  Future<String> createContact(Contact contact);
  Future<void> updateContact(Contact contact);
}

class ContactObjectBoxDataProvider implements ContactStorageDataProvider {
  final ObjectBoxDatabase _database;

  ContactObjectBoxDataProvider({
    required ObjectBoxDatabase database,
  }) : _database = database;

  @override
  Future<String> createContact(Contact contact) async {
    _database.contactBox.put(contact.toContactEntity(), mode: PutMode.insert);
    return contact.contactId;
  }

  @override
  Future<void> deleteContact(String contactId) async {
    _database.contactBox.query(ContactEntity_.contactId.equals(contactId)).build().remove();
  }

  @override
  Future<List<Contact>> getContacts() async {
    final data = _database.contactBox.getAll().map((e) => e.toContact()).toList();
    return data;
  }

  @override
  Future<void> updateContact(Contact contact) async {
    final uniqueContactId =
        _database.contactBox.query(ContactEntity_.contactId.equals(contact.contactId)).build().findUnique()?.id;
    if (uniqueContactId != null) {
      _database.contactBox.put(contact.toContactEntity(id: uniqueContactId), mode: PutMode.update);
    } else {
      throw Exception('No valid contact');
    }
  }
}
