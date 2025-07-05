import 'package:flutter/material.dart';
import 'package:gulapedia/src/utilities/form_validation.dart';
import 'base_form_field.dart';

class NumberField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  const NumberField({
    super.key,
    required this.controller,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return BaseFormField(
      labelText: labelText,
      controller: controller,
      keyboardType: TextInputType.number,
      validator: (value) => InputValidation.validateUsername(value),
    );
  }
}
