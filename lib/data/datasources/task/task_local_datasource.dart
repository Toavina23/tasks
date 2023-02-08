import 'package:sqflite/sqflite.dart';
import 'package:tasks/core/utils/db/db_utils.dart';
import 'package:tasks/data/datasources/task/task_datasource.dart';
import 'package:tasks/data/models/task_model.dart';
import 'package:tasks/core/errors/exceptions.dart' as ex;

class TaskLocalDatasource implements TaskDatasource {
  @override
  Future<List<TaskModel>> getProjectTasks(
      int projectId, int? parentTaskId) async {
    try {
      Database db = await DbUtils.db();
      String queryCondition = "projectId = ? and parentTaskId = ";
      queryCondition += parentTaskId != null ? "null" : "$parentTaskId";
      List<Map<String, dynamic>> tasksData = await db.transaction((txn) {
        return txn.query("task", where: queryCondition, whereArgs: [projectId]);
      });
      return tasksData
          .map(
            (dataRow) => TaskModel.fromSqlite(dataRow),
          )
          .toList();
    } on DatabaseException catch (_) {
      throw ex.DatabaseException(
          "An unexpected error happened when trying to execute the operation");
    }
  }
}
