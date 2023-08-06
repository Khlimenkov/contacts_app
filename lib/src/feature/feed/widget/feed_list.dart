import 'package:contacts_app/src/feature/contacts/model/contact.dart';
import 'package:contacts_app/src/feature/feed/widget/feed_tile.dart';
import 'package:flutter/material.dart';

/// FeedList widget
class FeedList extends StatelessWidget {
  const FeedList({super.key, required this.contactList});

  final List<Contact> contactList;

  @override
  Widget build(BuildContext context) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final contact = contactList[index];
            return FeedTile(
              contact: contact,
            );
          },
          childCount: contactList.length,
        ),
      );
}
