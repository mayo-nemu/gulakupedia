import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulapedia/src/components/form_fields/date_picker_field.dart';
import 'package:gulapedia/src/components/form_fields/dropdown_picker_field.dart';
import 'package:gulapedia/src/components/form_fields/number_field.dart';

import 'package:gulapedia/src/modules/auth/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:user_repository/user_repository.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final birthdayController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final bloodSugarsController = TextEditingController();

  String? _selectedGender;
  String? _selectedActivities;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    birthdayController.dispose();
    weightController.dispose();
    heightController.dispose();
    bloodSugarsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.isSuccess) {
          context.go('/catatan-harian');
        } else if (state.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Authentication Error: ${state.errorMessage}'),
            ),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Spacer(flex: 1),
                  Text(
                    'Masuk ke akun Anda',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    'Selamat datang!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),

                  Spacer(flex: 2),

                  DatePickerField(controller: birthdayController),
                  Spacer(flex: 1),

                  DropdownPickerField(
                    labelText: 'Jenis kelamin',
                    hintText: 'Pilih jenis kelamin',
                    initialValue: _selectedGender, // Pass initial value
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                    options: [
                      DropdownOption(label: 'Pria', value: 'male'),
                      DropdownOption(label: 'Wanita', value: 'female'),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Pilih jenis kelamin Anda';
                      }
                      return null;
                    },
                  ),
                  Spacer(flex: 1),

                  NumberField(
                    controller: weightController,
                    labelText: 'Berat badan (kg)',
                  ),
                  Spacer(flex: 1),

                  NumberField(
                    controller: heightController,
                    labelText: 'Tinggi bada (cm)',
                  ),
                  Spacer(flex: 1),

                  NumberField(
                    controller: heightController,
                    labelText: 'Gula darah saat ini',
                  ),
                  Spacer(flex: 1),

                  DropdownPickerField(
                    labelText: 'Kegiatan harian',
                    hintText: 'Pilih jenis aktivitas',
                    initialValue: _selectedActivities, // Pass initial value
                    onChanged: (value) {
                      setState(() {
                        _selectedActivities = value;
                      });
                    },

                    options: [
                      DropdownOption(label: 'Sedentari', value: 'sedentary'),
                      DropdownOption(
                        label: 'Aktif Ringan',
                        value: 'lightly active',
                      ),
                      DropdownOption(
                        label: 'Cukup Aktif',
                        value: 'fairly active',
                      ),
                      DropdownOption(label: 'Aktif', value: 'active'),
                      DropdownOption(
                        label: 'Sangat Aktif',
                        value: 'very active',
                      ),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Pilih tingkat aktivitas Anda';
                      }
                      return null;
                    },
                  ),
                  Spacer(flex: 2),

                  BlocBuilder<SignUpBloc, SignUpState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return SizedBox(
                          width: 24.0,
                          height: 24.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        );
                      } else {
                        return ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final double? parsedWeight = double.tryParse(
                                weightController.text,
                              );
                              final double? parsedHeight = double.tryParse(
                                heightController.text,
                              );
                              final double? parsedBloodSugars = double.tryParse(
                                bloodSugarsController.text,
                              );

                              final DateTime parsedBirthday = DateFormat(
                                'dd - MM - yyyy',
                              ).parseStrict(birthdayController.text);
                              MyUser myUser = MyUser.empty().copyWith(
                                birthday: parsedBirthday,
                                gender: _selectedGender!,
                                weight: parsedWeight!,
                                height: parsedHeight!,
                                bloodSugars: parsedBloodSugars!,
                                activities: _selectedActivities!,
                              );

                              context.read<SignUpBloc>().add(
                                SignUpEvent.updateProfile(myUser),
                              );
                            }
                          },
                          child: Text(
                            'Simpan',
                            style: Theme.of(context).textTheme.labelLarge!
                                .copyWith(color: Colors.white),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
