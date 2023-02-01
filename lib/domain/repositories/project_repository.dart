import 'package:dartz/dartz.dart';
import 'package:tasks/core/errors/failures.dart';
import 'package:tasks/domain/entities/project_entity.dart';

abstract class ProjectRepository {
  Future<Either<Failure, List<ProjectEntity>>> getProjects();
  Future<Either<Failure, ProjectEntity>> addProject(
      Map<String, dynamic> project);
  Future<Either<Failure, void>> deleteProject(int projectId);
}
