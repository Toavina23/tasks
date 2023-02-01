import 'package:dartz/dartz.dart';
import 'package:tasks/core/errors/failures.dart';
import 'package:tasks/domain/entities/project_entity.dart';
import 'package:tasks/domain/repositories/project_repository.dart';

class GetAllProjects {
  final ProjectRepository projectRepository;
  const GetAllProjects({required this.projectRepository});

  Future<Either<Failure, List<ProjectEntity>>> execute() async {
    return projectRepository.getProjects();
  }
}
