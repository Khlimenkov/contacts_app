import 'dart:async';

import 'package:contacts_app/src/common/database/objectbox/app_database.dart';
import 'package:contacts_app/src/common/util/logger_util.dart';
import 'package:contacts_app/src/common/widget/app.dart';
import 'package:contacts_app/src/feature/contacts/data/concact_storage_data_provider.dart';
import 'package:contacts_app/src/feature/contacts/data/contact_repository.dart';
import 'package:contacts_app/src/feature/feed/data/key_value_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l/l.dart';

import 'src/common/bloc/bloc_observer.dart';

void main() => l.capture<void>(
      () => runZonedGuarded<void>(
        () async {
          WidgetsFlutterBinding.ensureInitialized();
          Bloc.observer = LoggBlocObserver();
          final database = await ObjectBoxDatabase.create();
          runApp(
            MultiRepositoryProvider(
              providers: [
                RepositoryProvider<ContactRepository>(
                  create: (context) => ContactRepositoryImpl(
                    storageDataProvider: ContactObjectBoxDataProvider(
                      database: database,
                    ),
                  ),
                ),
                RepositoryProvider<KeyValueRepository>(
                  create: (context) => KeyValueRepositoryImlp(
                    database: database,
                  ),
                ),
              ],
              child: const App(),
            ),
          );
        },
        l.e,
      ),
      const LogOptions(
        handlePrint: true,
        messageFormatting: LoggerUtil.messageFormatting,
        outputInRelease: false,
        printColors: true,
      ),
    );
