part of "project_detail_bloc.dart";

class ProjectDetailEvent extends Equatable {
  const ProjectDetailEvent();
  @override
  List<Object?> get props => [];
}

class FetchProjectDetailEvent extends ProjectDetailEvent {
  final int projectId;
  const FetchProjectDetailEvent(this.projectId);
  @override
  List<Object?> get props => [projectId];
}

class AddNewProjectTask extends ProjectDetailEvent {
  final String newTaskName;
  const AddNewProjectTask(this.newTaskName);
  @override
  List<Object?> get props => [newTaskName];
}

class DeleteProjectTask extends ProjectDetailEvent {
  final int taskId;
  const DeleteProjectTask(this.taskId);
  @override
  List<Object?> get props => [taskId];
}
