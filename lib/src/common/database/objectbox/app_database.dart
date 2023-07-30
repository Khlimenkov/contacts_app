import 'package:contacts_app/objectbox.g.dart';
import 'package:contacts_app/src/feature/contacts/model/contact_entity.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ObjectBoxDatabase {
  /// The Store of this app.
  late final Store store;

  late final Box<ContactEntity> contactBox;

  ObjectBoxDatabase._create(this.store) {
    contactBox = store.box<ContactEntity>();
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBoxDatabase> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: p.join(docsDir.path, "obx-db"));
    return ObjectBoxDatabase._create(store);
  }
}
