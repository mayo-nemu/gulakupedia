import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LayoutScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const LayoutScaffold({required this.navigationShell, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: navigationShell.goBranch,
        indicatorColor: Theme.of(context).colorScheme.primary,
        destinations: destinations
            .map(
              (destination) => NavigationDestination(
                label: destination.label,
                icon: SvgPicture.asset(
                  destination.assetPath,
                  width: 28,
                  height: 28,
                  colorFilter: const ColorFilter.mode(
                    Colors.black54,
                    BlendMode.srcIn,
                  ),
                ),
                selectedIcon: SvgPicture.asset(
                  destination.assetPath,
                  width: 28,
                  height: 28,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

const destinations = [
  Destination(
    label: 'Catatan harian',
    assetPath: 'assets/icons/fluent_book-24-regular.svg',
  ),
  Destination(
    label: 'Resep',
    assetPath: 'assets/icons/solar_chef-hat-linear.svg',
  ),
  Destination(label: 'Profil', assetPath: 'assets/icons/person.svg'),
];

class Destination {
  final String label;
  final String assetPath;
  const Destination({required this.label, required this.assetPath});
}
