part of "project_detail_bloc.dart";

enum ProjectDetailStatus {
  loading,
  initial,
  loaded,
  failure,
  newTaskAdded,
  taskDeleted
}

@immutable
class ProjectDetailState extends Equatable {
  final ProjectDetailStatus status;
  final Failure? failure;
  final ProjectEntity? project;
  final List<TaskEntity> taskList;
  const ProjectDetailState({
    this.status = ProjectDetailStatus.initial,
    this.failure,
    this.project,
    this.taskList = const [],
  });

  ProjectDetailState copyWith({
    ProjectDetailStatus Function()? status,
    Failure Function()? failure,
    ProjectEntity Function()? project,
    List<TaskEntity> Function()? taskList,
  }) {
    return ProjectDetailState(
      status: status != null ? status() : this.status,
      failure: failure != null ? failure() : this.failure,
      project: project != null ? project() : this.project,
      taskList: taskList != null ? taskList() : const [],
    );
  }

  List<TaskEntity> get doneTasks =>
      taskList.where((element) => element.status == TaskStatus.done).toList();

  List<TaskEntity> get inWorkTasks =>
      taskList.where((element) => element.status == TaskStatus.inWork).toList();

  List<TaskEntity> get waitingTasks => taskList
      .where((element) => element.status == TaskStatus.waiting)
      .toList();

  @override
  List<Object?> get props => [status, project];
}
