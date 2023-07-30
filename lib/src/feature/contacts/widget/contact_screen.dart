import 'package:contacts_app/src/feature/contacts/bloc/contact_bloc.dart';
import 'package:contacts_app/src/feature/contacts/widget/contact_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widget/radial_progress_indicator.dart';

/// {@template contact_page}
/// ContactPage widget
/// {@endtemplate}
class ContactScreen extends StatelessWidget {
  /// {@macro contact_page}
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Contacts'),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => context.goNamed('NewContact'),
        ),
        body: SafeArea(
          child: BlocBuilder<ContactBLoC, ContactState>(
            builder: (context, state) {
              if (state.isProcessing) {
                return Center(
                  child: RepaintBoundary(
                    child: RadialProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                );
              } else if (!state.hasData) {
                return const Center(
                  child: Text(
                    'No contacts yet.',
                  ),
                );
              }
              final contacts = state.data;
              return ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, idx) {
                    final contact = contacts[idx];
                    return ContactListItem(
                      contact: contact,
                      onTap: () => context.go('/contacts/${contact.contactId}'),
                    );
                  });
            },
          ),
        ),
      );
}
