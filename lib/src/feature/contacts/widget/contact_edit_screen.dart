import 'dart:async';

import 'package:contacts_app/src/common/util/snack_bar_util.dart';
import 'package:contacts_app/src/feature/contacts/bloc/contact_bloc.dart';
import 'package:contacts_app/src/feature/contacts/model/address.dart';
import 'package:contacts_app/src/feature/contacts/model/contact.dart';
import 'package:contacts_app/src/feature/contacts/widget/contact_address_flow.dart';
import 'package:contacts_app/src/feature/contacts/widget/contact_edit_buttons.dart';
import 'package:contacts_app/src/feature/contacts/widget/contact_form_field.dart';
import 'package:contacts_app/src/feature/feed/bloc/feed_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// ContactItemScreen widget
class ContactEditScreen extends StatefulWidget {
  const ContactEditScreen({super.key});

  static Contact? getContactOrNull(BuildContext context) =>
      context.findAncestorStateOfType<_ContactEditScreenState>()!.getContactOrNull();

  @override
  State<ContactEditScreen> createState() => _ContactEditScreenState();
}

class _ContactEditScreenState extends State<ContactEditScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = ValueNotifier<List<Address>>(<Address>[]);

  StreamSubscription<ContactState>? _subscription;

  late final ContactBLoC _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ContactBLoC>(context, listen: false);
    _subscription = _bloc.stream.listen(_onStateChanged, cancelOnError: false);
    _onStateChanged(_bloc.state);
  }

  void _onStateChanged(ContactState state) {
    final contact = state.contact;
    _firstNameController.text = contact.firstName;
    _lastNameController.text = contact.lastName ?? '';
    _phoneController.text = contact.phoneNumber;
    _addressController.value = contact.addresses;
  }

  Contact? getContactOrNull() {
    if (_formKey.currentState?.validate() ?? false) {
      return _bloc.state.contact.copyWith(
        addresses: _addressController.value,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        phoneNumber: _phoneController.text,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final title = _bloc.state.contact.firstName.isNotEmpty ? _bloc.state.contact.firstName : 'new';
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact: $title'),
        actions: [
          if (_bloc.state.contact.hasID)
            TextButton(
              onPressed: () => context.go('/contacts/${_bloc.state.contact.contactId}'),
              child: const Text('To view'),
            )
        ],
      ),
      body: BlocListener<ContactBLoC, ContactState>(
        listener: (context, state) => state.mapOrNull(
          successfulCreate: (state) {
            SnackBarUtil.showSnackBarMessage(context, message: state.message);
            BlocProvider.of<FeedBLoC>(context).add(const FeedEvent.fetch());
            context.go('/contacts/${state.contact.contactId}');
          },
          successfulDelete: (state) {
            SnackBarUtil.showSnackBarMessage(context, message: state.message);
            BlocProvider.of<FeedBLoC>(context).add(const FeedEvent.fetch());
            context.pop();
          },
          successfulUpdate: (state) {
            SnackBarUtil.showSnackBarMessage(context, message: state.message);
            BlocProvider.of<FeedBLoC>(context).add(const FeedEvent.fetch());
            context.go('/contacts/${state.contact.contactId}');
          },
        ),
        child: SafeArea(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned.fill(
                    child: ListView(
                      padding: const EdgeInsets.only(bottom: 80),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ContactFormField(
                                textController: _firstNameController,
                                labelText: 'First name *',
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your first name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: ContactFormField(
                                textController: _lastNameController,
                                labelText: 'Last name',
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                              ),
                            )
                          ],
                        ),
                        ContactFormField(
                          textController: _phoneController,
                          labelText: 'Phone *',
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                        ),
                        ContactAddressFlow(controller: _addressController),
                      ],
                    ),
                  ),
                  Positioned(
                    height: 48,
                    bottom: 16,
                    width: MediaQuery.of(context).size.width - 24 * 2,
                    child: const ContactEditButtons(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();

    super.dispose();
  }
}
