import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gulapedia/src/routes/routes_name.dart';
import 'package:gulapedia/src/screens/profile/blocs/profile_settings_bloc/profile_settings_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulapedia/src/widgets/layout_appbar.dart';
import 'package:gulapedia/src/widgets/form_fields/my_form_fields.dart';
import 'package:user_repository/user_repository.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key, required this.user});

  final MyUser user;

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _bloodSugarsController = TextEditingController();
  String? _selectedActivities;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing user data
    _weightController.text = widget.user.weight.toString();
    _heightController.text = widget.user.height.toString();
    _bloodSugarsController.text = widget.user.bloodSugars.toString();
    _selectedActivities = widget.user.activities;
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _bloodSugarsController.dispose();
    super.dispose();
  }

  MyUser? _onSave() {
    if (_formKey.currentState!.validate() && _selectedActivities != null) {
      final double? parsedWeight = double.tryParse(_weightController.text);
      final double? parsedHeight = double.tryParse(_heightController.text);
      final double parsedBloodSugars =
          double.tryParse(_bloodSugarsController.text) ?? 0.0;

      final MyUser myUser = widget.user.copyWith(
        weight: parsedWeight!,
        height: parsedHeight!,
        bloodSugars: parsedBloodSugars,
        activities: _selectedActivities!,
        isProfileComplete: true,
      );

      return myUser;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileSettingsBloc, ProfileSettingsState>(
      listener: (context, state) {
        if (state is ProfileSettingsSuccess) {
          context.goNamed(RoutesName.profil);
        } else if (state is ProfileSettingsFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      child: LayoutAppbar(
        title: 'Perbarui data gula darah',
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                const SizedBox(height: 30),
                NumberField(
                  controller: _weightController,
                  labelText: 'Berat badan (kg)',
                  validator: (value) => InputValidation.validateWeight(value),
                ),
                const SizedBox(height: 30),
                NumberField(
                  controller: _heightController,
                  labelText: 'Tinggi badan (cm)',
                  validator: (value) => InputValidation.validateHeight(value),
                ),
                const SizedBox(height: 30),
                NumberField(
                  controller: _bloodSugarsController,
                  labelText: 'Gula darah saat ini (Opsional)',
                ),
                const SizedBox(height: 30),
                ActivitiesField(
                  initialValue: _selectedActivities,
                  onChanged: (value) {
                    setState(() {
                      _selectedActivities = value;
                    });
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    // final validUser = _onSave();

                    // if (validUser != null) {
                    // }
                  },
                  child: Text(
                    'Simpan',
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge!.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
