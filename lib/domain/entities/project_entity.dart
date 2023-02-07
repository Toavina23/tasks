import 'package:equatable/equatable.dart';
import 'package:tasks/domain/entities/category_entity.dart';

class ProjectEntity extends Equatable {
  final int id;
  final String name;
  final DateTime createdAt;
  final CategoryEntity category;

  const ProjectEntity(this.id, this.name, this.createdAt, this.category);

  @override
  List<Object?> get props => [id];
}
