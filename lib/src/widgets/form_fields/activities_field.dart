import 'package:flutter/material.dart';
import 'base_dropdown_picker_field.dart';

class ActivitiesField extends StatelessWidget {
  final ValueChanged<dynamic>? onChanged;
  final String? initialValue;
  ActivitiesField({super.key, this.onChanged, this.initialValue});

  @override
  Widget build(BuildContext context) {
    List<DropdownOption> options = [
      DropdownOption(
        label: 'Sedentari',
        value: 'sedentary',
        extra: _buildInfo(
          context,
          description:
              'Hampir tidak melakukan aktivitas fisik, sebagian besar waktu dihabiskan dengan duduk atau berbaring.',
        ),
      ),
      DropdownOption(
        label: 'Aktif Ringan',
        value: 'lightly active',
        extra: _buildInfo(
          context,
          description:
              'Melakukan aktivitas fisik ringan, seperti berjalan kaki, pekerjaan rumah tangga ringan, atau aktivitas sehari-hari ringan, 1–3 hari/minggu.',
        ),
      ),
      DropdownOption(
        label: 'Cukup Aktif',
        value: 'moderately active',
        extra: _buildInfo(
          context,
          description:
              'Melakukan aktivitas fisik ringan hingga sedang, seperti berjalan cepat, naik turun tangga, pekerjaan rumah tangga sedang, atau aktivitas harian aktif, 4–5 hari/minggu.',
        ),
      ),
      DropdownOption(
        label: 'Aktif',
        value: 'very active',
        extra: _buildInfo(
          context,
          description:
              'Aktivitas fisik sedang sampai berat, seperti pekerjaan fisik atau aktivitas harian yang banyak gerak, 6–7 hari/minggu.',
        ),
      ),
      DropdownOption(
        label: 'Sangat Aktif',
        value: 'extremely active',
        extra: _buildInfo(
          context,
          description:
              'Aktivitas fisik berat secara rutin, termasuk pekerjaan berat atau aktivitas intens sepanjang minggu.',
        ),
      ),
    ];

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

  Widget _buildInfo(BuildContext context, {required String description}) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(),
              content: Text(description),
            );
          },
        );
      },
      icon: Icon(Icons.info),
    );
  }
}
