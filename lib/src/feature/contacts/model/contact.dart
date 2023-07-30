import 'package:uuid/uuid.dart';

class Contact {
  final String contactId;
  final String firstName;
  final String phoneNumber;
  final String? lastName;
  final String? streetAddress1;
  final String? streetAddress2;
  final String? city;
  final String? state;
  final String? zipCode;

  const Contact({
    required this.contactId,
    required this.firstName,
    required this.phoneNumber,
    this.lastName,
    this.streetAddress1,
    this.streetAddress2,
    this.city,
    this.state,
    this.zipCode,
  });

  Contact.withGenId({
    required this.firstName,
    required this.phoneNumber,
    this.lastName,
    this.streetAddress1,
    this.streetAddress2,
    this.city,
    this.state,
    this.zipCode,
  }) : contactId = const Uuid().v4();

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        contactId: json['contactId'],
        firstName: json['firstName'],
        phoneNumber: json['phoneNumber'],
        city: json['city'],
        lastName: json['lastName'],
        state: json['state'],
        streetAddress1: json['streetAddress1'],
        streetAddress2: json['streetAddress2'],
        zipCode: json['zipCode'],
      );

  Contact copyWith(
          {String? contactId,
          String? firstName,
          String? phoneNumber,
          String? lastName,
          String? streetAddress1,
          String? streetAddress2,
          String? city,
          String? state,
          String? zipCode}) =>
      Contact(
        contactId: contactId ?? this.contactId,
        firstName: firstName ?? this.firstName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        city: city ?? this.city,
        lastName: lastName ?? this.lastName,
        state: state ?? this.state,
        streetAddress1: streetAddress1 ?? this.streetAddress1,
        streetAddress2: streetAddress2 ?? this.streetAddress2,
        zipCode: zipCode ?? this.zipCode,
      );

  @override
  int get hashCode => contactId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Contact && runtimeType == other.runtimeType && contactId == other.contactId;
}
