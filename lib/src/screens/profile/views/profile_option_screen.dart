import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gulapedia/src/routes/routes_name.dart';
import 'package:gulapedia/src/widgets/layout_appbar.dart';
import 'package:gulapedia/src/screens/profile/widgets/profile_menu_item.dart';

class ProfileOptionScreen extends StatelessWidget {
  const ProfileOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutAppbar(
      title: 'Pengaturan Akun',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          children: [
            ProfileMenuItem(
              icon: Icons.abc_outlined,
              text: 'Ubah kata sandi',
              onTap: () {
                context.pushNamed(RoutesName.updatePassword);
              },
            ),
            SizedBox(height: 10),
            ProfileMenuItem(
              icon: Icons.abc_outlined,
              text: 'Ubah data profil',
              onTap: () {
                context.pushNamed(RoutesName.updateProfil);
              },
            ),
          ],
        ),
      ),
    );
  }
}
