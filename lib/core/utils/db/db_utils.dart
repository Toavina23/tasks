import 'package:sqflite/sqflite.dart' as sql;
import 'package:tasks/core/utils/db/tables.dart';

class DbUtils {
  static Future<void> createTables(sql.Database db) async {
    await db.execute(Tables.project);
    await db.execute(Tables.tasks);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'tasks.db',
      version: 1,
      onCreate: (db, version) async {
        await createTables(db);
      },
    );
  }
}
