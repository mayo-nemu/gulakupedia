import 'package:flutter/material.dart';
import 'base_dropdown_picker_field.dart';

class ActivitiesField extends StatelessWidget {
  final ValueChanged<dynamic>? onChanged;
  final String? initialValue;
  const ActivitiesField({super.key, this.onChanged, this.initialValue});
  final List<DropdownOption> options = const [
    DropdownOption(label: 'Sedentari', value: 'sedentary'),
    DropdownOption(label: 'Aktif Ringan', value: 'lightly active'),
    DropdownOption(label: 'Cukup Aktif', value: 'fairly active'),
    DropdownOption(label: 'Aktif', value: 'active'),
    DropdownOption(label: 'Sangat Aktif', value: 'very active'),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseDropdownPickerField(
      options: options,
      initialValue: initialValue,
      hintText: 'Aktif',
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Pilih tingkat aktivitas Anda';
        }
        return null;
      },
    );
  }
}
