// import 'dart:async';
// import 'dart:convert';

// import 'package:contacts_app/objectbox.g.dart';
// import 'package:contacts_app/src/common/bloc/bloc_observer.dart';
// import 'package:contacts_app/src/common/database/objectbox/app_database.dart';
// import 'package:contacts_app/src/feature/contacts/data/concact_storage_data_provider.dart';
// import 'package:contacts_app/src/feature/contacts/data/contact_repository.dart';
// import 'package:contacts_app/src/feature/contacts/model/contact.dart';
// import 'package:contacts_app/src/feature/contacts/model/contact_mapper.dart';
// import 'package:contacts_app/src/feature/dependencies/model/dependencies.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:l/l.dart';
// import 'package:meta/meta.dart';

// typedef _InitializationStep = FutureOr<void> Function(_MutableDependencies dependencies);

// class _MutableDependencies implements Dependencies {
//   @override
//   late ContactRepository contactRepository;

//   @override
//   late ObjectBoxDatabase database;
// }

// @internal
// mixin InitializeDependencies {
//   /// Initializes the app and returns a [Dependencies] object
//   @protected
//   Future<Dependencies> initializeDependencies({
//     void Function(int progress, String message)? onProgress,
//   }) async {
//     final steps = _initializationSteps;
//     final dependencies = _MutableDependencies();
//     final totalSteps = steps.length;
//     for (var currentStep = 0; currentStep < totalSteps; currentStep++) {
//       final step = steps[currentStep];
//       final percent = (currentStep * 100 ~/ totalSteps).clamp(0, 100);
//       onProgress?.call(percent, step.$1);
//       l.v6('Initialization | $currentStep/$totalSteps ($percent%) | "${step.$1}"');
//       await step.$2(dependencies);
//     }
//     return dependencies;
//   }

//   List<(String, _InitializationStep)> get _initializationSteps => <(String, _InitializationStep)>[
//         (
//           'Observer state managment',
//           (_) => Bloc.observer = LoggBlocObserver(),
//         ),
//         (
//           'Initialize database',
//           (dependencies) async => dependencies.database = await ObjectBoxDatabase.create(),
//         ),
//         (
//           'Initialize data',
//           (dependencies) async {
//             final database = dependencies.database;
//             final isEmptyDb = database.contactBox.isEmpty();
//             if (isEmptyDb) {
//               final jsonString = await rootBundle.loadString('assets/contacts.json');
//               final json = jsonDecode(jsonString) as List;
//               final objects = json.map((e) => Contact.fromJson(e).toContactEntity()).toList();
//               database.contactBox.putMany(objects, mode: PutMode.insert);
//             }
//           },
//         ),
//         (
//           'Initialize contact repository',
//           (dependencies) => dependencies.contactRepository = ContactRepositoryImpl(
//                   storageDataProvider: ContactObjectBoxDataProvider(
//                 database: dependencies.database,
//               )),
//         ),
//       ];
// }
