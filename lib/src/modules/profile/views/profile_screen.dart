import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulapedia/src/modules/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:gulapedia/src/modules/profile/widgets/profile_menu_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state.isSuccess) {}
      },
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 40),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                'assets/images/joseph-gonzalez-unsplash.jpg',
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Farhan Usa',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green[50], // Light green background
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'farhanusa1945@gmail.com',
                style: TextStyle(
                  color: Colors.teal[700], // Darker teal text
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 30),

            // --- Menu Items Section ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  ProfileMenuItem(
                    icon: Icons.settings,
                    text: 'Pengaturan Akun',
                    onTap: () {
                      // Handle tap
                    },
                  ),
                  SizedBox(height: 10), // Spacing between items
                  ProfileMenuItem(
                    icon: Icons.bar_chart,
                    text: 'Laporan',
                    onTap: () {
                      // Handle tap
                    },
                  ),
                  SizedBox(height: 10),
                  ProfileMenuItem(
                    icon: Icons.bookmark,
                    text: 'Resep Tersimpan',
                    onTap: () {
                      // Handle tap
                    },
                  ),
                  SizedBox(height: 10),
                  ProfileMenuItem(
                    icon: Icons.watch_later_outlined, // Or Icons.access_time
                    text: 'Pengingat',
                    onTap: () {
                      // Handle tap
                    },
                  ),
                  SizedBox(height: 10),
                  ProfileMenuItem(
                    icon: Icons.exit_to_app,
                    text: 'Keluar',
                    color: Colors.red, // Red icon for logout
                    onTap: () {
                      // Handle tap
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20), // Bottom padding
          ],
        ),
      ),
    );
  }
}
