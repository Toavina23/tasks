import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:tasks/domain/entities/category_entity.dart';

class ProjectEntity extends Equatable {
  final int id;
  final String name;
  final DateTime createdAt;
  final CategoryEntity category;
  const ProjectEntity(
    this.id,
    this.name,
    this.createdAt,
    this.category,
  );
  String get displayCreationDate => DateFormat.yMMMMEEEEd().format(createdAt);
  @override
  List<Object?> get props => [id];
}
