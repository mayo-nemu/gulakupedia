import 'package:gulapedia/src/theme/t_app_theme.dart';
import 'package:gulapedia/src/routes/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gulapedia/src/blocs/authentication_bloc/authentication_bloc.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router(context.read<AuthenticationBloc>()),
      title: 'Gulakupedia',
      theme: TAppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
