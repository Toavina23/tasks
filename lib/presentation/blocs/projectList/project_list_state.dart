import 'package:equatable/equatable.dart';
import 'package:tasks/domain/entities/project_entity.dart';

abstract class ProjectListState extends Equatable {
  const ProjectListState();
  @override
  List<Object?> get props => [];
}

class ProjectListEmpty extends ProjectListState {}

class ProjectListLoading extends ProjectListState {}

class ProjectListHasData extends ProjectListState {
  final List<ProjectEntity> results;
  const ProjectListHasData({required this.results});

  @override
  List<Object?> get props => [results];
}

class ProjectListFailure extends ProjectListState {
  final String message;
  const ProjectListFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class NewProjectAdded extends ProjectListState {}

class NewProjectAddFailure extends ProjectListState {
  final String message;
  const NewProjectAddFailure(this.message);
  @override
  List<Object?> get props => [message];
}

class ProjectDeleted extends ProjectListState {}

class ProjectDeteleFailure extends ProjectListState {
  final String message;
  const ProjectDeteleFailure(this.message);
  @override
  List<Object?> get props => [message];
}
