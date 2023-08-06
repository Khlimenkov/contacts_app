import 'package:contacts_app/src/feature/contacts/bloc/contact_bloc.dart';
import 'package:contacts_app/src/feature/contacts/data/contact_repository.dart';
import 'package:contacts_app/src/feature/contacts/model/contact.dart';
import 'package:contacts_app/src/feature/feed/bloc/feed_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// ContactViewScreen widget
class ContactViewScreen extends StatelessWidget {
  final String contactId;
  const ContactViewScreen({super.key, required this.contactId});

  @override
  Widget build(BuildContext context) => BlocProvider<ContactBLoC>(
        create: (context) => ContactBLoC(
          repository: RepositoryProvider.of<ContactRepository>(context),
          contact: BlocProvider.of<FeedBLoC>(context).state.data.firstWhere(
                (element) => element.contactId == contactId,
                orElse: () => Contact(contactId: contactId, firstName: '', phoneNumber: ''),
              ),
        ),
        child: BlocBuilder<ContactBLoC, ContactState>(
          buildWhen: (previous, current) => previous.contact.contactId != current.contact.contactId,
          builder: (context, state) {
            final contact = state.contact;
            return Scaffold(
              appBar: AppBar(
                title: Text('Contact: ${contact.firstName}'),
                actions: [
                  TextButton(
                    onPressed: () => context.go('/contacts/edit/${contact.contactId}'),
                    child: const Text('Edit'),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact Information',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'First name: ${contact.firstName}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        'Last name: ${contact.lastName ?? ''}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        'Phone number: ${contact.phoneNumber}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Addresses',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8.0),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: contact.addresses.length,
                        itemBuilder: (context, index) {
                          final address = contact.addresses[index];
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Address ${index + 1}',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    'Street Address 1: ${address.streetAddress1 ?? ''}',
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    'Street Address 2: ${address.streetAddress2 ?? ''}',
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    'City: ${address.city ?? ''}',
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    'State: ${address.state ?? ''}',
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    'ZipCode: ${address.zipCode ?? ''}',
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
}
