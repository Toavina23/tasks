import 'package:dartz/dartz.dart';
import 'package:tasks/core/errors/failures.dart';
import 'package:tasks/domain/entities/category_entity.dart';
import 'package:tasks/domain/repositories/category_repository.dart';

class GetProjectCategories {
  final CategoryRepository categoryRepository;
  const GetProjectCategories(this.categoryRepository);
  Future<Either<Failure, List<CategoryEntity>>> execute() async {
    return await categoryRepository.getAllCategories();
  }
}
