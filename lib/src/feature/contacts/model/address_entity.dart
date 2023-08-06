import 'package:contacts_app/src/feature/contacts/model/contact_entity.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class AddressEntity {
  int id;

  String? streetAddress1;
  String? streetAddress2;
  String? city;
  String? state;
  String? zipCode;

  final contact = ToOne<ContactEntity>();

  AddressEntity({
    this.id = 0,
    this.city,
    this.state,
    this.streetAddress1,
    this.streetAddress2,
    this.zipCode,
  });
}
