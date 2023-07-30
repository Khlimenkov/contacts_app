import 'package:contacts_app/src/common/database/objectbox/app_database.dart';
import 'package:contacts_app/src/feature/contacts/data/contact_repository.dart';

abstract interface class Dependencies {
  abstract final ContactRepository contactRepository;

  abstract final ObjectBoxDatabase database;
}
