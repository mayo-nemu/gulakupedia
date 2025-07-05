import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'base_form_field.dart';

class BirthdayField extends StatefulWidget {
  final TextEditingController controller;

  const BirthdayField({super.key, required this.controller});

  @override
  State<BirthdayField> createState() => _BirthdayFieldState();
}

class _BirthdayFieldState extends State<BirthdayField> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final String formattedDate = DateFormat(
        'dd - MM - yyyy',
      ).format(pickedDate);
      widget.controller.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseFormField(
      controller: widget.controller,
      readOnly: true,
      onTap: () => _selectDate(context),
      labelText: 'Tanggal lahir',
      hintText: '01-01-2001',
      suffixIcon: Icon(
        Icons.calendar_today,
        color: Theme.of(context).colorScheme.primary,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Pilih tanggal lahir Anda';
        }
        return null;
      },
    );
  }
}
