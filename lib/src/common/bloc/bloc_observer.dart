import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l/l.dart';

class LoggBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    l.v6('Bloc | ${bloc.runtimeType} | Created');
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    l.d('Bloc | ${bloc.runtimeType} | ${change.currentState} -> ${change.nextState}');
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    l.w('Bloc | ${bloc.runtimeType} | $error', stackTrace);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    l.v5('Bloc | ${bloc.runtimeType} | Closed');
    super.onClose(bloc);
  }
}
