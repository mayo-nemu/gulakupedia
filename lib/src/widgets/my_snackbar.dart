import 'package:flutter/material.dart';

class MySnackbar {
  static void show(
    BuildContext context,
    String message, {
    Color backgroundColor = Colors.red,
    Duration duration = const Duration(seconds: 3),
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    BorderRadiusGeometry? borderRadius,
    EdgeInsetsGeometry? margin,
    Widget? icon,
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (icon != null) ...[icon, const SizedBox(width: 16)],
            Expanded(
              child: Text(
                message,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: behavior,
        shape: borderRadius != null
            ? RoundedRectangleBorder(borderRadius: borderRadius)
            : null,
        margin: margin,
        action: actionLabel != null
            ? SnackBarAction(
                label: actionLabel,
                textColor: Colors.amberAccent,
                onPressed: () {
                  ScaffoldMessenger.of(
                    context,
                  ).hideCurrentSnackBar(); // Hide the current snackbar before action
                  onActionPressed?.call(); // Call the provided action callback
                },
              )
            : null,
      ),
    );
  }
}
