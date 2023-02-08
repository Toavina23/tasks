part of "project_detail_bloc.dart";

enum ProjectDetailStatus { loading, initial, loaded, failure }

@immutable
class ProjectDetailState extends Equatable {
  final ProjectDetailStatus status;
  final Failure? failure;
  final ProjectEntity? project;
  const ProjectDetailState({
    this.status = ProjectDetailStatus.initial,
    this.failure,
    this.project,
  });

  ProjectDetailState copyWith({
    ProjectDetailStatus Function()? status,
    Failure Function()? failure,
    ProjectEntity Function()? project,
  }) {
    return ProjectDetailState(
        status: status != null ? status() : this.status,
        failure: failure != null ? failure() : this.failure,
        project: project != null ? project() : this.project);
  }

  @override
  List<Object?> get props => [status, project];
}
