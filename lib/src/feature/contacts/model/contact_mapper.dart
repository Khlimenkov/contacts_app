import 'package:contacts_app/src/feature/contacts/model/address.dart';
import 'package:contacts_app/src/feature/contacts/model/address_entity.dart';
import 'package:contacts_app/src/feature/contacts/model/contact.dart';
import 'package:contacts_app/src/feature/contacts/model/contact_entity.dart';

extension ContactEntityMapper on ContactEntity {
  Contact toContact() => Contact(
        contactId: contactId,
        firstName: firstName,
        phoneNumber: phoneNumber,
        lastName: lastName,
        addresses: addresses
            .map(
              (el) => Address(
                id: el.id,
                city: el.city,
                state: el.state,
                streetAddress1: el.streetAddress1,
                streetAddress2: el.streetAddress2,
                zipCode: el.zipCode,
              ),
            )
            .toList(),
      );
}

extension ContactMapper on Contact {
  ContactEntity toContactEntity({int id = 0}) {
    final addressEnitities = addresses.map(
      (el) => AddressEntity(
        city: el.city,
        id: el.id,
        state: el.state,
        streetAddress1: el.streetAddress1,
        streetAddress2: el.streetAddress2,
        zipCode: el.zipCode,
      ),
    );
    final entity = ContactEntity(
      id: id,
      contactId: contactId,
      firstName: firstName,
      phoneNumber: phoneNumber,
      lastName: lastName,
    );
    entity.addresses.addAll(addressEnitities);
    return entity;
  }
}
