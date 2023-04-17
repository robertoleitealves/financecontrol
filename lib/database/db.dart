import 'package:financecontrol/data/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), DATABASE_NAME),
      onCreate: (db, version) async {
        await db.execute(CREATE_USER_TABLE_SCRIPT);
        await db.execute(CREATE_CREDITCARD_TABLE_SCRIPT);
        await db.execute(CREATE_MARKETPLAN_TABLE_SCRIPT);
        await db.execute(CREATE_EXPENSES_TABLE_SCRIPT);
      },
      version: DATABASEVERSION,
    );
  }
}

const int DATABASEVERSION = 1;
