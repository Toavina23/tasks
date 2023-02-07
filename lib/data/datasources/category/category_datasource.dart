import 'package:tasks/data/models/category_model.dart';

abstract class CategoryDataSource {
  Future<List<CategoryModel>> getAllCategories();
}
