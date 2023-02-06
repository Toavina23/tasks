import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tasks/presentation/blocs/projectDetail/project_detail_bloc.dart';
import 'package:tasks/presentation/blocs/projectDetail/project_detail_state.dart';
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
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProjectDetailBloc, ProjectDetailState>(
        builder: (context, state) {
          if (state is ProjectDetailHasData) {
            var tabs = <Widget>[
              const TabTitle(title: "IN WORK"),
              const TabTitle(title: "DONE"),
              const TabTitle(title: "WAITING")
            ];
            return Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  padding: _padding,
                  decoration: _decoration,
                  child: LayoutBuilder(
                    builder: (context, boxConstraints) => Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  state.project.name,
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                                Gap(10.sp),
                                Text(
                                  "Ajouté le: ${state.project.createdAt.day}/${state.project.createdAt.month}/${state.project.createdAt.year}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: AppColors.secondaryTextColor,
                                      ),
                                )
                              ],
                            ),
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
                                      width: boxConstraints.maxHeight * 0.4,
                                      height: boxConstraints.maxHeight * 0.4,
                                      selectedStepSize: 15,
                                      roundedCap: (_, __) => true,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: boxConstraints.maxHeight * 0.4,
                                  width: boxConstraints.maxHeight * 0.4,
                                  child: Center(
                                    child: Text(
                                      "${70} %",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Gap(10.sp),
                        Row(
                          children: [
                            Gap(10.sp),
                            Expanded(
                              child: Text(
                                state.project.description,
                                softWrap: true,
                                overflow: TextOverflow.visible,
                                style: Theme.of(context).textTheme.bodyMedium,
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
                            ))
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
                          children: [
                            Text(
                              "Tasks",
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
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
                                children: const [Task()],
                              ),
                              const Text("text"),
                              const Text("text")
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
          } else if (state is ProjectDetailLoading) {
            EasyLoading.show();
          } else if (state is ProjectDetailFailure) {
            EasyLoading.showError(state.message);
          }
          return Container();
        },
      ),
    );
  }
}
