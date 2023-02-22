import 'package:dartz/dartz.dart';
import 'package:tasks/core/errors/failures.dart';
import 'package:tasks/domain/repositories/project_repository.dart';

class DeleteProjectTask {
  const DeleteProjectTask(this._projectRepository);
  final ProjectRepository _projectRepository;

  Future<Either<Failure, void>> execute(int taskId) async {
    return _projectRepository.deleteProjectTask(taskId);
  }
}
