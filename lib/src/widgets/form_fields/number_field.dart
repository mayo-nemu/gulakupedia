import 'package:flutter/material.dart';
import 'base_text_field.dart';

class NumberField extends StatelessWidget {
  const NumberField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.validator,
  });

  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  @override
  Widget build(BuildContext context) {
    return BaseTextField(
      labelText: labelText,
      hintText: hintText,
      controller: controller,
      keyboardType: TextInputType.number,
      validator: validator,
    );
  }
}
