import 'package:objectbox/objectbox.dart';

@Entity()
class ContactEntity {
  int id;

  @Index()
  String contactId;
  String firstName;
  String phoneNumber;
  String? lastName;
  String? streetAddress1;
  String? streetAddress2;
  String? city;
  String? state;
  String? zipCode;

  ContactEntity({
    required this.contactId,
    required this.firstName,
    required this.phoneNumber,
    this.id = 0,
    this.city,
    this.lastName,
    this.state,
    this.streetAddress1,
    this.streetAddress2,
    this.zipCode,
  });
}
