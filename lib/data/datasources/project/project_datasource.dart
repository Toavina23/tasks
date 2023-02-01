import 'package:tasks/data/models/project_model.dart';
import 'package:tasks/domain/entities/project_entity.dart';

abstract class ProjectLocalDataSource {
  Future<List<ProjectModel>> getProjects();
  Future<ProjectModel> saveProject(Map<String, dynamic> project);
  Future<void> deleteProject(int projectId);
}
