// src/routes/routes.dart
import 'package:food_repository/food_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulapedia/src/screens/auth/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:gulapedia/src/screens/food/blocs/food_save_bloc/food_save_bloc.dart';
import 'package:gulapedia/src/screens/food/blocs/food_search_bloc/food_search_bloc.dart';
import 'package:gulapedia/src/screens/food/views/barcode_scanner_screen.dart';
import 'package:gulapedia/src/screens/food/views/food_confirmation_screen.dart';
import 'package:gulapedia/src/screens/food/views/food_details_screen.dart';
import 'package:gulapedia/src/screens/food/views/food_search_screen.dart';
import 'package:gulapedia/src/screens/journal/blocs/journal_bloc/journal_bloc.dart';
import 'package:gulapedia/src/screens/journal/views/rekap_bulanan_screen.dart';
import 'package:gulapedia/src/screens/journal/views/rekap_mingguan_screen.dart';
import 'package:gulapedia/src/screens/meal/blocs/meal_bloc.dart';
import 'package:gulapedia/src/screens/meal/views/meal_screen.dart';
import 'package:gulapedia/src/screens/profile/views/profile_option_screen.dart';
import 'package:gulapedia/src/screens/profile/views/update_pasword_screen.dart';
import 'package:gulapedia/src/screens/profile/views/update_profile_screen.dart';

import 'package:gulapedia/src/widgets/splash_screen.dart';
import 'package:gulapedia/src/screens/auth/views/sign_in_screen.dart';
import 'package:gulapedia/src/screens/auth/views/sign_up_screen.dart';
import 'package:gulapedia/src/screens/auth/views/profile_setup_screen.dart';
import 'package:gulapedia/src/widgets/layout_navbar.dart';
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
      final authState = authBloc.state; // Get the current state of the bloc
      final String location = state.matchedLocation;

      // === CRITICAL DEBUG PRINTS ===
      print('GoRouter Redirect Debug: Current Location: $location');
      print('GoRouter Redirect Debug: Auth Status: ${authState.status}');
      print(
        'GoRouter Redirect Debug: Is Authenticated: ${authState.status == AuthenticationStatus.authenticated}',
      );
      print(
        'GoRouter Redirect Debug: Is Profile Complete: ${authState.isProfileComplete}',
      );
      // ===========================

      final bool isAuthenticated =
          authState.status == AuthenticationStatus.authenticated;
      final bool isProfileComplete = authState.isProfileComplete;

      final bool isRootPath = location == '/';
      final bool isAuthPath = location == '/login' || location == '/register';
      final bool isProfileSetupPath = location == '/setup-profil';

      // 1. If authentication status is unknown (e.g., app start), stay on root for splash.
      if (authState.status == AuthenticationStatus.unknown) {
        print(
          'GoRouter Redirect Debug: Rule 1 (Unknown) applied. Redirecting to /',
        );
        return isRootPath ? null : '/';
      }

      // 2. If NOT authenticated, redirect to login unless already on an auth path.
      if (!isAuthenticated) {
        print(
          'GoRouter Redirect Debug: Rule 2 (Not Authenticated) applied. Redirecting to /login',
        );
        return isAuthPath ? null : '/login';
      }

      // --- From here, isAuthenticated is TRUE ---

      // 3. If AUTHENTICATED but profile NOT complete, redirect to setup unless already on setup path.
      if (!isProfileComplete) {
        print(
          'GoRouter Redirect Debug: Rule 3 (Profile Not Complete) applied. Redirecting to /setup-profil.',
        );
        return isProfileSetupPath ? null : '/setup-profil';
      }

      // --- From here, isAuthenticated is TRUE and isProfileComplete is TRUE ---

      // 4. If fully authenticated and profile complete, and trying to access
      //    auth/setup/root paths, redirect to the main app dashboard.
      if (isAuthPath || isProfileSetupPath || isRootPath) {
        print(
          'GoRouter Redirect Debug: Rule 4 (Fully Authenticated & Complete) applied. Redirecting from $location to /catatan-harian.',
        );
        return '/catatan-harian';
      }

      // 5. Otherwise, allow the current path.
      print(
        'GoRouter Redirect Debug: Rule 5 (Allow Current Path) applied. Allowing navigation to $location.',
      );
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
            LayoutNavbar(navigationShell: navigationShell),
        branches: [
          // Branch 0: Catatan Harian
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RoutesName.catatanHarian,
                path: '/catatan-harian',
                builder: (context, state) {
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

                  return BlocProvider(
                    create: (context) => JournalBloc(FirebaseJournalRepo()),
                    child: CatatanHarianScreen(date: parsedDate),
                  );
                },
                routes: [
                  GoRoute(
                    name: RoutesName.rekapBulanan,
                    path: 'rekap-bulanan',
                    builder: (context, state) {
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

                      return BlocProvider(
                        create: (context) => JournalBloc(FirebaseJournalRepo()),
                        child: RekapBulananScreen(date: parsedDate),
                      );
                    },
                  ),
                  GoRoute(
                    name: RoutesName.rekapMingguan,
                    path: 'rekap-mingguan',
                    builder: (context, state) {
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

                      return BlocProvider(
                        create: (context) => JournalBloc(FirebaseJournalRepo()),
                        child: RekapMingguanScreen(date: parsedDate),
                      );
                    },
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
                          return BlocProvider(
                            create: (context) => SignUpBloc(FirebaseUserRepo()),
                            child: UpdateProfileScreen(user: user),
                          );
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
          final double sugarsGoal = extraData?['sugarsGoal'] as double;
          final double sugarsTotal = extraData?['sugarsTotal'] as double;
          return BlocProvider(
            create: (context) =>
                MealBloc(FirebaseJournalRepo())
                  ..add(GetThisMeal(user.userId, journalId, mealName)),
            child: MealScreen(
              journalId: journalId,
              mealName: mealName,
              sugarsGoal: sugarsGoal,
              sugarsTotal: sugarsTotal,
            ),
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
              final String? barcode = state.uri.queryParameters['barcode'];
              final Map<String, dynamic>? extraData =
                  state.extra as Map<String, dynamic>?;
              final double sugarsGoal = extraData?['sugarsGoal'] as double;
              final double sugarsTotal = extraData?['sugarsTotal'] as double;

              return BlocProvider(
                create: (context) => FoodSearchBloc(OpenFoodFactsRepository()),
                child: FoodSearchScreen(
                  journalId: journalId,
                  mealId: mealId,
                  mealName: mealName,
                  barcode: barcode,
                  sugarsGoal: sugarsGoal,
                  sugarsTotal: sugarsTotal,
                ),
              );
            },
            routes: [
              GoRoute(
                name: RoutesName.scanBarcode,
                path: 'scan-barcode',
                builder: (context, state) {
                  final String journalId = state.pathParameters['journalId']!;
                  final String mealId = state.pathParameters['mealId']!;
                  final String mealName =
                      state.uri.queryParameters['mealName']!;
                  final Map<String, dynamic>? extraData =
                      state.extra as Map<String, dynamic>?;
                  final double sugarsGoal = extraData?['sugarsGoal'] as double;
                  final double sugarsTotal =
                      extraData?['sugarsTotal'] as double;

                  return BarcodeScannerScreen(
                    journalId: journalId,
                    mealId: mealId,
                    mealName: mealName,
                    sugarsGoal: sugarsGoal,
                    sugarsTotal: sugarsTotal,
                  );
                },
              ),
              GoRoute(
                name: RoutesName.konfirmasiMenu,
                path: 'konfirmasi-menu',
                builder: (context, state) {
                  final String journalId = state.pathParameters['journalId']!;
                  final String mealId = state.pathParameters['mealId']!;
                  final String mealName =
                      state.uri.queryParameters['mealName']!;

                  final Map<String, dynamic>? extraData =
                      state.extra as Map<String, dynamic>?;
                  final double sugarsGoal = extraData?['sugarsGoal'] as double;
                  final double sugarsTotal =
                      extraData?['sugarsTotal'] as double;
                  final List<Food> foods = extraData?['foods'] as List<Food>;
                  return BlocProvider(
                    create: (context) => FoodSaveBloc(FirebaseJournalRepo()),
                    child: FoodConfirmationScreen(
                      journalId: journalId,
                      mealId: mealId,
                      mealName: mealName,
                      sugarsGoal: sugarsGoal,
                      sugarsTotal: sugarsTotal,
                      foods: foods,
                    ),
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
