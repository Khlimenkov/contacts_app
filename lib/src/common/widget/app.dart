import 'package:contacts_app/src/common/router/app_router.dart';
import 'package:contacts_app/src/common/widget/error_screen.dart';
import 'package:contacts_app/src/feature/contacts/data/contact_repository.dart';
import 'package:contacts_app/src/feature/feed/bloc/feed_bloc.dart';
import 'package:contacts_app/src/feature/feed/data/key_value_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// {@template app}
/// App widget.
/// {@endtemplate}
class App extends StatefulWidget {
  /// {@macro app}
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AppRouter _router = AppRouter();
  @override
  Widget build(BuildContext context) => BlocProvider<FeedBLoC>(
        create: (context) => FeedBLoC(
          repository: context.read<ContactRepository>(),
          keyValueRepository: context.read<KeyValueRepository>(),
        )
          ..add(const FeedEvent.init())
          ..add(const FeedEvent.fetch()),
        child: MaterialApp.router(
          title: 'Contacts App',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const <LocalizationsDelegate<Object?>>[
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: View.of(context).platformDispatcher.platformBrightness == Brightness.dark
              ? ThemeData.dark(useMaterial3: true)
              : ThemeData.light(useMaterial3: true),
          routerDelegate: _router.routerDelegate,
          routeInformationParser: _router.routeInformationParser,
          routeInformationProvider: _router.routeInformationProvider,
          supportedLocales: const [Locale('en', 'US')],
          locale: const Locale('en', 'US'),
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: child ?? ErrorScreen(exception: Exception('No child')),
          ),
        ),
      );
}
