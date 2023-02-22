import 'package:dartz/dartz.dart';
import 'package:tasks/core/errors/failures.dart';
import 'package:tasks/domain/entities/category_entity.dart';
import 'package:tasks/domain/entities/project_entity.dart';

abstract class ProjectRepository {
  Future<Either<Failure, List<ProjectEntity>>> getProjects();
  Future<Either<Failure, ProjectEntity>> addProject(
      String projectName, CategoryEntity category);
  Future<Either<Failure, void>> deleteProject(int projectId);
  Future<Either<Failure, List<Object>>> getProject(int projectId);
  Future<Either<Failure, void>> addNewProjectTask(
      String taskName, int projectId);
  Future<Either<Failure, void>> deleteProjectTask(int taskId);
}
