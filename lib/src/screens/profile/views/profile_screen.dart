import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'package:gulapedia/src/screens/profile/widgets/profile_menu_item.dart';
import 'package:user_repository/user_repository.dart';
import 'package:gulapedia/src/routes/routes_name.dart';

import 'package:gulapedia/src/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:gulapedia/src/screens/profile/blocs/profile_settings_bloc/profile_settings_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.user});

  final MyUser user;

  @override
  Widget build(BuildContext context) {
    // The BlocProvider and BlocListener should wrap the entire widget tree
    // where the bloc needs to be accessed, including the Scaffold.
    return BlocProvider<ProfileSettingsBloc>(
      create: (context) => ProfileSettingsBloc(
        context.read<AuthenticationBloc>().userRepository,
      ),
      child: BlocConsumer<ProfileSettingsBloc, ProfileSettingsState>(
        listener: (context, state) {
          if (state is ProfileSettingsSuccess) {
            context.goNamed(RoutesName.root);
          }
        },
        builder: (context, state) => Scaffold(
          body: Column(
            children: [
              // --- Profile Avatar Section ---
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    const SizedBox(height: 55),
                    const CircleAvatar(
                      radius: 55,
                      backgroundImage: AssetImage(
                        'assets/images/joseph-gonzalez-unsplash.jpg',
                      ),
                    ),
                    const SizedBox(height: 21),
                    Text(
                      user.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 13),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 21,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(21),
                      ),
                      child: Text(
                        user.email,
                        style: TextStyle(
                          letterSpacing: 0.9,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 34),
                  ],
                ),
              ),

              // --- Menu Items Section ---
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 21,
                  vertical: 55,
                ),
                child: Column(
                  children: [
                    ProfileMenuItem(
                      icon: Icons.person_outline,
                      text: 'Akun & Data Diri',
                      onTap: () {
                        context.pushNamed(RoutesName.pengaturanAkun);
                      },
                    ),
                    const SizedBox(height: 13),
                    ProfileMenuItem(
                      icon: Icons.lock_outline,
                      text: 'Privasi',
                      onTap: () {
                        context.pushNamed(RoutesName.rekapMingguan);
                      },
                    ),
                    const SizedBox(height: 13),
                    ProfileMenuItem(
                      icon: Icons.calendar_month_outlined,
                      text: 'Kalender Gula',
                      onTap: () {
                        context.goNamed(RoutesName.resep);
                      },
                    ),
                    const SizedBox(height: 13),
                    ProfileMenuItem(
                      icon: Icons.watch_later_outlined,
                      text: 'Pengingat',
                      onTap: () {
                        // Handle tap
                      },
                    ),
                    const SizedBox(height: 21),
                    ProfileMenuItem(
                      icon: Icons.exit_to_app,
                      text: 'Keluar Akun',
                      color: Colors.red,
                      onTap: () {
                        context.read<ProfileSettingsBloc>().add(
                          SignOutRequired(),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
