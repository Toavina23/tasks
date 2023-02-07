import 'package:tasks/core/errors/exceptions.dart';
import 'package:tasks/data/datasources/category/category_datasource.dart';
import 'package:tasks/data/models/category_model.dart';
import 'package:tasks/domain/entities/category_entity.dart';
import 'package:tasks/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tasks/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDataSource categoryDataSource;
  const CategoryRepositoryImpl(this.categoryDataSource);
  @override
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories() async {
    try {
      List<CategoryModel> categoryModels =
          await categoryDataSource.getAllCategories();
      List<CategoryEntity> categorieEntities = categoryModels
          .map((categoryModel) =>
              CategoryEntity(categoryModel.id, categoryModel.name))
          .toList();
      return right(categorieEntities);
    } on DatabaseException catch (e) {
      return left(AppFailure(e.message));
    }
  }
}
