import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LayoutAppbar extends StatelessWidget {
  const LayoutAppbar({
    super.key,
    required this.title,
    this.actions,
    this.bottom,
    required this.child,
    this.bottomNavigationAction,
  });

  final String title;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final Widget child;
  final Widget? bottomNavigationAction;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shadowColor: Colors.black38,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(title, style: Theme.of(context).textTheme.titleSmall),
        actions: actions,
        bottom: bottom,
      ),
      body: child,
      backgroundColor: Theme.of(context).colorScheme.surface,
      bottomNavigationBar: bottomNavigationAction,
    );
  }
}
