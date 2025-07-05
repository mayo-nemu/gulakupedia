import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gulapedia/src/modules/auth/widgets/go_to_next_page_button.dart';
import 'package:gulapedia/src/components/form_fields/email_field.dart';
import 'package:gulapedia/src/components/form_fields/password_field.dart';
import 'package:gulapedia/src/modules/auth/blocs/sign_in_bloc/sign_in_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
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

                  EmailField(controller: emailController),

                  Spacer(flex: 1),

                  PasswordField(
                    labelText: 'Kata sandi',
                    controller: passwordController,
                  ),

                  Spacer(flex: 1),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Lupa kata sandi?',
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                decoration: TextDecoration.underline,
                              ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(flex: 1),

                  BlocBuilder<SignInBloc, SignInState>(
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
                              context.read<SignInBloc>().add(
                                SignInEvent.signInRequired(
                                  emailController.text,
                                  passwordController.text,
                                ),
                              );
                            }
                          },
                          child: Text(
                            'Masuk',
                            style: Theme.of(context).textTheme.labelLarge!
                                .copyWith(color: Colors.white),
                          ),
                        );
                      }
                    },
                  ),
                  Spacer(flex: 4),

                  GoToNextPageButton(
                    onPressed: () => context.go('/sign-up'),
                    leadingText: 'Belum punya akun?',
                    trailingText: 'buat akun',
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
