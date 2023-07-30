import 'package:contacts_app/src/feature/contacts/data/concact_storage_data_provider.dart';
import 'package:contacts_app/src/feature/contacts/model/contact.dart';

abstract interface class ContactRepository {
  Future<List<Contact>> getContacts();
  Future<void> deleteContact(String contactId);
  Future<String> createContact(Contact contact);
  Future<void> updateContact(Contact contact);
}

// class MockContactRepository implements ContactRepository {
//   @override
//   Future<String> createContact(Contact contact) async {
//     return DateTime.now().toUtc().toIso8601String();
//   }

//   @override
//   Future<void> deleteContact(String contactId) async {}

//   @override
//   Future<List<Contact>> getContacts() async {
//     return [
//       const Contact(
//           contactId: '1',
//           firstName: 'Alex',
//           phoneNumber: '11111',
//           city: 'City',
//           lastName: 'Khlimenkov',
//           state: 'State',
//           streetAddress1: 'Address 1',
//           streetAddress2: 'Address 2',
//           zipCode: 'zipCode')
//     ];
//   }

//   @override
//   Future<void> updateContact(Contact contact) async {}
// }

class ContactRepositoryImpl implements ContactRepository {
  final ContactStorageDataProvider _storageDataProvider;

  ContactRepositoryImpl({required ContactStorageDataProvider storageDataProvider})
      : _storageDataProvider = storageDataProvider;

  @override
  Future<String> createContact(Contact contact) => _storageDataProvider.createContact(contact);

  @override
  Future<void> deleteContact(String contactId) => _storageDataProvider.deleteContact(contactId);

  @override
  Future<List<Contact>> getContacts() => _storageDataProvider.getContacts();

  @override
  Future<void> updateContact(Contact contact) => _storageDataProvider.updateContact(contact);
}
