part of "project_detail_bloc.dart";

enum ProjectDetailStatus { loading, initial, loaded, failure }

@immutable
class ProjectDetailState extends Equatable {
  final ProjectDetailStatus status;
  final Failure? failure;
  final ProjectEntity? project;
  final List<TaskEntity>? taskList;
  const ProjectDetailState({
    this.status = ProjectDetailStatus.initial,
    this.failure,
    this.project,
    this.taskList,
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
        taskList: taskList != null ? taskList() : this.taskList);
  }

  @override
  List<Object?> get props => [status, project];
}
