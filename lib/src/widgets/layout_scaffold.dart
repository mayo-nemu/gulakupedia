import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Destination {
  final String label;
  final String assetPath;
  final String selectedAssetPath;
  const Destination({
    required this.label,
    required this.assetPath,
    required this.selectedAssetPath,
  });
}

class LayoutScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  LayoutScaffold({required this.navigationShell, super.key});

  final destinations = [
    Destination(
      label: 'Catatan harian',
      assetPath: 'assets/icons/fluent_book-24-regular.svg',
      selectedAssetPath: 'assets/icons/fluent_book-24-filled.svg',
    ),
    Destination(
      label: 'Resep',
      assetPath: 'assets/icons/solar_chef-hat-linear.svg',
      selectedAssetPath: 'assets/icons/tabler_chef-hat-filled.svg',
    ),
    Destination(
      label: 'Profil',
      assetPath: 'assets/icons/user.svg',
      selectedAssetPath: 'assets/icons/user-filled.svg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(index);
        },
        indicatorColor: Colors.transparent,
        destinations: destinations
            .map(
              (destination) => NavigationDestination(
                label: destination.label,
                icon: SvgPicture.asset(
                  destination.assetPath,
                  width: 32,
                  height: 32,
                ),
                selectedIcon: SvgPicture.asset(
                  destination.selectedAssetPath,
                  width: 32,
                  height: 32,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
