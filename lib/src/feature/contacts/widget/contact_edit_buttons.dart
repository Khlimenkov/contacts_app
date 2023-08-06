import 'package:contacts_app/src/feature/contacts/bloc/contact_bloc.dart';
import 'package:contacts_app/src/feature/contacts/widget/contact_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactEditButtons extends StatelessWidget {
  const ContactEditButtons({super.key});

  @override
  Widget build(BuildContext context) => const SizedBox(
        height: 48,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: 48,
                child: _PrimaryButton(),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 48,
                child: _RemoveButton(),
              ),
            ),
          ],
        ),
      );
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton();

  @override
  Widget build(BuildContext context) => BlocBuilder<ContactBLoC, ContactState>(
        builder: (context, state) => state.maybeMap<Widget>(
          orElse: () => const SizedBox.shrink(),
          processing: (state) => const ElevatedButton(
            onPressed: null,
            child: Text('Update'),
          ),
          idle: (state) {
            if (state.contact.hasNotID) {
              return ElevatedButton(
                onPressed: () => _create(context),
                child: const Text('Create'),
              );
            }
            return ElevatedButton(
              onPressed: () => _update(context),
              child: const Text('Update'),
            );
          },
        ),
      );

  void _create(BuildContext context) {
    final contact = ContactEditScreen.getContactOrNull(context);
    if (contact == null) {
      return;
    }
    BlocProvider.of<ContactBLoC>(context).add(ContactEvent.create(contact: contact));
  }

  void _update(BuildContext context) {
    final contact = ContactEditScreen.getContactOrNull(context);
    if (contact == null) {
      return;
    }
    BlocProvider.of<ContactBLoC>(context).add(ContactEvent.update(contact: contact));
  }
}

class _RemoveButton extends StatelessWidget {
  const _RemoveButton();

  @override
  Widget build(BuildContext context) => BlocBuilder<ContactBLoC, ContactState>(
        builder: (context, state) => state.maybeMap<Widget>(
          orElse: () => const SizedBox.shrink(),
          processing: (state) => const ElevatedButton(
            onPressed: null,
            child: Text('Remove'),
          ),
          idle: (state) {
            if (state.contact.hasID) {
              return ElevatedButton(
                onPressed: () => _remove(context),
                child: const Text('Remove'),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      );

  void _remove(BuildContext context) {
    final contact = ContactEditScreen.getContactOrNull(context);
    if (contact == null) {
      return;
    }
    BlocProvider.of<ContactBLoC>(context).add(ContactEvent.delete(contactId: contact.contactId));
  }
}
