import 'package:contacts_app/objectbox.g.dart';
import 'package:contacts_app/src/common/database/objectbox/app_database.dart';
import 'package:contacts_app/src/feature/contacts/model/contact.dart';
import 'package:contacts_app/src/feature/contacts/model/contact_mapper.dart';

abstract interface class ContactStorageDataProvider {
  Future<List<Contact>> getContacts();
  Future<Contact> getContact(String contactId);
  Future<Contact> deleteContact(String contactId);
  Future<Contact> createContact(Contact contact);
  Future<Contact> updateContact(Contact contact);
  Future<void> putMany(List<Contact> contacts);
}

class ContactObjectBoxDataProvider implements ContactStorageDataProvider {
  final ObjectBoxDatabase _database;

  ContactObjectBoxDataProvider({
    required ObjectBoxDatabase database,
  }) : _database = database;

  @override
  Future<Contact> createContact(Contact contact) async {
    final contactEntity = contact.toContactEntity();
    if (contactEntity.addresses.isNotEmpty) {
      _database.addressBox.putMany(contactEntity.addresses);
    }
    final newContactEntity = await _database.contactBox.putAndGetAsync(contact.toContactEntity(), mode: PutMode.insert);
    return newContactEntity.toContact();
  }

  @override
  Future<Contact> deleteContact(String contactId) async {
    final deletedEntity = _database.contactBox.query(ContactEntity_.contactId.equals(contactId)).build().findUnique();
    if (deletedEntity != null) {
      _database.contactBox.remove(deletedEntity.id);
      return deletedEntity.toContact();
    } else {
      throw Exception('No valid contact');
    }
  }

  @override
  Future<List<Contact>> getContacts() async {
    final data = _database.contactBox.getAll().map((e) => e.toContact()).toList();
    return data;
  }

  @override
  Future<Contact> updateContact(Contact contact) async {
    final uniqueContactEntity =
        _database.contactBox.query(ContactEntity_.contactId.equals(contact.contactId)).build().findUnique();
    if (uniqueContactEntity != null) {
      final contactEntity = contact.toContactEntity(id: uniqueContactEntity.id);
      final contactAddressesIds = contact.addresses.map((e) => e.id).toList();
      final deletionAddresses =
          uniqueContactEntity.addresses.where((element) => !contactAddressesIds.contains(element.id)).toList();
      if (deletionAddresses.isNotEmpty) {
        _database.addressBox.removeMany(deletionAddresses.map((e) => e.id).toList());
      }
      final updatedContactEntity = await _database.contactBox.putAndGetAsync(
        contactEntity,
        mode: PutMode.put,
      );
      return updatedContactEntity.toContact();
    } else {
      throw Exception('No valid contact');
    }
  }

  @override
  Future<Contact> getContact(String contactId) async {
    final contactEntity = _database.contactBox.query(ContactEntity_.contactId.equals(contactId)).build().findUnique();
    if (contactEntity != null) {
      return contactEntity.toContact();
    } else {
      throw Exception('No valid contact');
    }
  }

  @override
  Future<void> putMany(List<Contact> contacts) async {
    final entities = contacts.map((e) => e.toContactEntity()).toList();
    _database.contactBox.putMany(entities);
  }
}
