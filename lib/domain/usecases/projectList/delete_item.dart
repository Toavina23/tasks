import 'package:dartz/dartz.dart';
import 'package:tasks/core/errors/failures.dart';
import 'package:tasks/domain/repositories/project_repository.dart';

class DeleteProject {
  final ProjectRepository projectRepository;
  const DeleteProject(this.projectRepository);
  Future<Either<Failure, void>> execute(int projectId) {
    return projectRepository.deleteProject(projectId);
  }
}
