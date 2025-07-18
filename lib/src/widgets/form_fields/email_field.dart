import 'package:flutter/material.dart';
import 'base_text_field.dart';

import 'package:gulapedia/src/utilities/form_validation.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  const EmailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BaseTextField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      labelText: 'Email',
      hintText: 'Masukkan alamat email anda',
      validator: (value) => InputValidation.validateEmail(value),
    );
  }
}
