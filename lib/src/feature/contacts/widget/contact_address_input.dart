import 'package:contacts_app/src/feature/contacts/model/address.dart';
import 'package:contacts_app/src/feature/contacts/widget/contact_form_field.dart';
import 'package:flutter/material.dart';

/// ContactAddressForm widget
class ContactAddressInput extends StatefulWidget {
  const ContactAddressInput({super.key, required this.address, required this.onChanged});

  final Address address;
  final void Function(Address) onChanged;

  @override
  State<ContactAddressInput> createState() => _ContactAddressInputState();
}

/// State for widget ContactAddressForm
class _ContactAddressInputState extends State<ContactAddressInput> {
  final _streetAddress1Controller = TextEditingController();
  final _streetAddress2Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();

  Address getAddress() {
    return Address(
      id: widget.address.id,
      city: _cityController.text.isNotEmpty ? _cityController.text : null,
      state: _stateController.text.isNotEmpty ? _stateController.text : null,
      streetAddress1: _streetAddress1Controller.text.isNotEmpty ? _streetAddress1Controller.text : null,
      streetAddress2: _streetAddress2Controller.text.isNotEmpty ? _streetAddress2Controller.text : null,
      zipCode: _zipCodeController.text.isNotEmpty ? _zipCodeController.text : null,
    );
  }

  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    _cityController.text = widget.address.city ?? '';
    _stateController.text = widget.address.state ?? '';
    _streetAddress1Controller.text = widget.address.streetAddress1 ?? '';
    _streetAddress2Controller.text = widget.address.streetAddress2 ?? '';
    _zipCodeController.text = widget.address.zipCode ?? '';
  }

  @override
  void dispose() {
    _streetAddress1Controller.dispose();
    _streetAddress2Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }
  /* #endregion */

  @override
  Widget build(BuildContext context) => Form(
        key: ValueKey(widget.address.hashCode),
        onChanged: () => widget.onChanged(getAddress()),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ContactFormField(
                    textController: _streetAddress1Controller,
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
                    labelText: 'State',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                )
              ],
            ),
            ContactFormField(
              textController: _zipCodeController,
              labelText: 'Zip code',
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
            ),
          ],
        ),
      );
}
