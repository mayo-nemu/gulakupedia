import 'package:gulapedia/src/blocs/authentication_bloc/authentication_bloc.dart';

import 'package:user_repository/user_repository.dart';
import 'package:journal_repository/journal_repository.dart';
import 'package:food_repository/food_repository.dart';

import 'package:gulapedia/src/widgets/layout_navbar.dart';
import 'package:gulapedia/src/screens/screens.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:gulapedia/src/utilities/go_router_refresh_stream.dart';

import 'routes_name.dart';

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

      final bool isRootPath = location == '/';
      final bool isAuthPath = location == '/login' || location == '/register';
      final bool isProfileSetupPath = location == '/setup-profil';

      // 1. If authentication status is unknown (e.g., app start), stay on root for splash.
      if (authState.status == AuthenticationStatus.unknown) {
        return isRootPath ? null : '/';
      }

      // 2. If NOT authenticated, redirect to login unless already on an auth path.
      if (!isAuthenticated) {
        return isAuthPath ? null : '/login';
      }

      // 3. If AUTHENTICATED but profile NOT complete, redirect to setup unless already on setup path.
      if (!isProfileComplete) {
        return isProfileSetupPath ? null : '/setup-profil';
      }

      // 4. If fully authenticated and profile complete, and trying to access
      if (isAuthPath || isProfileSetupPath || isRootPath) {
        return '/catatan-harian';
      }

      // 5. Otherwise, allow the current path.
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
        builder: (context, state, navigationShell) {
          return BlocProvider(
            create: (context) => JournalBloc(FirebaseJournalRepo()),
            child: LayoutNavbar(navigationShell: navigationShell),
          );
        },
        branches: [
          // Branch 0: Jurnal (Daily)
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RoutesName.catatanHarian,
                path: '/catatan-harian',
                builder: (context, state) {
                  final parsedDate = _parseDate(state);
                  // Just return the screen; it will find the JournalBloc in the context
                  return CatatanHarianScreen(date: parsedDate);
                },
              ),
            ],
          ),
          // Branch 1: Grafik (Weekly)
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RoutesName.rekapMingguan,
                path: '/rekap-mingguan', // Ensure the leading slash is here
                builder: (context, state) {
                  final parsedDate = _parseDate(state);
                  return RekapMingguanScreen(date: parsedDate);
                },
              ),
            ],
          ), // Branch 2: Profil
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RoutesName.profil,
                path: '/profil',
                builder: (context, state) {
                  MyUser user = context.read<AuthenticationBloc>().state.user!;
                  return ProfileScreen(user: user);
                },
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        name: RoutesName.rekapBulanan,
        path: '/rekap-bulanan',
        builder: (context, state) {
          final String? dateString = state.uri.queryParameters['date'];
          DateTime parsedDate;
          if (dateString != null) {
            parsedDate = DateTime.parse(dateString);
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
        name: RoutesName.pengaturanAkun,
        path: '/pengaturan-akun',
        builder: (context, state) => ProfileOptionScreen(),
        routes: [
          GoRoute(
            name: RoutesName.updatePassword,
            path: 'update-password',
            builder: (context, state) {
              MyUser user = context.read<AuthenticationBloc>().state.user!;
              return UpdatePasswordScreen(user: user);
            },
          ),
          GoRoute(
            name: RoutesName.updateProfil,
            path: 'update-profil',
            builder: (context, state) {
              MyUser user = context.read<AuthenticationBloc>().state.user!;
              return BlocProvider(
                create: (context) => SignUpBloc(FirebaseUserRepo()),
                child: UpdateProfileScreen(user: user),
              );
            },
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

DateTime _parseDate(GoRouterState state) {
  final String? dateString = state.uri.queryParameters['date'];
  if (dateString != null) {
    return DateTime.parse(dateString);
  }
  return DateTime.now();
}
