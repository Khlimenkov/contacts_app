import 'package:contacts_app/src/feature/contacts/model/contact.dart';
import 'package:contacts_app/src/feature/contacts/model/contact_entity.dart';

extension ContactEntityMapper on ContactEntity {
  Contact toContact() => Contact(
        contactId: contactId,
        firstName: firstName,
        phoneNumber: phoneNumber,
        city: city,
        lastName: lastName,
        state: state,
        streetAddress1: streetAddress1,
        streetAddress2: streetAddress2,
        zipCode: zipCode,
      );
}

extension ContactMapper on Contact {
  ContactEntity toContactEntity({int id = 0}) => ContactEntity(
        id: id,
        contactId: contactId,
        firstName: firstName,
        phoneNumber: phoneNumber,
        city: city,
        lastName: lastName,
        state: state,
        streetAddress1: streetAddress1,
        streetAddress2: streetAddress2,
        zipCode: zipCode,
      );
}
