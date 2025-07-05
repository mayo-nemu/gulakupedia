import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/brands/gulapedia-logo-android.png',
              height: 256,
            ),
            SizedBox(height: 16),
            Text(
              'GULAKUPEDIA',
              style: Theme.of(
                context,
              ).textTheme.displaySmall!.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
