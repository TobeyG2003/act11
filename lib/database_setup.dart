import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;
  static const table = 'my_table';
  static const columnId = '_id';
  static const columnName = 'name';
  static const columnAge = 'age';
  late Database foldersdb;
  late Database cardsdb;
// this opens the database (and creates it if it doesn't exist)
  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'myfolders.db');
    final path2 = join(documentsDirectory.path, 'mycards.db');
    foldersdb = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreateFolders,
    );
    cardsdb = await openDatabase(
      path2,
      version: _databaseVersion,
      onCreate: _onCreateCards,
    );
  }

// SQL code to create the database table
  Future _onCreateFolders(Database db, int version) async {
    await db.execute('''
CREATE TABLE $table (
'id' INTEGER PRIMARY KEY,
'name' TEXT,
'previewImage' TEXT,
'createdAt' TEXT
)
''');
  }
  Future _onCreateCards(Database db, int version) async {
    await db.execute('''
CREATE TABLE $table (
'id' INTEGER PRIMARY KEY,
'name' TEXT,
'suite' TEXT,
'imageURl' TEXT,
'imageBytes' TEXT,
'folderId' INTEGER, FOREIGN KEY,
'createdAt' TEXT
)
''');
  }
}