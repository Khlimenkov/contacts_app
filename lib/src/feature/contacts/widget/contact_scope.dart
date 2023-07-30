import 'package:contacts_app/src/feature/contacts/bloc/contact_bloc.dart';
import 'package:contacts_app/src/feature/dependencies/widget/dependencies_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// ContactScope widget
class ContactScope extends StatelessWidget {
  const ContactScope({super.key, required this.child});
  final Widget child;

  static ContactBLoC of(BuildContext context, {bool listen = false}) =>
      BlocProvider.of<ContactBLoC>(context, listen: listen);

  @override
  Widget build(BuildContext context) => BlocProvider<ContactBLoC>(
        create: (context) => ContactBLoC(
          repository: DependenciesScope.of(context).contactRepository,
        )..add(const ContactEvent.fetch()),
        child: child,
      );
}
