import 'dart:ffi';

import 'package:tasks/core/errors/exceptions.dart';
import 'package:tasks/data/datasources/project/project_datasource.dart';
import 'package:tasks/data/models/project_model.dart';
import 'package:tasks/domain/entities/project_entity.dart';
import 'package:tasks/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tasks/domain/repositories/project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectLocalDataSource projectDataSource;
  const ProjectRepositoryImpl({required this.projectDataSource});
  @override
  Future<Either<Failure, List<ProjectEntity>>> getProjects() async {
    try {
      List<ProjectModel> projectModels = await projectDataSource.getProjects();
      List<ProjectEntity> projectEntities =
          projectModels.map((projectModel) => projectModel.toEntity()).toList();
      return right(projectEntities);
    } on DatabaseException catch (e) {
      return left(AppFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, ProjectEntity>> addProject(
      Map<String, dynamic> project) async {
    project["createdAt"] = DateTime.now().millisecondsSinceEpoch;
    try {
      ProjectModel newProject = await projectDataSource.saveProject(project);
      return right(newProject.toEntity());
    } on DatabaseException catch (e) {
      return left(AppFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProject(int projectId) async {
    try {
      await projectDataSource.deleteProject(projectId);
      return right(null);
    } on DatabaseException catch (e) {
      return left(AppFailure(e.message));
    }
  }
}
