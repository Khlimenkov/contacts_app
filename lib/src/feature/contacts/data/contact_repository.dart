import 'package:contacts_app/src/feature/contacts/data/concact_storage_data_provider.dart';
import 'package:contacts_app/src/feature/contacts/model/contact.dart';

abstract interface class ContactRepository {
  Future<List<Contact>> getContacts();
  Future<Contact> getContact(String contactId);
  Future<Contact> deleteContact(String contactId);
  Future<Contact> createContact(Contact contact);
  Future<Contact> updateContact(Contact contact);
  Future<void> putMany(List<Contact> contacts);
  Contact getNewContactTemplate();
}

class ContactRepositoryImpl implements ContactRepository {
  final ContactStorageDataProvider _storageDataProvider;

  ContactRepositoryImpl({required ContactStorageDataProvider storageDataProvider})
      : _storageDataProvider = storageDataProvider;

  @override
  Future<Contact> createContact(Contact contact) => _storageDataProvider.createContact(contact);

  @override
  Future<Contact> deleteContact(String contactId) => _storageDataProvider.deleteContact(contactId);

  @override
  Future<List<Contact>> getContacts() => _storageDataProvider.getContacts();

  @override
  Future<Contact> updateContact(Contact contact) => _storageDataProvider.updateContact(contact);

  @override
  Contact getNewContactTemplate() => const Contact(contactId: '', firstName: '', phoneNumber: '');

  @override
  Future<Contact> getContact(String contactId) => _storageDataProvider.getContact(contactId);

  @override
  Future<void> putMany(List<Contact> contacts) => _storageDataProvider.putMany(contacts);
}
