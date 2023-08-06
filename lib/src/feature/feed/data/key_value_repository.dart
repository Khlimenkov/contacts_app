import 'package:contacts_app/objectbox.g.dart';
import 'package:contacts_app/src/common/database/objectbox/app_database.dart';
import 'package:contacts_app/src/feature/feed/model/key_value_entity.dart';

abstract interface class KeyValueRepository {
  dynamic getValue(String key);
  void setValue(String key, dynamic value);
  bool containsKey(String key);
}

class KeyValueRepositoryImlp implements KeyValueRepository {
  final ObjectBoxDatabase _database;
  KeyValueRepositoryImlp({
    required ObjectBoxDatabase database,
  }) : _database = database;

  @override
  dynamic getValue(String key) async {
    final entity = _database.keyValueBox.query(KeyValueEntity_.key.equals(key)).build().findUnique();
    if (entity != null) {
      return entity.value;
    } else {
      throw Exception('No key found');
    }
  }

  @override
  void setValue(String key, dynamic value) async {
    final entity = _database.keyValueBox.query(KeyValueEntity_.key.equals(key)).build().findUnique();
    final newEntity = KeyValueEntity(
      key: key,
      value: value,
      id: entity?.id ?? 0,
    );
    _database.keyValueBox.put(newEntity);
  }

  @override
  bool containsKey(String key) {
    final entity = _database.keyValueBox.query(KeyValueEntity_.key.equals(key)).build().findUnique();
    return entity != null;
  }
}
