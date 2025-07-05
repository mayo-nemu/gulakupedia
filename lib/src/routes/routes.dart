import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:gulapedia/src/modules/auth/views/sign_in_screen.dart';
import 'package:gulapedia/src/modules/auth/views/sign_up_screen.dart';
import 'package:gulapedia/src/modules/auth/views/profile_setup_screen.dart';
import 'package:gulapedia/src/modules/profile/views/profile_screen.dart';
import 'package:gulapedia/src/modules/journal/views/catatan_harian_screen.dart';
import 'package:gulapedia/src/components/layout_scaffold.dart';

import 'package:gulapedia/src/modules/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:gulapedia/src/modules/auth/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:gulapedia/src/blocs/authentication_bloc/authentication_bloc.dart';

final _navKey = GlobalKey<NavigatorState>();
// final _shellNavigationKey = GlobalKey<NavigatorState>();

GoRouter router(AuthenticationBloc authBloc) {
  return GoRouter(
    navigatorKey: _navKey,
    initialLocation: '/sign-in',
    redirect: (context, state) {
      if (authBloc.state.isUnknown) {
        return '/sign-in';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/sign-in',
        builder: (context, state) => BlocProvider<SignInBloc>(
          create: (context) {
            return SignInBloc(
              context.read<AuthenticationBloc>().userRepository,
            );
          },
          child: SignInScreen(),
        ),
      ),
      GoRoute(
        path: '/sign-up',
        builder: (context, state) => BlocProvider<SignUpBloc>(
          create: (context) {
            return SignUpBloc(
              context.read<AuthenticationBloc>().userRepository,
            );
          },
          child: SignUpScreen(),
        ),
      ),
      GoRoute(
        path: '/profile-setup',
        builder: (context, state) => BlocProvider<SignUpBloc>(
          create: (context) {
            return SignUpBloc(
              context.read<AuthenticationBloc>().userRepository,
            );
          },
          child: ProfileSetupScreen(),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            LayoutScaffold(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/catatan-harian',
                builder: (context, state) => const CatatanHarianScreen(),
              ),
              GoRoute(
                path: '/resep',
                builder: (context, state) => CatatanHarianScreen(),
              ),
              GoRoute(
                path: '/profil',
                builder: (context, state) => BlocProvider<SignInBloc>(
                  create: (context) {
                    return SignInBloc(
                      context.read<AuthenticationBloc>().userRepository,
                    );
                  },
                  child: ProfileScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
