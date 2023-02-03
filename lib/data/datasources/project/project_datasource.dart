import 'package:tasks/data/models/project_model.dart';

abstract class ProjectLocalDataSource {
  Future<List<ProjectModel>> getProjects();
  Future<ProjectModel> saveProject(Map<String, dynamic> project);
  Future<void> deleteProject(int projectId);
  Future<ProjectModel> getProject(int projectId);
}
