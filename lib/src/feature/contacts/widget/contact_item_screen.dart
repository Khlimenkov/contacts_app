import 'package:contacts_app/src/common/util/snack_bar_util.dart';
import 'package:contacts_app/src/feature/contacts/bloc/contact_bloc.dart';
import 'package:contacts_app/src/feature/contacts/model/contact.dart';
import 'package:contacts_app/src/feature/contacts/widget/contact_form_field.dart';
import 'package:contacts_app/src/feature/contacts/widget/contact_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// ContactItemScreen widget
class ContactItemScreen extends StatefulWidget {
  final String? contactId;

  const ContactItemScreen({super.key, this.contactId});

  @override
  State<ContactItemScreen> createState() => _ContactItemScreenState();
}

class _ContactItemScreenState extends State<ContactItemScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _streetAddress1Controller = TextEditingController();
  final _streetAddress2Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();

  late final Contact contact;

  late bool isReadOnly;

  @override
  void initState() {
    super.initState();
    if (widget.contactId != null) {
      isReadOnly = true;
      _intitalizeControllers(ContactScope.of(context).state);
    } else {
      isReadOnly = false;
      contact = Contact.withGenId(firstName: '', phoneNumber: '');
    }
  }

  void _intitalizeControllers(ContactState state) {
    final contact = state.data.firstWhere(
      (element) => element.contactId == widget.contactId,
    );
    this.contact = contact;
    _firstNameController.text = contact.firstName;
    _lastNameController.text = contact.lastName ?? '';
    _cityController.text = contact.city ?? '';
    _phoneController.text = contact.phoneNumber;
    _streetAddress1Controller.text = contact.streetAddress1 ?? '';
    _streetAddress2Controller.text = contact.streetAddress2 ?? '';
    _stateController.text = contact.state ?? '';
    _zipCodeController.text = contact.zipCode ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        key: ValueKey(contact.contactId),
        appBar: AppBar(
          title: const Text('Contact'),
          actions: [
            if (widget.contactId != null)
              TextButton(
                onPressed: () => setState(() => isReadOnly = !isReadOnly),
                child: Text(isReadOnly ? 'Edit' : 'Cancel'),
              ),
          ],
        ),
        body: BlocListener<ContactBLoC, ContactState>(
          listener: (context, state) => state.mapOrNull(successfulCreate: (state) {
            SnackBarUtil.showSnackBarMessage(context, message: state.message);
            context.go('/contacts/${contact.contactId}');
          }, successfulDelete: (state) {
            SnackBarUtil.showSnackBarMessage(context, message: state.message);
            context.pop();
          }, successfulUpdate: (state) {
            SnackBarUtil.showSnackBarMessage(context, message: state.message);
            setState(() => isReadOnly = true);
          }),
          child: SafeArea(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ContactFormField(
                            textController: _firstNameController,
                            isReadOnly: isReadOnly,
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
                            isReadOnly: isReadOnly,
                            labelText: 'Last name',
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                          ),
                        )
                      ],
                    ),
                    ContactFormField(
                      textController: _phoneController,
                      isReadOnly: isReadOnly,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ContactFormField(
                            textController: _streetAddress1Controller,
                            isReadOnly: isReadOnly,
                            labelText: 'Street Address 1',
                            keyboardType: TextInputType.streetAddress,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ContactFormField(
                            textController: _streetAddress2Controller,
                            isReadOnly: isReadOnly,
                            labelText: 'Street Address 2',
                            keyboardType: TextInputType.streetAddress,
                            textInputAction: TextInputAction.next,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ContactFormField(
                            textController: _cityController,
                            isReadOnly: isReadOnly,
                            labelText: 'City',
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ContactFormField(
                            textController: _stateController,
                            isReadOnly: isReadOnly,
                            labelText: 'State',
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ),
                        )
                      ],
                    ),
                    ContactFormField(
                      textController: _zipCodeController,
                      isReadOnly: isReadOnly,
                      labelText: 'Zip code',
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                    ),
                    if (!isReadOnly) ...[
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final newContact = contact.copyWith(
                                firstName: _firstNameController.text,
                                lastName: _lastNameController.text,
                                phoneNumber: _phoneController.text,
                                streetAddress1: _streetAddress1Controller.text,
                                streetAddress2: _streetAddress2Controller.text,
                                city: _cityController.text,
                                state: _stateController.text,
                                zipCode: _zipCodeController.text,
                              );
                              if (widget.contactId != null) {
                                ContactScope.of(context).add(ContactEvent.update(contact: newContact));
                              } else {
                                ContactScope.of(context).add(ContactEvent.create(contact: newContact));
                              }
                            }
                          },
                          child: const Text('Save'),
                        ),
                      ),
                      if (widget.contactId != null)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              ContactScope.of(context).add(ContactEvent.delete(contactId: widget.contactId!));
                            },
                            child: const Text('Remove'),
                          ),
                        ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _streetAddress1Controller.dispose();
    _streetAddress2Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }
}
