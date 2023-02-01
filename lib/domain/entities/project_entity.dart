import 'package:equatable/equatable.dart';

class ProjectEntity extends Equatable {
  final int id;
  final String name;
  final DateTime createdAt;
  final String description;

  const ProjectEntity(this.id, this.name, this.description, this.createdAt);

  @override
  List<Object?> get props => [];
}
