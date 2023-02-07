import 'package:equatable/equatable.dart';
import 'package:tasks/domain/entities/category_entity.dart';

abstract class ProjectListEvent extends Equatable {
  const ProjectListEvent();

  @override
  List<Object?> get props => [];
}

class FetchProjectListEvent extends ProjectListEvent {}

class AddProjectToListEvent extends ProjectListEvent {
  final String projectName;
  final CategoryEntity categoryEntity;
  const AddProjectToListEvent(this.projectName, this.categoryEntity);

  @override
  List<Object?> get props => [projectName, categoryEntity];
}

class DeleteProjectListItem extends ProjectListEvent {
  final int projectId;
  const DeleteProjectListItem(this.projectId);
  @override
  List<Object?> get props => [projectId];
}

class FetchCategoryListEvent extends ProjectListEvent {}
