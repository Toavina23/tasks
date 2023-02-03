import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tasks/domain/entities/project_entity.dart';
import 'package:tasks/presentation/blocs/projectList/project_list_bloc.dart';
import 'package:tasks/presentation/blocs/projectList/project_list_event.dart';

class ProjectCard extends StatelessWidget {
  final ProjectEntity project;
  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    onDelete() {
      context.read<ProjectListBloc>().add(DeleteProjectListItem(project.id));
      context.pop();
    }

    onLongPress() {
      showBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              ListTile(
                onTap: onDelete,
                title: Text(
                  "Delete",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.red),
                ),
                leading: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              )
            ],
          );
        },
      );
    }

    onTap() {
      context.push("/projects/${project.id}");
    }

    return Ink(
      //padding: EdgeInsets.symmetric(vertical: 5.0.sp, horizontal: 5.0.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.sp),
      ),
      child: LayoutBuilder(
        builder: (context, boxConstraints) {
          return InkWell(
            borderRadius: BorderRadius.circular(30.sp),
            onLongPress: onLongPress,
            onTap: onTap,
            child: Column(
              children: [
                Gap(10.sp),
                Text(
                  project.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Gap(10.sp),
                Stack(
                  children: [
                    Center(
                      child: SizedBox(
                        child: CircularStepProgressIndicator(
                          totalSteps: 100,
                          currentStep: 74,
                          stepSize: 10,
                          selectedColor: Colors.greenAccent,
                          unselectedColor: Colors.grey[200],
                          padding: 0,
                          width: boxConstraints.maxWidth * 0.6,
                          height: boxConstraints.maxHeight * 0.6,
                          selectedStepSize: 15,
                          roundedCap: (_, __) => true,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: boxConstraints.maxHeight * 0.6,
                      child: Center(
                        child: Text(
                          "${70} %",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
