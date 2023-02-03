import 'package:equatable/equatable.dart';

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