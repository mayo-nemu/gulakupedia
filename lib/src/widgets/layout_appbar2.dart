import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LayoutAppbars2 extends StatelessWidget {
  const LayoutAppbars2({
    super.key,
    required this.title,
    this.back,
    this.actions,
    this.bottom,
    required this.child,
    this.bottomNavigationAction,
  });

  final String title;
  final void Function()? back;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final Widget child;
  final Widget? bottomNavigationAction;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        titleSpacing: 21,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shadowColor: Colors.black38,
        // leading: IconButton(
        //   onPressed: () {
        //     if (back != null) {
        //       back!();
        //     } else {
        //       context.pop();
        //     }
        //   },
        //   icon: Icon(Icons.arrow_back),
        // ),
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
