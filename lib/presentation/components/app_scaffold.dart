import 'package:flutter/material.dart';

class AppScafold extends StatelessWidget {
  const AppScafold({super.key, required this.child, this.appBar});
  final Widget child;
  final PreferredSizeWidget? appBar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: child,
      ),
    );
  }
}
