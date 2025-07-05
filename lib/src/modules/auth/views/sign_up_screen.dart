import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'package:gulapedia/src/widgets/form_fields/name_field.dart';
import 'package:gulapedia/src/widgets/form_fields/email_field.dart';
import 'package:gulapedia/src/widgets/form_fields/password_field.dart';
import 'package:gulapedia/src/modules/auth/widgets/go_to_next_page_button.dart';
import 'package:gulapedia/src/routes/app_routes.dart';

import 'package:gulapedia/src/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:gulapedia/src/modules/auth/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:user_repository/user_repository.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    nameController.dispose();
    super.dispose();
  }

  MyUser? _onSave() {
    if (_formKey.currentState!.validate()) {
      MyUser myUser = MyUser.empty().copyWith(
        email: emailController.text,
        name: nameController.text,
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
          if (state.isSuccess) {
            if (state.myUser != null) {
              context.go(AppRoutes.setupProfil, extra: state.myUser);
            }
          } else if (state.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Authentication Error: ${state.errorMessage}'),
              ),
            );
          }
        },

        builder: (context, state) {
          return Scaffold(
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
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        'Selamat datang!',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),

                      Spacer(flex: 2),

                      NameField(controller: nameController),

                      Spacer(flex: 1),

                      EmailField(controller: emailController),

                      Spacer(flex: 1),

                      PasswordField(
                        labelText: 'Kata sandi',
                        controller: passwordController,
                      ),

                      Spacer(flex: 2),

                      ElevatedButton(
                        onPressed: () {
                          final validUser = _onSave();

                          if (validUser != null) {
                            final password = passwordController.text;
                            context.read<SignUpBloc>().add(
                              SignUpEvent.signUpRequired(validUser, password),
                            );
                            context.read<SignUpBloc>().add(
                              SignUpEvent.updateProfile(validUser),
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
                      Spacer(flex: 4),

                      GoToNextPageButton(
                        onPressed: () => context.go(AppRoutes.login),
                        leadingText: 'Sudah punya akun?',
                        trailingText: 'Masuk',
                      ),
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
