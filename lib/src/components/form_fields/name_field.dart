import 'package:flutter/material.dart';
import 'package:gulapedia/src/utilities/form_validation.dart';
import 'base_form_field.dart';

class NameField extends StatelessWidget {
  final TextEditingController controller;
  const NameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BaseFormField(
      controller: controller,
      keyboardType: TextInputType.visiblePassword,
      labelText: 'Nama',
      hintText: 'Masukkan nama anda',
      validator: (value) => InputValidation.validateUsername(value),
    );
  }
}
