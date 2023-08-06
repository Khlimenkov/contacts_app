import 'package:contacts_app/src/feature/contacts/model/contact.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// FeetTile widget
class FeedTile extends StatelessWidget {
  final Contact contact;
  const FeedTile({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = contact.lastName != null ? '${contact.firstName} ${contact.lastName}' : contact.firstName;
    return ListTile(
      title: Text(
        title,
        style: theme.textTheme.titleMedium,
      ),
      subtitle: Text(
        contact.phoneNumber,
        style: theme.textTheme.bodyMedium,
      ),
      onTap: () => context.go('/contacts/${contact.contactId}'),
    );
  }
}
