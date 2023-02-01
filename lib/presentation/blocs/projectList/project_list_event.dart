import 'package:equatable/equatable.dart';

abstract class ProjectListEvent extends Equatable {
  const ProjectListEvent();

  @override
  List<Object?> get props => [];
}

class FetchProjectListEvent extends ProjectListEvent {}

class AddProjectToListEvent extends ProjectListEvent {
  final String projectName;
  final String projectDescription;
  const AddProjectToListEvent(this.projectName, this.projectDescription);

  @override
  List<Object?> get props => [projectName, projectDescription];
}

class DeleteProjectListItem extends ProjectListEvent {
  final int projectId;
  const DeleteProjectListItem(this.projectId);
  @override
  List<Object?> get props => [projectId];
}
