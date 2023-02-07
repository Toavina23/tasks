import 'package:sqflite/sqflite.dart' as sql;
import 'package:tasks/core/utils/db/tables.dart';

class DbUtils {
  static Future<void> createTables(sql.Database db) async {
    await db.execute(Tables.category);
    await db.execute(Tables.project);
    await db.execute(Tables.tasks);
    await db.execute("""
      Insert into category(name) values
      ('Personal'),
      ('Work');
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'tasks_database.db',
      version: 1,
      onCreate: (db, version) async {
        await createTables(db);
      },
    );
  }
}
