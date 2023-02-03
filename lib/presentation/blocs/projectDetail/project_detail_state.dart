import 'package:equatable/equatable.dart';
import 'package:tasks/domain/entities/project_entity.dart';

class ProjectDetailState extends Equatable {
  const ProjectDetailState();

  @override
  List<Object?> get props => [];
}

class ProjectDetailLoading extends ProjectDetailState {}

class ProjectDetailIdle extends ProjectDetailState {}

class ProjectDetailFailure extends ProjectDetailState {
  final String message;
  const ProjectDetailFailure(this.message);
  @override
  List<Object?> get props => [message];
}

class ProjectDetailHasData extends ProjectDetailState {
  final ProjectEntity project;
  const ProjectDetailHasData(this.project);
  @override
  List<Object?> get props => [project];
}
