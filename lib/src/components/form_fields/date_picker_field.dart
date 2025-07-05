import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'base_form_field.dart';

class DatePickerField extends StatefulWidget {
  final TextEditingController controller;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const DatePickerField({
    required this.controller,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    super.key,
  });

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  /// Shows the date picker dialog and updates the text field with the selected date.
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.initialDate ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: widget.lastDate ?? DateTime(2100),
    );

    if (pickedDate != null) {
      // Format the date as 'DD - MM - YYYY'
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
      suffixIcon: Icon(
        Icons.calendar_today,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
