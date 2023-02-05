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
    return Stack(children: [
      Material(
        type: MaterialType.transparency,
        child: Slidable(
          key: const Key("erazear"),
          startActionPane: ActionPane(
            extentRatio: 1,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) {},
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
          ),
          child: ListTile(
            title: const Text("Do something with someone"),
            textColor: AppColors.textColor,
            tileColor: Colors.blueGrey[100],
            shape: RoundedRectangleBorder(borderRadius: _borderRadius),
          ),
        ),
      ),
    ]);
  }
}
