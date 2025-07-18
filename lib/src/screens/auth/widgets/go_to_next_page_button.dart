import 'package:flutter/material.dart';

class GoToNextPageButton extends StatelessWidget {
  final String leadingText;
  final String trailingText;
  final VoidCallback onPressed;

  const GoToNextPageButton({
    super.key,
    required this.leadingText,
    required this.trailingText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(leadingText, style: Theme.of(context).textTheme.bodyMedium),
        TextButton(
          onPressed: onPressed,
          child: Text(
            trailingText,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
