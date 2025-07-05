import 'package:flutter/material.dart';

class DropdownOption<T> {
  final String label;
  final T value;

  DropdownOption({required this.label, required this.value});
}

class DropdownPickerField<T> extends StatefulWidget {
  final ValueChanged<T?>? onChanged;
  final List<DropdownOption<T>> options;
  final String labelText;
  final String hintText;
  final T? initialValue;
  final FormFieldValidator<T>? validator;

  const DropdownPickerField({
    super.key,
    required this.options,
    this.onChanged,
    this.labelText = 'Select an option',
    this.hintText = 'Choose...',
    this.initialValue,
    this.validator,
  });

  @override
  State<DropdownPickerField<T>> createState() => _DropdownPickerFieldState<T>();
}

class _DropdownPickerFieldState<T> extends State<DropdownPickerField<T>> {
  T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.labelText,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        DropdownButtonFormField<T>(
          value: _selectedValue,
          hint: Text(widget.hintText),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(width: 1.25, color: Colors.grey),
            ),
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Theme.of(context).colorScheme.primary,
          ),
          isExpanded: true,
          items: widget.options.map((DropdownOption<T> option) {
            return DropdownMenuItem<T>(
              value: option.value,
              child: Text(option.label),
            );
          }).toList(),
          onChanged: (T? newValue) {
            setState(() {
              _selectedValue = newValue;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(newValue);
            }
          },
          validator: widget.validator,
        ),
      ],
    );
  }
}
