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
      String queryCondition = "projectId = ? and parentTaskId ";
      queryCondition += parentTaskId == null ? "is NULL" : "= $parentTaskId";
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

  @override
  Future<TaskModel> saveProjectTask(String taskName, int projectId) async {
    try {
      Database db = await DbUtils.db();
      int id = await db.transaction((txn) {
        return txn.insert("task", {
          "name": taskName,
          "createdAt": DateTime.now().millisecondsSinceEpoch,
          "projectId": projectId
        });
      });
      Map<String, dynamic> taskData = await db.transaction((txn) async {
        List<Map<String, dynamic>> result =
            await txn.query("task", where: "id = ?", whereArgs: [id]);
        return result.first;
      });
      return TaskModel.fromSqlite(taskData);
    } on DatabaseException catch (_) {
      throw ex.DatabaseException(
          "An unexpected error happened when trying to execute the operation");
    }
  }

  @override
  Future<void> deleteProjectTask(int taskId) async {
    try {
      Database db = await DbUtils.db();
      await db.transaction(
          (txn) => txn.delete('task', where: "id = ?", whereArgs: [taskId]));
    } on DatabaseException catch (_) {
      throw ex.DatabaseException(
          "An unexpected error happened when trying to execute the operation");
    }
  }
}
