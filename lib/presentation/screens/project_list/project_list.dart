import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks/domain/entities/category_entity.dart';
import 'package:tasks/domain/entities/project_entity.dart';
import 'package:tasks/presentation/blocs/projectList/project_list_bloc.dart';
import 'package:tasks/presentation/blocs/projectList/project_list_event.dart';
import 'package:tasks/presentation/blocs/projectList/project_list_state.dart';
import 'package:tasks/presentation/components/select.dart';
import 'package:tasks/presentation/components/text_input.dart';
import 'package:tasks/presentation/screens/project_list/components/project_card.dart';
import 'package:tasks/presentation/theme/app_colors.dart';

class ProjectList extends StatefulWidget {
  const ProjectList({super.key});

  @override
  State<ProjectList> createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  final _formKey = GlobalKey<FormState>();
  final projectNameConctroller = TextEditingController(text: "");
  CategoryEntity? _selectedEntity;
  _onSaveProject() {
    if (_formKey.currentState!.validate()) {
      String projectName = projectNameConctroller.value.text;
      _formKey.currentState!.reset();
      context.pop();
      context.read<ProjectListBloc>().add(
            AddProjectToListEvent(
              projectName,
              _selectedEntity!,
            ),
          );
    }
  }

  List<CategoryEntity> _displayDropDownItem(ProjectListState state) {
    if (state is CategoryListHasData) {
      return state.results;
    } else {
      return [];
    }
  }

  _addProject() {
    context.read<ProjectListBloc>().add(FetchCategoryListEvent());
    showBottomSheet(
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.sp),
          topRight: Radius.circular(20.sp),
        ),
      ),
      context: context,
      builder: (context) {
        return BlocBuilder<ProjectListBloc, ProjectListState>(
          builder: (context, state) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width,
              child: Form(
                key: _formKey,
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 5.sp, left: 30.sp, right: 30.sp),
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
                        "Nouveau projet",
                      ),
                      Gap(20.sp),
                      AppTextInput("Nom du projet", projectNameConctroller,
                          (String? value) {
                        if (value != null && value.isNotEmpty) {
                          return null;
                        }
                        return "Le nom du project est requis";
                      }),
                      Gap(20.sp),
                      AppSelect<CategoryEntity>("Catègorie du projet",
                          (CategoryEntity? selected) {
                        setState(
                          () {
                            _selectedEntity = selected;
                          },
                        );
                      }, (CategoryEntity? selectedEntity) {
                        if (selectedEntity == null) {
                          return "Le champ catégorie est requise";
                        }
                        return null;
                      }, _displayDropDownItem(state),
                          (CategoryEntity item) => item.name!),
                      Gap(20.sp),
                      ElevatedButton(
                          onPressed: _onSaveProject,
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
    var snackbarNotifier = BlocListener<ProjectListBloc, ProjectListState>(
      listener: (context, state) {
        if (state is NewProjectAdded) {
          SnackBar snackBar = SnackBar(
              backgroundColor: Colors.transparent,
              behavior: SnackBarBehavior.floating,
              elevation: 0,
              content: AwesomeSnackbarContent(
                  title: "Success",
                  message: "New project added successfully",
                  contentType: ContentType.success));
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        } else if (state is NewProjectAddFailure) {
          SnackBar snackBar = SnackBar(
              backgroundColor: Colors.transparent,
              behavior: SnackBarBehavior.floating,
              elevation: 0,
              content: AwesomeSnackbarContent(
                  title: "Failure",
                  message: state.message,
                  contentType: ContentType.failure));
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        } else if (state is ProjectDeleted) {
          SnackBar snackBar = SnackBar(
              backgroundColor: Colors.transparent,
              behavior: SnackBarBehavior.floating,
              elevation: 0,
              content: AwesomeSnackbarContent(
                  title: "Success",
                  message: "Project deleted successfully",
                  contentType: ContentType.success));
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        } else if (state is ProjectDeteleFailure) {
          SnackBar snackBar = SnackBar(
              backgroundColor: Colors.transparent,
              behavior: SnackBarBehavior.floating,
              elevation: 0,
              content: AwesomeSnackbarContent(
                  title: "Failure",
                  message: state.message,
                  contentType: ContentType.failure));
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        } else if (state is ProjectListLoading) {
          EasyLoading.show(status: "Loading...");
        } else if (state is ProjectListFailure) {
          EasyLoading.showError(state.message);
        } else if (state is NewProjectAdded) {
          SnackBar snackBar = SnackBar(
            backgroundColor: Colors.transparent,
            behavior: SnackBarBehavior.floating,
            elevation: 0,
            content: AwesomeSnackbarContent(
                title: "Success",
                message: "New project added successfully",
                contentType: ContentType.success),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        } else if (state is NewProjectAddFailure) {
          SnackBar snackBar = SnackBar(
            backgroundColor: Colors.transparent,
            behavior: SnackBarBehavior.floating,
            elevation: 0,
            content: AwesomeSnackbarContent(
                title: "Failure",
                message: state.message,
                contentType: ContentType.failure),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        } else if (state is ProjectDeleted) {
          SnackBar snackBar = SnackBar(
            backgroundColor: Colors.transparent,
            behavior: SnackBarBehavior.floating,
            elevation: 0,
            content: AwesomeSnackbarContent(
                title: "Success",
                message: "Project deleted successfully",
                contentType: ContentType.success),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        } else if (state is ProjectDeteleFailure) {
          SnackBar snackBar = SnackBar(
            backgroundColor: Colors.transparent,
            behavior: SnackBarBehavior.floating,
            elevation: 0,
            content: AwesomeSnackbarContent(
                title: "Failure",
                message: state.message,
                contentType: ContentType.failure),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
      },
      child: Container(),
    );
    return Scaffold(
      body: Column(
        children: [
          Gap(20.sp),
          Row(
            children: [
              Gap(10.sp),
              Text(
                "Vos Projets",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ],
          ),
          Gap(20.sp),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<ProjectListBloc, ProjectListState>(
                    bloc: context.read<ProjectListBloc>(),
                    buildWhen: (previous, current) {
                      return current is ProjectListHasData ||
                          current is ProjectListEmpty;
                    },
                    builder: (context, state) {
                      if (state is ProjectListHasData) {
                        if (EasyLoading.isShow) {
                          EasyLoading.dismiss();
                        }
                        List<ProjectEntity> projects = state.results;
                        return GridView.builder(
                            padding: EdgeInsets.symmetric(
                                vertical: 5.0.sp, horizontal: 10.0.sp),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 10.sp,
                                    crossAxisSpacing: 10.sp,
                                    crossAxisCount: 2),
                            itemCount: projects.length,
                            itemBuilder: (context, index) {
                              return ProjectCard(project: projects[index]);
                            });
                      } else if (state is ProjectListEmpty) {
                        if (EasyLoading.isShow) {
                          EasyLoading.dismiss();
                        }
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.close_rounded,
                                color: AppColors.secondary,
                                size: MediaQuery.of(context).size.width * 0.4,
                              ),
                              Text(
                                "No active project found",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: AppColors.secondaryTextColor),
                              )
                            ],
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
                snackbarNotifier,
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProject,
        backgroundColor: AppColors.primary,
        tooltip: "Add a new project",
        child: const Icon(Icons.add),
      ),
    );
  }
}
