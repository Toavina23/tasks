import 'package:tasks/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tasks/domain/repositories/project_repository.dart';

class GetProjectDetails {
  final ProjectRepository _projectRepository;
  const GetProjectDetails(this._projectRepository);

  Future<Either<Failure, List<Object>>> execute(int projectId) {
    return _projectRepository.getProject(projectId);
  }
}
