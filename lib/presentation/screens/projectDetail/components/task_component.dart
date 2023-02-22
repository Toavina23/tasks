import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasks/data/models/task_model.dart';
import 'package:tasks/domain/entities/task_entity.dart';
import 'package:tasks/presentation/blocs/projectDetail/project_detail_bloc.dart';
import 'package:tasks/presentation/theme/app_colors.dart';

class Task extends StatefulWidget {
  const Task({super.key, required this.task});
  final TaskEntity task;
  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  final _borderRadius = BorderRadius.circular(10.sp);
  _onDeleteTask() {
    context.read<ProjectDetailBloc>().add(DeleteProjectTask(widget.task.id));
  }

  _defineIcon() {
    switch (widget.task.status) {
      case TaskStatus.done:
        return Icon(
          Icons.check_circle,
          color: Colors.green[200],
          size: 30.sp,
        );
      case TaskStatus.inWork:
        return Icon(
          Icons.hourglass_top_rounded,
          color: AppColors.secondaryTextColor,
          size: 30.sp,
        );
      default:
        return Icon(
          Icons.stop_circle_outlined,
          color: AppColors.secondaryTextColor,
          size: 30.sp,
        );
    }
  }

  _handleLongPress() {
    showModalBottomSheet(
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.sp),
          topRight: Radius.circular(20.sp),
        ),
      ),
      context: context,
      builder: (context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Wrap(children: [
            ListTile(
              textColor: Colors.red,
              title: const Text("Delete"),
              leading: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onTap: _onDeleteTask,
            ),
            ListTile(
              textColor: Colors.green,
              title: const Text("Begin"),
              leading: const Icon(
                Icons.play_arrow,
                color: Colors.green,
              ),
              onTap: () {},
            )
          ]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0.sp),
      child: Material(
        borderRadius: _borderRadius,
        elevation: 3,
        child: ListTile(
          onLongPress: _handleLongPress,
          title: Text(widget.task.name),
          leading: _defineIcon(),
          textColor: AppColors.textColor,
          shape: RoundedRectangleBorder(
            borderRadius: _borderRadius,
            //side: BorderSide(color: Colors.grey[500]!, width: 1.sp),
          ),
        ),
      ),
    );
  }
}
