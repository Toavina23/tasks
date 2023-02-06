import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tasks/presentation/theme/app_colors.dart';

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  final _borderRadius = BorderRadius.circular(10.sp);
  @override
  Widget build(BuildContext context) {
    var actionPane = ActionPane(
      extentRatio: 1,
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: (_) {},
          borderRadius: _borderRadius,
          icon: Icons.check,
          label: "Terminer",
          backgroundColor: Colors.green[500]!,
          foregroundColor: Colors.white,
        ),
        SlidableAction(
          borderRadius: _borderRadius,
          onPressed: (_) {},
          icon: Icons.check,
          label: "Suspendre",
          backgroundColor: Colors.amber[500]!,
          foregroundColor: Colors.white,
        ),
        SlidableAction(
          borderRadius: _borderRadius,
          onPressed: (_) {},
          icon: Icons.check,
          label: "Commencer",
          backgroundColor: Colors.blue[500]!,
          foregroundColor: Colors.white,
        ),
      ],
    );
    return Stack(children: [
      Slidable(
        key: const Key("erazear"),
        startActionPane: actionPane,
        child: Material(
          borderRadius: _borderRadius,
          elevation: 8,
          child: ListTile(
            title: const Text("Do something with someone"),
            leading: Icon(
              Icons.check_circle,
              color: Colors.green[200],
              size: 30.sp,
            ),
            textColor: AppColors.textColor,
            shape: RoundedRectangleBorder(
              borderRadius: _borderRadius,
              //side: BorderSide(color: Colors.grey[500]!, width: 1.sp),
            ),
          ),
        ),
      ),
    ]);
  }
}
