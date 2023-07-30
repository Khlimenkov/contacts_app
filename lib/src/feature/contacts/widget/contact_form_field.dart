import 'package:flutter/material.dart';

/// ContactFormField widget
class ContactFormField extends StatelessWidget {
  /// {@macro contact_form_field}
  const ContactFormField({
    super.key,
    required this.textController,
    required this.isReadOnly,
    required this.labelText,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
  });

  final TextEditingController textController;
  final bool isReadOnly;
  final String labelText;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) => TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        validator: validator,
        readOnly: isReadOnly,
        controller: textController,
      );
}
