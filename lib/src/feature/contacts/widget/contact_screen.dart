import 'package:contacts_app/src/feature/contacts/bloc/contact_bloc.dart';
import 'package:contacts_app/src/feature/contacts/data/contact_repository.dart';
import 'package:contacts_app/src/feature/contacts/model/contact.dart';
import 'package:contacts_app/src/feature/contacts/widget/contact_edit_screen.dart';
import 'package:contacts_app/src/feature/feed/bloc/feed_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// ContactPage widget
class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key, this.contactId});

  final String? contactId;

  @override
  Widget build(BuildContext context) {
    final id = contactId;
    if (id == null) {
      return BlocProvider<ContactBLoC>(
        create: (context) => ContactBLoC.creation(
          repository: RepositoryProvider.of<ContactRepository>(context),
        ),
        child: const ContactEditScreen(),
      );
    }
    return BlocProvider<ContactBLoC>(
      create: (context) => ContactBLoC(
        repository: RepositoryProvider.of<ContactRepository>(context),
        contact: BlocProvider.of<FeedBLoC>(context).state.data.firstWhere(
              (element) => element.contactId == contactId,
              orElse: () => Contact(contactId: id, firstName: '', phoneNumber: ''),
            ),
      ),
      child: const ContactEditScreen(),
    );
  }
}
