import 'package:equatable/equatable.dart';
import 'package:tasks/domain/entities/project_entity.dart';

class ProjectModel extends Equatable {
  final int id;
  final String name;
  final DateTime createdAt;
  final String description;
  const ProjectModel(this.id, this.name, this.description, this.createdAt);

  @override
  List<Object?> get props => [];

  factory ProjectModel.fromMap(Map<String, dynamic> data) {
    return ProjectModel(data["id"], data["name"], data["description"],
        DateTime.fromMillisecondsSinceEpoch(data["createdAt"]));
  }
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "createdAt": createdAt,
      "description": description
    };
  }

  ProjectEntity toEntity() {
    return ProjectEntity(id, name, description, createdAt);
  }
}
