import 'dart:io';

import 'package:mymovie/resources/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final int _databaseVersion = 1;

  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  static Database _database;
  Future<Database> get database async {
    if(_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(sqlCreateMovieTable);
    await db.execute(sqlCreateStillcutTable);
    await db.execute(sqlCreateActorTable);
    await db.execute(sqlCreateTrailerTable);
    await db.execute(sqlCreateDiaryTable);
  }
}