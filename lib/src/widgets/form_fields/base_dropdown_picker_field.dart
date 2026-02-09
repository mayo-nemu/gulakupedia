import 'package:flutter/material.dart';

class DropdownOption<T> {
  final String label;
  final T value;
  final Widget? extra;

  const DropdownOption({required this.label, required this.value, this.extra});
}

class BaseDropdownPickerField<T> extends StatefulWidget {
  const BaseDropdownPickerField({
    super.key,
    required this.options,
    this.onChanged,
    this.labelText = 'Pilih',
    this.hintText = 'Silahkan memilih',
    this.initialValue,
    this.validator,
  });

  final ValueChanged<T?>? onChanged;
  final List<DropdownOption<T>> options;
  final String labelText;
  final String hintText;
  final T? initialValue;
  final FormFieldValidator<T>? validator;
  @override
  State<BaseDropdownPickerField<T>> createState() =>
      _BaseDropdownPickerFieldState<T>();
}

class _BaseDropdownPickerFieldState<T>
    extends State<BaseDropdownPickerField<T>> {
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
          initialValue: _selectedValue,
          hint: Text(
            widget.hintText,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.black54),
          ),
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 1.25, color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 1.25, color: Colors.grey),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 25.0,
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

              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      option.label,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    if (option.extra != null) ...[option.extra!],
                  ],
                ),
              ),
            );
          }).toList(),
          onChanged: (T? newValue) {
            setState(() {
              _selectedValue = newValue;
            });
            widget.onChanged?.call(newValue);
          },
          validator: widget.validator,
        ),
      ],
    );
  }
}
