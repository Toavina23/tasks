import 'package:dartz/dartz.dart';
import 'package:tasks/core/errors/failures.dart';
import 'package:tasks/domain/entities/category_entity.dart';
import 'package:tasks/domain/entities/project_entity.dart';
import 'package:tasks/domain/repositories/project_repository.dart';

class AddProject {
  final ProjectRepository projectRepository;
  const AddProject(this.projectRepository);

  Future<Either<Failure, ProjectEntity>> execute(
      String name, CategoryEntity category) async {
    return projectRepository.addProject(name, category);
  }
}
