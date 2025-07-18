import 'package:flutter/material.dart';
import 'base_text_field.dart';

import 'package:gulapedia/src/utilities/form_validation.dart';

class NameField extends StatelessWidget {
  final TextEditingController controller;
  const NameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BaseTextField(
      controller: controller,
      keyboardType: TextInputType.name,
      labelText: 'Nama',
      hintText: 'Masukkan nama anda',
      validator: (value) => InputValidation.validateUsername(value),
    );
  }
}
