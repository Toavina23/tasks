import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks/presentation/blocs/projectDetail/project_detail_bloc.dart';
import 'package:tasks/presentation/components/text_input.dart';
import 'package:tasks/presentation/screens/projectDetail/components/task_component.dart';
import 'package:tasks/presentation/theme/app_colors.dart';

import 'components/tab_title.dart';

class ProjectDetail extends StatefulWidget {
  const ProjectDetail({super.key});

  @override
  State<ProjectDetail> createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail>
    with TickerProviderStateMixin {
  final _decoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.sp),
  );
  final _padding = EdgeInsets.all(8.sp);
  late TabController _controller;
  late GlobalKey<FormState> _formKey;
  final TextEditingController _taskNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _onSaveNewTask() {
    if (_formKey.currentState!.validate()) {
      context
          .read<ProjectDetailBloc>()
          .add(AddNewProjectTask(_taskNameController.value.text));
    }
  }

  _onAddNewTask() {
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
        return LayoutBuilder(
          builder: (context, boxConstraints) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
              width: MediaQuery.of(context).size.width,
              child: Form(
                key: _formKey,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey[400]),
                        width: 30.sp,
                        height: 8.sp,
                      ),
                      Gap(10.sp),
                      Text(
                        style: Theme.of(context).textTheme.bodyLarge,
                        "New task",
                      ),
                      Gap(10.sp),
                      AppTextInput(
                        "Task name",
                        _taskNameController,
                        (name) {
                          if (name != null && name.isNotEmpty) {
                            return null;
                          }
                          return "The field name is required";
                        },
                      ),
                      Gap(10.sp),
                      ElevatedButton(
                          onPressed: _onSaveNewTask,
                          style: Theme.of(context).elevatedButtonTheme.style,
                          child: const Text("Enregistrer"))
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Project details"),
      ),
      body: BlocConsumer<ProjectDetailBloc, ProjectDetailState>(
        listenWhen: (previous, current) =>
            current.status != ProjectDetailStatus.loaded,
        listener: (context, state) {
          if (state.status == ProjectDetailStatus.loading) {
            EasyLoading.show();
          } else if (state.status == ProjectDetailStatus.failure) {
            EasyLoading.showError(state.failure!.message);
          } else if (state.status == ProjectDetailStatus.newTaskAdded) {
            context.pop();
            SnackBar snackBar = SnackBar(
                backgroundColor: Colors.transparent,
                behavior: SnackBarBehavior.floating,
                elevation: 0,
                content: AwesomeSnackbarContent(
                    title: "Success",
                    message: "Task added successfully",
                    contentType: ContentType.success));
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);
          } else if (state.status == ProjectDetailStatus.taskDeleted) {
            context.pop();
            SnackBar snackBar = SnackBar(
                backgroundColor: Colors.transparent,
                behavior: SnackBarBehavior.floating,
                elevation: 0,
                content: AwesomeSnackbarContent(
                    title: "Success",
                    message: "Task deleted successfully",
                    contentType: ContentType.success));
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);
          }
        },
        buildWhen: (previous, current) =>
            previous.status != ProjectDetailStatus.loaded,
        builder: (context, state) {
          if (state.status == ProjectDetailStatus.loaded) {
            var tabs = <Widget>[
              const TabTitle(title: "IN WORK"),
              const TabTitle(title: "DONE"),
              const TabTitle(title: "WAITING")
            ];
            return Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  padding: _padding,
                  decoration: _decoration,
                  child: LayoutBuilder(
                    builder: (context, boxConstraints) => Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state.project!.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: 25.sp,
                              decoration: BoxDecoration(
                                color: AppColors.terciary,
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                              child: Center(
                                child: Text(
                                  state.project!.category.name!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Added on  ${state.project!.displayCreationDate}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: AppColors.secondaryTextColor,
                                  ),
                            )
                          ],
                        ),
                        Gap(10.sp),
                        OutlinedButton(
                          onPressed: () {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("Project metrics"),
                              Gap(10.sp),
                              const Icon(Icons.auto_graph_outlined)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: _decoration,
                    padding: _padding,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tasks",
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            IconButton(
                              onPressed: _onAddNewTask,
                              icon: Icon(
                                Icons.add_box,
                                color: AppColors.primary,
                                size: 30.sp,
                              ),
                            )
                          ],
                        ),
                        Gap(20.sp),
                        TabBar(
                          padding: EdgeInsets.only(bottom: 20.sp),
                          isScrollable: true,
                          controller: _controller,
                          tabs: tabs,
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _controller,
                            children: [
                              ListView(
                                children: state.inWorkTasks
                                    .map((task) => Task(task: task))
                                    .toList(),
                              ),
                              ListView(
                                children: state.doneTasks
                                    .map((task) => Task(task: task))
                                    .toList(),
                              ),
                              ListView(
                                padding: EdgeInsets.symmetric(horizontal: 5.sp),
                                physics: const ScrollPhysics(
                                  parent: BouncingScrollPhysics(
                                      decelerationRate:
                                          ScrollDecelerationRate.fast),
                                ),
                                children: state.waitingTasks
                                    .map(
                                      (task) => Task(task: task),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Gap(20.sp)
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
