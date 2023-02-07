import 'package:equatable/equatable.dart';
import 'package:tasks/data/models/category_model.dart';
import 'package:tasks/domain/entities/project_entity.dart';

class ProjectModel extends Equatable {
  final int id;
  final String name;
  final DateTime createdAt;
  final CategoryModel category;
  const ProjectModel(this.id, this.name, this.createdAt, this.category);

  @override
  List<Object?> get props => [];

  factory ProjectModel.fromMap(Map<String, dynamic> data) {
    return ProjectModel(
        data["id"],
        data["name"],
        DateTime.fromMillisecondsSinceEpoch(data["createdAt"]),
        CategoryModel(data["categoryId"], data["categoryName"]));
  }
  factory ProjectModel.fromEntity(ProjectEntity entity) {
    return ProjectModel(entity.id, entity.name, entity.createdAt,
        CategoryModel.fromEntity(entity.category));
  }
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "createdAt": createdAt,
      "categoryId": category.id
    };
  }

  ProjectEntity toEntity() {
    return ProjectEntity(id, name, createdAt, category.toEntity());
  }
}
