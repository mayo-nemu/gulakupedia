import 'package:flutter/material.dart';

class MealInfoCard extends StatelessWidget {
  const MealInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(child: Column(children: [Divider()]));
  }
}

class MealItem extends StatelessWidget {
  final VoidCallback onPressed;

  const MealItem({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(),
      title: Text(''),
      subtitle: Text(''),
      trailing: IconButton(
        onPressed: onPressed,
        icon: Icon(
          Icons.add_circle,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
