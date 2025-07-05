import 'package:flutter/material.dart';
import 'package:gulapedia/src/utilities/form_validation.dart';
import 'base_form_field.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  const PasswordField({
    super.key,
    required this.controller,
    required this.labelText,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return BaseFormField(
      obscureText: _obscureText,
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      labelText: widget.labelText,
      hintText: 'Masukkan password anda',
      suffixIcon: IconButton(
        icon: Icon(
          _obscureText
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ),
      validator: (value) => InputValidation.validatePassword(value),
    );
  }
}
