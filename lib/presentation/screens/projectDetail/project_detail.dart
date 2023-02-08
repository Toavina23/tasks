import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tasks/presentation/blocs/projectDetail/project_detail_bloc.dart';
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
                              onPressed: () {},
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
          }
          return Container();
        },
      ),
    );
  }
}
