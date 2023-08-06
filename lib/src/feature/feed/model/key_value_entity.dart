import 'package:objectbox/objectbox.dart';

@Entity()
class KeyValueEntity {
  int id;

  @Index()
  String key;

  dynamic value;

  KeyValueEntity({
    required this.key,
    this.value,
    this.id = 0,
  });
}
