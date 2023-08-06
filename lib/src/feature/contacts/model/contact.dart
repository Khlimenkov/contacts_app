import 'package:contacts_app/src/feature/contacts/model/address.dart';

class Contact {
  final String contactId;
  final String firstName;
  final String phoneNumber;
  final String? lastName;
  final List<Address> addresses;

  const Contact({
    required this.contactId,
    required this.firstName,
    required this.phoneNumber,
    this.lastName,
    this.addresses = const [],
  });

  bool get hasNotID => contactId.isEmpty;

  bool get hasID => !hasNotID;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        contactId: json['contactId'],
        firstName: json['firstName'],
        phoneNumber: json['phoneNumber'],
        lastName: json['lastName'],
        addresses:
            json['addresses'] != null ? (json['addresses'] as List).map((e) => Address.fromJson(e)).toList() : const [],
      );

  Contact copyWith({
    String? contactId,
    String? firstName,
    String? phoneNumber,
    String? lastName,
    List<Address>? addresses,
  }) =>
      Contact(
        contactId: contactId ?? this.contactId,
        firstName: firstName ?? this.firstName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        lastName: lastName ?? this.lastName,
        addresses: addresses ?? this.addresses,
      );

  @override
  int get hashCode => contactId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Contact && runtimeType == other.runtimeType && contactId == other.contactId;
}
