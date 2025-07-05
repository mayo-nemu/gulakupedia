// src/routes/routes.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gulapedia/src/widgets/splash_screen.dart';
import 'package:gulapedia/src/modules/auth/views/sign_in_screen.dart';
import 'package:gulapedia/src/modules/auth/views/sign_up_screen.dart';
import 'package:gulapedia/src/modules/auth/views/profile_setup_screen.dart';
import 'package:gulapedia/src/widgets/layout_scaffold.dart';
import 'package:gulapedia/src/modules/journal/views/catatan_harian_screen.dart';
import 'package:gulapedia/src/modules/recipe/views/recipe_screen.dart';
import 'package:gulapedia/src/modules/profile/views/profile_screen.dart';

import 'package:gulapedia/src/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:gulapedia/src/routes/app_routes.dart';
import 'package:user_repository/user_repository.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }
  late final StreamSubscription<dynamic> _subscription;
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

GoRouter router(AuthenticationBloc authBloc) {
  return GoRouter(
    initialLocation: AppRoutes.root,
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) {
      final authState = authBloc.state;
      final isAuthenticated = authState.isAuthenticated;
      final isProfileComplete =
          authState.userOrNull?.isProfileComplete ?? false;

      final String location = state.matchedLocation;
      final bool isInitializing = location == AppRoutes.root;
      final bool isSigningIn = location == AppRoutes.login;
      final bool isSigningUp = location == AppRoutes.register;
      final bool isSettingUpProfile = location == AppRoutes.setupProfil;

      final bool isAuthRelatedPath =
          isInitializing || isSigningIn || isSigningUp || isSettingUpProfile;

      final bool isProtectedAppPath =
          AppRoutes.protectedPaths.contains(location) ||
          location.startsWith(AppRoutes.catatanHarian) ||
          location.startsWith(AppRoutes.resep) ||
          location.startsWith(AppRoutes.profil) ||
          location.startsWith(AppRoutes.asupan);

      if (authState.isUnknown) {
        return null;
      }

      // 2. Not Authenticated
      if (!isAuthenticated) {
        return isAuthRelatedPath ? null : AppRoutes.login;
      }

      // 3. Authenticated but Profile Not Complete
      if (!isProfileComplete) {
        if (isSettingUpProfile) {
          return null;
        }
        return AppRoutes.setupProfil;
      }

      // 4. Authenticated and Profile Complete
      // If user tries to go to login, register, or profile setup screens,
      // redirect them to the main authenticated app (e.g., catatanHarian).
      if (isAuthRelatedPath) {
        return AppRoutes.catatanHarian;
      }

      // 5. Allow all other protected app paths if authenticated and profile complete.
      if (isProtectedAppPath) {
        return null;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.root,
        builder: (context, state) => const SplashScreen(),
      ),

      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const SignInScreen(),
      ),

      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const SignUpScreen(),
      ),

      GoRoute(
        path: AppRoutes.setupProfil,
        builder: (context, state) {
          MyUser? user = state.extra as MyUser?;
          if (user == null) {
            user = context.read<AuthenticationBloc>().state.userOrNull;
            debugPrint(
              'MyUser extra was null, retrieved user from AuthenticationBloc: ${user?.userId}',
            );
          }
          if (user == null) {
            debugPrint(
              'Error: MyUser is null from both extra and AuthenticationBloc when navigating to /profile-setup',
            );
            return const SignInScreen();
          }
          return ProfileSetupScreen(user: user);
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            LayoutScaffold(navigationShell: navigationShell),
        branches: [
          // Branch 0: Catatan Harian
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.catatanHarian,
                builder: (context, state) => const CatatanHarianScreen(),
                routes: [
                  GoRoute(
                    path: AppRoutes.rekapBulanan,
                    builder: (context, state) => Placeholder(),
                  ),
                  GoRoute(
                    path: AppRoutes.rekapMingguan,
                    builder: (context, state) => Placeholder(),
                  ),
                ],
              ),
            ],
          ),
          // Branch 1: Resep
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.resep,
                builder: (context, state) => const RecipeScreen(),
              ),
            ],
          ),
          // Branch 2: Profil
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profil,
                builder: (context, state) => ProfileScreen(),
                routes: [
                  GoRoute(
                    path: AppRoutes.updatePassword,
                    builder: (context, state) => Placeholder(),
                  ),
                  GoRoute(
                    path: AppRoutes.updateProfil,
                    builder: (context, state) => Placeholder(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.asupan,
        builder: (context, state) => Placeholder(),
        routes: [
          GoRoute(
            path: AppRoutes.tambahMenu,
            builder: (context, state) => Placeholder(),
          ),
          GoRoute(
            path: AppRoutes.konfirmasiMenu,
            builder: (context, state) => Placeholder(),
          ),
        ],
      ),
    ],
    debugLogDiagnostics: true,
  );
}
