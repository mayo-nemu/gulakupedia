import 'package:flutter/material.dart';
import 'base_form_field.dart';

class NumberField extends StatelessWidget {
  const NumberField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.validator,
  });

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final FormFieldValidator<String>? validator;
  @override
  Widget build(BuildContext context) {
    return BaseFormField(
      labelText: labelText,
      hintText: hintText,
      controller: controller,
      keyboardType: TextInputType.number,
      validator: validator,
    );
  }
}
