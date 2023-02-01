import 'package:sqflite/sqflite.dart';
import 'package:tasks/core/errors/exceptions.dart' as ex;
import 'package:tasks/core/utils/db/db_utils.dart';
import 'package:tasks/data/datasources/project/project_datasource.dart';
import 'package:tasks/data/models/project_model.dart';

class ProjectLocalDatasourceImpl extends ProjectLocalDataSource {
  @override
  Future<List<ProjectModel>> getProjects() async {
    try {
      Database db = await DbUtils.db();
      List<Map<String, dynamic>> data = await db.transaction((txn) {
        return txn.query('project');
      });
      List<ProjectModel> projects = data.map((row) {
        return ProjectModel.fromMap(row);
      }).toList();
      return projects;
    } on DatabaseException catch (_) {
      throw ex.DatabaseException(
          "An unexpected error happened when trying to get the requested data");
    }
  }

  @override
  Future<ProjectModel> saveProject(Map<String, dynamic> project) async {
    try {
      Database db = await DbUtils.db();
      int id = await db.transaction<int>((txn) {
        return txn.insert('project', project,
            conflictAlgorithm: ConflictAlgorithm.replace);
      });
      project["id"] = id;
      return ProjectModel.fromMap(project);
    } on DatabaseException catch (_) {
      throw ex.DatabaseException(
          "An unexpected error happened when trying to execute the operation");
    }
  }

  @override
  Future<void> deleteProject(int projectId) async {
    try {
      Database db = await DbUtils.db();
      await db.transaction((txn) {
        return db.delete('project', where: "id = ?", whereArgs: [projectId]);
      });
    } on DatabaseException catch (_) {
      throw ex.DatabaseException(
          "An unexpected error happened when trying to execute the operation");
    }
  }
}
