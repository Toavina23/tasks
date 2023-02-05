import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0.sp),
          child: child,
        ),
      ),
    );
  }
}
