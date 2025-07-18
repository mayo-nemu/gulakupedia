// src/routes/routes.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulapedia/src/screens/food/views/food_confirmation_screen.dart';
import 'package:gulapedia/src/screens/food/views/food_details_screen.dart';
import 'package:gulapedia/src/screens/food/views/food_search_screen.dart';
import 'package:gulapedia/src/screens/journal/views/rekap_bulanan_screen.dart';
import 'package:gulapedia/src/screens/meal/views/meal_screen.dart';
import 'package:gulapedia/src/screens/profile/views/profile_option_screen.dart';
import 'package:gulapedia/src/screens/profile/views/update_pasword_screen.dart';
import 'package:gulapedia/src/screens/profile/views/update_profile_screen.dart';

import 'package:gulapedia/src/widgets/splash_screen.dart';
import 'package:gulapedia/src/screens/auth/views/sign_in_screen.dart';
import 'package:gulapedia/src/screens/auth/views/sign_up_screen.dart';
import 'package:gulapedia/src/screens/auth/views/profile_setup_screen.dart';
import 'package:gulapedia/src/widgets/layout_scaffold.dart';
import 'package:gulapedia/src/screens/journal/views/catatan_harian_screen.dart';
import 'package:gulapedia/src/screens/recipe/views/recipe_screen.dart';
import 'package:gulapedia/src/screens/profile/views/profile_screen.dart';

import 'package:gulapedia/src/utilities/go_router_refresh_stream.dart';
import 'package:gulapedia/src/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:gulapedia/src/routes/routes_name.dart';
import 'package:journal_repository/journal_repository.dart';
import 'package:user_repository/user_repository.dart';

GoRouter router(AuthenticationBloc authBloc) {
  return GoRouter(
    initialLocation: '/',
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) {
      final authState = authBloc.state;
      final String location = state.matchedLocation;

      final bool isAuthenticated =
          authState.status == AuthenticationStatus.authenticated;
      final bool isProfileComplete = authState.isProfileComplete;

      // Public routes (accessible to anyone)
      final bool isRootPath = location == '/';
      final bool isAuthPath = location == '/login' || location == '/register';
      final bool isProfileSetupPath = location == '/setup-profil';

      // --- Redirection Logic ---

      // 1. If authentication status is unknown (e.g., app start), allow splash screen.
      if (authState.status == AuthenticationStatus.unknown) {
        return isRootPath ? null : '/';
      }

      // 2. If NOT authenticated
      if (!isAuthenticated) {
        return isAuthPath ? null : '/login';
      }

      // 3. If AUTHENTICATED but profile NOT complete
      if (!isProfileComplete) {
        return isProfileSetupPath ? null : '/setup-profil';
      }

      // 4. If AUTHENTICATED and profile COMPLETE
      if (isAuthPath || isProfileSetupPath || isRootPath) {
        return '/catatan-harian';
      }

      // 5. If fully authenticated and profile complete, allow navigation to any path.
      return null;
    },
    routes: [
      GoRoute(
        name: RoutesName.root,
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),

      GoRoute(
        name: RoutesName.login,
        path: '/login',
        builder: (context, state) => const SignInScreen(),
      ),

      GoRoute(
        name: RoutesName.register,
        path: '/register',
        builder: (context, state) => const SignUpScreen(),
      ),

      GoRoute(
        name: RoutesName.setupProfil,
        path: '/setup-profil',
        builder: (context, state) {
          MyUser user = context.read<AuthenticationBloc>().state.user!;
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
                name: RoutesName.catatanHarian,
                path: '/catatan-harian',
                builder: (context, state) {
                  MyUser user = context.read<AuthenticationBloc>().state.user!;
                  final String? dateString = state.uri.queryParameters['date'];
                  DateTime parsedDate;
                  if (dateString != null) {
                    try {
                      parsedDate = DateTime.parse(dateString);
                    } catch (e) {
                      parsedDate = DateTime.now();
                    }
                  } else {
                    parsedDate = DateTime.now();
                  }

                  return CatatanHarianScreen(
                    userId: user.userId,
                    date: parsedDate,
                  );
                },
                routes: [
                  GoRoute(
                    name: RoutesName.rekapBulanan,
                    path: 'rekap-bulanan',
                    builder: (context, state) {
                      MyUser user = context
                          .read<AuthenticationBloc>()
                          .state
                          .user!;
                      final String? dateString =
                          state.uri.queryParameters['date'];
                      DateTime parsedDate;
                      if (dateString != null) {
                        try {
                          parsedDate = DateTime.parse(dateString);
                        } catch (e) {
                          parsedDate = DateTime.now();
                        }
                      } else {
                        parsedDate = DateTime.now();
                      }

                      return CatatanBulananScreen(
                        userId: user.userId,
                        date: parsedDate,
                      );
                    },
                  ),
                  GoRoute(
                    name: RoutesName.rekapMingguan,
                    path: 'rekap-mingguan',
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
                name: RoutesName.resep,
                path: '/resep',
                builder: (context, state) => const RecipeScreen(),
              ),
            ],
          ),
          // Branch 2: Profil
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RoutesName.profil,
                path: '/profil',
                builder: (context, state) {
                  MyUser user = context.read<AuthenticationBloc>().state.user!;
                  return ProfileScreen(user: user);
                },
                routes: [
                  GoRoute(
                    name: RoutesName.pengaturanAkun,
                    path: 'pengaturan-akun',
                    builder: (context, state) => ProfileOptionScreen(),
                    routes: [
                      GoRoute(
                        name: RoutesName.updatePassword,
                        path: 'update-password',
                        builder: (context, state) {
                          MyUser user = context
                              .read<AuthenticationBloc>()
                              .state
                              .user!;
                          return UpdatePasswordScreen(user: user);
                        },
                      ),
                      GoRoute(
                        name: RoutesName.updateProfil,
                        path: 'update-profil',
                        builder: (context, state) {
                          MyUser user = context
                              .read<AuthenticationBloc>()
                              .state
                              .user!;
                          return UpdateProfileScreen(user: user);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        name: RoutesName.asupan,
        path: '/:journalId/asupan',
        builder: (context, state) {
          MyUser user = context.read<AuthenticationBloc>().state.user!;
          final String journalId = state.pathParameters['journalId']!;
          final String mealName = state.uri.queryParameters['mealName']!;
          final Map<String, dynamic>? extraData =
              state.extra as Map<String, dynamic>?;
          final double? sugarsGoal = extraData?['sugarsGoal'] as double?;
          final double? sugarsTotal = extraData?['sugarsTotal'] as double?;
          return MealScreen(
            userId: user.userId,
            journalId: journalId,
            mealName: mealName,
            sugarsGoal: sugarsGoal ?? 30,
            sugarsTotal: sugarsTotal ?? 0,
          );
        },
        routes: [
          GoRoute(
            name: RoutesName.tambahMenu,
            path: ':mealId/tambah-menu',
            builder: (context, state) {
              final String journalId = state.pathParameters['journalId']!;
              final String mealId = state.pathParameters['mealId']!;
              final String mealName = state.uri.queryParameters['mealName']!;
              return FoodSearchScreen(
                journalId: journalId,
                mealId: mealId,
                mealName: mealName,
              );
            },
            routes: [
              GoRoute(
                name: RoutesName.konfirmasiMenu,
                path: 'konfirmasi-menu',
                builder: (context, state) {
                  final List<Food> foods = state.extra as List<Food>;
                  MyUser user = context.read<AuthenticationBloc>().state.user!;
                  final String journalId = state.pathParameters['journalId']!;
                  final String mealId = state.pathParameters['mealId']!;
                  return FoodConfirmationScreen(
                    userId: user.userId,
                    journalId: journalId,
                    mealId: mealId,
                    foods: foods,
                  );
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        name: RoutesName.makanan,
        path: '/makanan',
        builder: (context, state) {
          final Food food = state.extra as Food;
          return FoodDetailsScreen(food: food);
        },
      ),
    ],
    debugLogDiagnostics: true,
  );
}
