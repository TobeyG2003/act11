import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const _databaseVersion = 1;
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
'id' INTEGER PRIMARY KEY,
'name' TEXT,
'suite' TEXT,
'imageURl' TEXT,
'imageBytes' TEXT,
'folderId' INTEGER,
'createdAt' TEXT,
FOREIGN KEY ('folderId') REFERENCES 'folderstable' ('id')
)
''');
// Spades (folderId: 1)
await db.insert('cardstable', {'name': 'Ace', 'suite': 'spades', 'imageURl': '/assets/ace.jpg', 'imageBytes': '', 'folderId': 1, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Two', 'suite': 'spades', 'imageURl': '/assets/two.jpg', 'imageBytes': '', 'folderId': 1, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Three', 'suite': 'spades', 'imageURl': '/assets/three.jpg', 'imageBytes': '', 'folderId': 1, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Four', 'suite': 'spades', 'imageURl': '/assets/four.jpg', 'imageBytes': '', 'folderId': 1, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Five', 'suite': 'spades', 'imageURl': '/assets/five.jpg', 'imageBytes': '', 'folderId': 1, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Six', 'suite': 'spades', 'imageURl': '/assets/six.jpg', 'imageBytes': '', 'folderId': 1, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Seven', 'suite': 'spades', 'imageURl': '/assets/seven.jpg', 'imageBytes': '', 'folderId': 1, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Eight', 'suite': 'spades', 'imageURl': '/assets/eight.jpg', 'imageBytes': '', 'folderId': 1, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Nine', 'suite': 'spades', 'imageURl': '/assets/nine.jpg', 'imageBytes': '', 'folderId': 1, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Ten', 'suite': 'spades', 'imageURl': '/assets/ten.jpg', 'imageBytes': '', 'folderId': 1, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Jack', 'suite': 'spades', 'imageURl': '/assets/jack.jpg', 'imageBytes': '', 'folderId': 1, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Queen', 'suite': 'spades', 'imageURl': '/assets/queen.jpg', 'imageBytes': '', 'folderId': 1, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'King', 'suite': 'spades', 'imageURl': '/assets/king.jpg', 'imageBytes': '', 'folderId': 1, 'createdAt': DateTime.now().toIso8601String()});

// Hearts (folderId: 2)
await db.insert('cardstable', {'name': 'Ace', 'suite': 'hearts', 'imageURl': '/assets/ace.jpg', 'imageBytes': '', 'folderId': 2, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Two', 'suite': 'hearts', 'imageURl': '/assets/two.jpg', 'imageBytes': '', 'folderId': 2, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Three', 'suite': 'hearts', 'imageURl': '/assets/three.jpg', 'imageBytes': '', 'folderId': 2, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Four', 'suite': 'hearts', 'imageURl': '/assets/four.jpg', 'imageBytes': '', 'folderId': 2, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Five', 'suite': 'hearts', 'imageURl': '/assets/five.jpg', 'imageBytes': '', 'folderId': 2, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Six', 'suite': 'hearts', 'imageURl': '/assets/six.jpg', 'imageBytes': '', 'folderId': 2, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Seven', 'suite': 'hearts', 'imageURl': '/assets/seven.jpg', 'imageBytes': '', 'folderId': 2, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Eight', 'suite': 'hearts', 'imageURl': '/assets/eight.jpg', 'imageBytes': '', 'folderId': 2, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Nine', 'suite': 'hearts', 'imageURl': '/assets/nine.jpg', 'imageBytes': '', 'folderId': 2, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Ten', 'suite': 'hearts', 'imageURl': '/assets/ten.jpg', 'imageBytes': '', 'folderId': 2, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Jack', 'suite': 'hearts', 'imageURl': '/assets/jack.jpg', 'imageBytes': '', 'folderId': 2, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Queen', 'suite': 'hearts', 'imageURl': '/assets/queen.jpg', 'imageBytes': '', 'folderId': 2, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'King', 'suite': 'hearts', 'imageURl': '/assets/king.jpg', 'imageBytes': '', 'folderId': 2, 'createdAt': DateTime.now().toIso8601String()});

// Diamonds (folderId: 3)
await db.insert('cardstable', {'name': 'Ace', 'suite': 'diamonds', 'imageURl': '/assets/ace.jpg', 'imageBytes': '', 'folderId': 3, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Two', 'suite': 'diamonds', 'imageURl': '/assets/two.jpg', 'imageBytes': '', 'folderId': 3, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Three', 'suite': 'diamonds', 'imageURl': '/assets/three.jpg', 'imageBytes': '', 'folderId': 3, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Four', 'suite': 'diamonds', 'imageURl': '/assets/four.jpg', 'imageBytes': '', 'folderId': 3, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Five', 'suite': 'diamonds', 'imageURl': '/assets/five.jpg', 'imageBytes': '', 'folderId': 3, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Six', 'suite': 'diamonds', 'imageURl': '/assets/six.jpg', 'imageBytes': '', 'folderId': 3, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Seven', 'suite': 'diamonds', 'imageURl': '/assets/seven.jpg', 'imageBytes': '', 'folderId': 3, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Eight', 'suite': 'diamonds', 'imageURl': '/assets/eight.jpg', 'imageBytes': '', 'folderId': 3, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Nine', 'suite': 'diamonds', 'imageURl': '/assets/nine.jpg', 'imageBytes': '', 'folderId': 3, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Ten', 'suite': 'diamonds', 'imageURl': '/assets/ten.jpg', 'imageBytes': '', 'folderId': 3, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Jack', 'suite': 'diamonds', 'imageURl': '/assets/jack.jpg', 'imageBytes': '', 'folderId': 3, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Queen', 'suite': 'diamonds', 'imageURl': '/assets/queen.jpg', 'imageBytes': '', 'folderId': 3, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'King', 'suite': 'diamonds', 'imageURl': '/assets/king.jpg', 'imageBytes': '', 'folderId': 3, 'createdAt': DateTime.now().toIso8601String()});

// Clubs (folderId: 4)
await db.insert('cardstable', {'name': 'Ace', 'suite': 'clubs', 'imageURl': '/assets/ace.jpg', 'imageBytes': '', 'folderId': 4, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Two', 'suite': 'clubs', 'imageURl': '/assets/two.jpg', 'imageBytes': '', 'folderId': 4, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Three', 'suite': 'clubs', 'imageURl': '/assets/three.jpg', 'imageBytes': '', 'folderId': 4, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Four', 'suite': 'clubs', 'imageURl': '/assets/four.jpg', 'imageBytes': '', 'folderId': 4, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Five', 'suite': 'clubs', 'imageURl': '/assets/five.jpg', 'imageBytes': '', 'folderId': 4, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Six', 'suite': 'clubs', 'imageURl': '/assets/six.jpg', 'imageBytes': '', 'folderId': 4, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Seven', 'suite': 'clubs', 'imageURl': '/assets/seven.jpg', 'imageBytes': '', 'folderId': 4, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Eight', 'suite': 'clubs', 'imageURl': '/assets/eight.jpg', 'imageBytes': '', 'folderId': 4, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Nine', 'suite': 'clubs', 'imageURl': '/assets/nine.jpg', 'imageBytes': '', 'folderId': 4, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Ten', 'suite': 'clubs', 'imageURl': '/assets/ten.jpg', 'imageBytes': '', 'folderId': 4, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Jack', 'suite': 'clubs', 'imageURl': '/assets/jack.jpg', 'imageBytes': '', 'folderId': 4, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'Queen', 'suite': 'clubs', 'imageURl': '/assets/queen.jpg', 'imageBytes': '', 'folderId': 4, 'createdAt': DateTime.now().toIso8601String()});
await db.insert('cardstable', {'name': 'King', 'suite': 'clubs', 'imageURl': '/assets/king.jpg', 'imageBytes': '', 'folderId': 4, 'createdAt': DateTime.now().toIso8601String()});
  }
}