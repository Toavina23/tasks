import 'package:dartz/dartz.dart';
import 'package:tasks/core/errors/failures.dart';
import 'package:tasks/domain/repositories/project_repository.dart';

class SaveNewProjectTask {
  const SaveNewProjectTask(this._projectRepository);
  final ProjectRepository _projectRepository;

  Future<Either<Failure, void>> execute(String taskName, int projectId) async {
    return _projectRepository.addNewProjectTask(taskName, projectId);
  }
}
