import 'package:flutter/material.dart';
import 'base_dropdown_picker_field.dart';

class GenderField extends StatelessWidget {
  final ValueChanged<dynamic>? onChanged;
  final String? initialValue;
  const GenderField({super.key, this.onChanged, this.initialValue});
  final List<DropdownOption> options = const [
    DropdownOption(label: 'Pria', value: 'male'),
    DropdownOption(label: 'Wanita', value: 'female'),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseDropdownPickerField(
      options: options,
      initialValue: initialValue,
      hintText: 'Pria',
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Pilih jenis kelamin Anda';
        }
        return null;
      },
    );
  }
}
