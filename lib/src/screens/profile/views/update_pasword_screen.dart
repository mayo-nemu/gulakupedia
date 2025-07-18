import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gulapedia/src/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:gulapedia/src/routes/routes_name.dart';
import 'package:gulapedia/src/screens/profile/blocs/profile_settings_bloc/profile_settings_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulapedia/src/widgets/layout_appbar.dart';
import 'package:gulapedia/src/widgets/form_fields/my_form_fields.dart';
import 'package:user_repository/user_repository.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key, required this.user});

  final MyUser user;

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileSettingsBloc>(
      create: (context) => ProfileSettingsBloc(
        context.read<AuthenticationBloc>().userRepository,
      ),
      child: BlocListener<ProfileSettingsBloc, ProfileSettingsState>(
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
                  const SizedBox(height: 15),
                  PasswordField(
                    controller: _oldPasswordController,
                    labelText: 'Kata sandi',
                  ),
                  const SizedBox(height: 15),
                  PasswordField(
                    controller: _newPasswordController,
                    labelText: 'Kata sandi baru',
                  ),
                  const SizedBox(height: 15),
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
      ),
    );
  }
}
