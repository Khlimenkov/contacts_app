import 'package:contacts_app/src/feature/contacts/model/contact.dart';
import 'package:flutter/material.dart';

/// ContactListItem widget
class ContactListItem extends StatelessWidget {
  final Contact contact;
  final VoidCallback onTap;
  const ContactListItem({
    super.key,
    required this.contact,
    required this.onTap,
  });

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
      onTap: onTap,
    );
  }
}
