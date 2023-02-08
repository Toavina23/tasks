import 'package:sqflite/sqflite.dart';
import 'package:tasks/core/utils/db/db_utils.dart';
import 'package:tasks/core/errors/exceptions.dart' as ex;
import 'package:tasks/data/datasources/category/category_datasource.dart';
import 'package:tasks/data/models/category_model.dart';

class CategoryLocalDataSource implements CategoryDataSource {
  const CategoryLocalDataSource();
  @override
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      Database db = await DbUtils.db();
      List<Map<String, dynamic>> data = await db.transaction((txn) async {
        return await txn.query('category');
      });
      List<CategoryModel> categories = data.map<CategoryModel>((row) {
        return CategoryModel.fromMap(row);
      }).toList();
      return categories;
    } on DatabaseException catch (_) {
      throw ex.DatabaseException(
          "An unexpected error happened when trying to get the requested data");
    }
  }
}
