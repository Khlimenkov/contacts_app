import 'package:contacts_app/src/feature/contacts/model/address.dart';
import 'package:contacts_app/src/feature/contacts/widget/contact_address_input.dart';
import 'package:flutter/material.dart';

/// {@template contact_address_flow}
/// ContactAddressFlow widget
/// {@endtemplate}
class ContactAddressFlow extends StatefulWidget {
  /// {@macro contact_address_flow}
  const ContactAddressFlow({super.key, required this.controller});

  final ValueNotifier<List<Address>> controller;

  @override
  State<ContactAddressFlow> createState() => _ContactAddressFlowState();
}

/// State for widget ContactAddressFlow
class _ContactAddressFlowState extends State<ContactAddressFlow> {
  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(ContactAddressFlow oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Widget configuration changed
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // The configuration of InheritedWidgets has changed
    // Also called after initState but before build
  }

  @override
  void dispose() {
    // Permanent removal of a tree stent
    super.dispose();
  }

  /* #endregion */
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        ValueListenableBuilder<List<Address>>(
          valueListenable: widget.controller,
          builder: (context, value, child) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.controller.value.length,
              itemBuilder: (context, index) {
                final address = value[index];
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'Address ${index + 1}',
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    ContactAddressInput(address: address, onChanged: (address) => onChanged(address, index)),
                    TextButton(
                        onPressed: () => remove(index),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Delete address',
                              style: theme.textTheme.bodyMedium?.apply(color: Colors.red),
                            ),
                            const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ],
                        )),
                  ],
                );
              },
            );
          },
        ),
        TextButton(
          onPressed: add,
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Add address'),
              Icon(Icons.add),
            ],
          ),
        ),
      ],
    );
  }

  void onChanged(Address address, int index) {
    final list = List<Address>.from(widget.controller.value);
    list[index] = address;
    widget.controller.value = list;
  }

  void add() {
    widget.controller.value = [
      ...widget.controller.value,
      const Address(id: 0),
    ];
  }

  void remove(int index) {
    final list = List<Address>.from(widget.controller.value);
    list.removeAt(index);
    widget.controller.value = list;
  }
}
