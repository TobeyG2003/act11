import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const _databaseVersion = 1;
  static const cardid = 'id';
  static const cardname = 'name';
  static const cardsuit = 'suit';
  static const cardimageUrl = 'imageURl';
  static const cardfolderID = 'folderId';
  static const cardcreatedAt = 'createdAt';

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
CREATE TABLE 'folderstable' (
'id' INTEGER PRIMARY KEY,
'name' TEXT,
'previewImage' TEXT,
'createdAt' TEXT
)
''');
await db.insert('folderstable', {'name': 'spades', 'previewImage': '', 'createdAt': DateTime.now().toIso8601String()});
await db.insert('folderstable', {'name': 'hearts', 'previewImage': '', 'createdAt': DateTime.now().toIso8601String()});
await db.insert('folderstable', {'name': 'diamonds', 'previewImage': '', 'createdAt': DateTime.now().toIso8601String()});
await db.insert('folderstable', {'name': 'clubs', 'previewImage': '', 'createdAt': DateTime.now().toIso8601String()});
  }
  Future _onCreateCards(Database db, int version) async {
    await db.execute('''
CREATE TABLE 'cardstable' (
$cardid INTEGER PRIMARY KEY,
$cardname TEXT,
$cardsuit TEXT,
$cardimageUrl TEXT,
'imageBytes' TEXT,
$cardfolderID INTEGER,
$cardcreatedAt TEXT,
FOREIGN KEY ('folderId') REFERENCES 'folderstable' ('id')
)
''');
// Spades (folderId: 1)
await db.insert('cardstable', {'name': 'Ace', 'suit': 'spades', 'imageURl': '/assets/ace.png', 'imageBytes': '', 'folderId': 1, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Two', 'suit': 'spades', 'imageURl': '/assets/two.png', 'imageBytes': '', 'folderId': 1, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Three', 'suit': 'spades', 'imageURl': '/assets/three.png', 'imageBytes': '', 'folderId': 1, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Four', 'suit': 'spades', 'imageURl': '/assets/four.png', 'imageBytes': '', 'folderId': 1, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Five', 'suit': 'spades', 'imageURl': '/assets/five.png', 'imageBytes': '', 'folderId': 1, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Six', 'suit': 'spades', 'imageURl': '/assets/six.png', 'imageBytes': '', 'folderId': 1, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Seven', 'suit': 'spades', 'imageURl': '/assets/seven.png', 'imageBytes': '', 'folderId': 1, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Eight', 'suit': 'spades', 'imageURl': '/assets/eight.png', 'imageBytes': '', 'folderId': 1, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Nine', 'suit': 'spades', 'imageURl': '/assets/nine.png', 'imageBytes': '', 'folderId': 1, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Ten', 'suit': 'spades', 'imageURl': '/assets/ten.png', 'imageBytes': '', 'folderId': 1, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Jack', 'suit': 'spades', 'imageURl': '/assets/jack.png', 'imageBytes': '', 'folderId': 1, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Queen', 'suit': 'spades', 'imageURl': '/assets/queen.png', 'imageBytes': '', 'folderId': 1, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'King', 'suit': 'spades', 'imageURl': '/assets/king.png', 'imageBytes': '', 'folderId': 1, 'createdAt': DateTime.now().toIso8601String()});

// Hearts (folderId: 2)
await db.insert('cardstable', {'name': 'Ace', 'suit': 'hearts', 'imageURl': '/assets/ace.png', 'imageBytes': '', 'folderId': 2, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Two', 'suit': 'hearts', 'imageURl': '/assets/two.png', 'imageBytes': '', 'folderId': 2, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Three', 'suit': 'hearts', 'imageURl': '/assets/three.png', 'imageBytes': '', 'folderId': 2, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Four', 'suit': 'hearts', 'imageURl': '/assets/four.png', 'imageBytes': '', 'folderId': 2, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Five', 'suit': 'hearts', 'imageURl': '/assets/five.png', 'imageBytes': '', 'folderId': 2, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Six', 'suit': 'hearts', 'imageURl': '/assets/six.png', 'imageBytes': '', 'folderId': 2, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Seven', 'suit': 'hearts', 'imageURl': '/assets/seven.png', 'imageBytes': '', 'folderId': 2, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Eight', 'suit': 'hearts', 'imageURl': '/assets/eight.png', 'imageBytes': '', 'folderId': 2, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Nine', 'suit': 'hearts', 'imageURl': '/assets/nine.png', 'imageBytes': '', 'folderId': 2, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Ten', 'suit': 'hearts', 'imageURl': '/assets/ten.png', 'imageBytes': '', 'folderId': 2, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Jack', 'suit': 'hearts', 'imageURl': '/assets/jack.png', 'imageBytes': '', 'folderId': 2, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Queen', 'suit': 'hearts', 'imageURl': '/assets/queen.png', 'imageBytes': '', 'folderId': 2, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'King', 'suit': 'hearts', 'imageURl': '/assets/king.png', 'imageBytes': '', 'folderId': 2, 'createdAt': DateTime.now().toIso8601String()});

// Diamonds (folderId: 3)
await db.insert('cardstable', {'name': 'Ace', 'suit': 'diamonds', 'imageURl': '/assets/ace.png', 'imageBytes': '', 'folderId': 3, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Two', 'suit': 'diamonds', 'imageURl': '/assets/two.png', 'imageBytes': '', 'folderId': 3, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Three', 'suit': 'diamonds', 'imageURl': '/assets/three.png', 'imageBytes': '', 'folderId': 3, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Four', 'suit': 'diamonds', 'imageURl': '/assets/four.png', 'imageBytes': '', 'folderId': 3, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Five', 'suit': 'diamonds', 'imageURl': '/assets/five.png', 'imageBytes': '', 'folderId': 3, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Six', 'suit': 'diamonds', 'imageURl': '/assets/six.png', 'imageBytes': '', 'folderId': 3, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Seven', 'suit': 'diamonds', 'imageURl': '/assets/seven.png', 'imageBytes': '', 'folderId': 3, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Eight', 'suit': 'diamonds', 'imageURl': '/assets/eight.png', 'imageBytes': '', 'folderId': 3, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Nine', 'suit': 'diamonds', 'imageURl': '/assets/nine.png', 'imageBytes': '', 'folderId': 3, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Ten', 'suit': 'diamonds', 'imageURl': '/assets/ten.png', 'imageBytes': '', 'folderId': 3, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Jack', 'suit': 'diamonds', 'imageURl': '/assets/jack.png', 'imageBytes': '', 'folderId': 3, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Queen', 'suit': 'diamonds', 'imageURl': '/assets/queen.png', 'imageBytes': '', 'folderId': 3, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'King', 'suit': 'diamonds', 'imageURl': '/assets/king.png', 'imageBytes': '', 'folderId': 3, 'createdAt': DateTime.now().toIso8601String()});

// Clubs (folderId: 4)
await db.insert('cardstable', {'name': 'Ace', 'suit': 'clubs', 'imageURl': '/assets/ace.png', 'imageBytes': '', 'folderId': 4, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Two', 'suit': 'clubs', 'imageURl': '/assets/two.png', 'imageBytes': '', 'folderId': 4, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Three', 'suit': 'clubs', 'imageURl': '/assets/three.png', 'imageBytes': '', 'folderId': 4, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Four', 'suit': 'clubs', 'imageURl': '/assets/four.png', 'imageBytes': '', 'folderId': 4, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Five', 'suit': 'clubs', 'imageURl': '/assets/five.png', 'imageBytes': '', 'folderId': 4, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Six', 'suit': 'clubs', 'imageURl': '/assets/six.png', 'imageBytes': '', 'folderId': 4, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Seven', 'suit': 'clubs', 'imageURl': '/assets/seven.png', 'imageBytes': '', 'folderId': 4, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Eight', 'suit': 'clubs', 'imageURl': '/assets/eight.png', 'imageBytes': '', 'folderId': 4, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Nine', 'suit': 'clubs', 'imageURl': '/assets/nine.png', 'imageBytes': '', 'folderId': 4, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Ten', 'suit': 'clubs', 'imageURl': '/assets/ten.png', 'imageBytes': '', 'folderId': 4, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Jack', 'suit': 'clubs', 'imageURl': '/assets/jack.png', 'imageBytes': '', 'folderId': 4, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Queen', 'suit': 'clubs', 'imageURl': '/assets/queen.png', 'imageBytes': '', 'folderId': 4, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'King', 'suit': 'clubs', 'imageURl': '/assets/king.png', 'imageBytes': '', 'folderId': 4, 'createdAt': DateTime.now().toIso8601String()});
  }
  Future<int> insertcard(Map<String, dynamic> row) async {
    return await cardsdb.insert('cardstable', row);
  }
  Future<int> updatecard(Map<String, dynamic> row) async {
    int id = row[cardid];
    return await cardsdb.update(
      'cardstable',
      row,
      where: '$cardid = ?',
      whereArgs: [id],
    );
  }
  Future<int> delete(int id) async {
    return await cardsdb.delete(
      'cardstable',
      where: '$cardfolderID = ?',
      whereArgs: [id],
    );
  }
}