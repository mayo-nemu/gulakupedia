import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'package:gulapedia/src/widgets/form_fields/email_field.dart';
import 'package:gulapedia/src/widgets/form_fields/password_field.dart';
import 'package:gulapedia/src/screens/auth/widgets/go_to_next_page_button.dart';
import 'package:gulapedia/src/routes/routes_name.dart';

import 'package:gulapedia/src/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:gulapedia/src/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';

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
    return BlocProvider<SignInBloc>(
      create: (context) =>
          SignInBloc(context.read<AuthenticationBloc>().userRepository),
      child: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            context.goNamed(RoutesName.catatanHarian);
          } else if (state is SignInFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },

        builder: (context, state) => Scaffold(
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

                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<SignInBloc>().add(
                            SignInRequired(
                              emailController.text,
                              passwordController.text,
                            ),
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
                      onPressed: () => context.goNamed(RoutesName.register),
                      leadingText: 'Belum punya akun?',
                      trailingText: 'buat akun',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
