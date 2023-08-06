import 'package:contacts_app/src/feature/contacts/model/address_entity.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ContactEntity {
  int id;

  @Index()
  String contactId;
  String firstName;
  String phoneNumber;
  String? lastName;

  @Backlink()
  final addresses = ToMany<AddressEntity>();

  ContactEntity({
    required this.contactId,
    required this.firstName,
    required this.phoneNumber,
    this.id = 0,
    this.lastName,
  });
}
