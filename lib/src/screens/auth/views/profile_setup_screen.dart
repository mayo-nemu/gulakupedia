import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:gulapedia/src/widgets/form_fields/my_form_fields.dart';
import 'package:gulapedia/src/routes/routes_name.dart';

import 'package:gulapedia/src/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:gulapedia/src/screens/auth/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:user_repository/user_repository.dart';

class ProfileSetupScreen extends StatefulWidget {
  final MyUser user;
  const ProfileSetupScreen({super.key, required this.user});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _birthdayController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _bloodSugarsController = TextEditingController();

  String? _selectedGender;
  String? _selectedActivities;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _bloodSugarsController.dispose();
    super.dispose();
  }

  MyUser? _onSave() {
    if (_formKey.currentState!.validate() &&
        _selectedGender != null &&
        _selectedActivities != null) {
      final double? parsedWeight = double.tryParse(_weightController.text);
      final double? parsedHeight = double.tryParse(_heightController.text);
      final double? parsedBloodSugars = double.tryParse(
        _bloodSugarsController.text,
      );

      final DateTime parsedBirthday = DateFormat(
        'dd - MM - yyyy',
      ).parseStrict(_birthdayController.text);

      final MyUser myUser = widget.user.copyWith(
        birthday: parsedBirthday,
        gender: _selectedGender!,
        weight: parsedWeight!,
        height: parsedHeight!,
        bloodSugars: parsedBloodSugars!,
        activities: _selectedActivities!,
        isProfileComplete: true,
      );

      return myUser;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (context) =>
          SignUpBloc(context.read<AuthenticationBloc>().userRepository),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            context.goNamed(RoutesName.catatanHarian);
          } else if (state is SignUpFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 25,
                  horizontal: 30,
                ),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      const SizedBox(height: 25),
                      Text(
                        'Mulai perjalanan kontrol gula Anda',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        ' Isi data diri Anda',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 20),
                      BirthdayField(controller: _birthdayController),
                      GenderField(
                        initialValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                      ),
                      const SizedBox(height: 15),
                      NumberField(
                        controller: _weightController,
                        labelText: 'Berat badan (kg)',
                        hintText: '80kg',
                        validator: (value) =>
                            InputValidation.validateWeight(value),
                      ),
                      const SizedBox(height: 15),
                      NumberField(
                        controller: _heightController,
                        labelText: 'Tinggi badan (cm)',
                        hintText: '168cm',
                        validator: (value) =>
                            InputValidation.validateHeight(value),
                      ),
                      const SizedBox(height: 15),
                      NumberField(
                        controller: _bloodSugarsController,
                        labelText: 'Gula darah saat ini',
                        hintText: '90 mg/dL',
                        validator: (value) =>
                            InputValidation.validateBloodSugars(value),
                      ),
                      const SizedBox(height: 15),
                      ActivitiesField(
                        initialValue: _selectedActivities,
                        onChanged: (value) {
                          setState(() {
                            _selectedActivities = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          final validUser = _onSave();

                          if (validUser != null) {
                            context.read<SignUpBloc>().add(
                              ProfileSetupRequired(validUser),
                            );
                          }
                        },
                        child: Text(
                          'Simpan',
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge!.copyWith(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
