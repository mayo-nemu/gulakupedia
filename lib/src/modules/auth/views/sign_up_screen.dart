import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gulapedia/src/modules/auth/widgets/go_to_next_page_button.dart';
import 'package:gulapedia/src/components/form_fields/name_field.dart';
import 'package:gulapedia/src/components/form_fields/email_field.dart';
import 'package:gulapedia/src/components/form_fields/password_field.dart';
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
    // Dispose all controllers to prevent memory leaks
    passwordController.dispose();
    emailController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.isSuccess) {
          context.go('/profile-setup');
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

                  NameField(controller: nameController),

                  Spacer(flex: 1),

                  EmailField(controller: emailController),

                  Spacer(flex: 1),

                  PasswordField(
                    labelText: 'Kata sandi',
                    controller: passwordController,
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
                              MyUser myUser = MyUser.empty().copyWith(
                                email: emailController.text,
                                name: nameController.text,
                              );
                              context.read<SignUpBloc>().add(
                                SignUpEvent.signUpRequired(
                                  myUser,
                                  passwordController.text,
                                ),
                              );
                            }
                          },
                          child: Text(
                            'Buat Akun',
                            style: Theme.of(context).textTheme.labelLarge!
                                .copyWith(color: Colors.white),
                          ),
                        );
                      }
                    },
                  ),
                  Spacer(flex: 4),

                  GoToNextPageButton(
                    onPressed: () => context.go('/sign-in'),
                    leadingText: 'Sudah punya akun?',
                    trailingText: 'Masuk',
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
