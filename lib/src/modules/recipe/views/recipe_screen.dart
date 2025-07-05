import 'package:flutter/material.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                'Coming Soon',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(color: Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
