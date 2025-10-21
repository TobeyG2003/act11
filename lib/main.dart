import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';
import 'database_setup.dart';
import 'dart:async';
import 'screens/folders.dart';

final dbHelper = DatabaseHelper();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dbHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Organizer App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Card Organizer App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String urlstring = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const FoldersScreen(),

    );
  }
  void _insertcard(String name, String suit) async {
	    // row to insert
      int num;
      if (suit == 'spades') {
        num = 1;
      } else if (suit == 'hearts') {
        num = 2;
      } else if (suit == 'diamonds') {
        num = 3;
      } else {
        num = 4;
      }
	    Map<String, dynamic> row = {
	      DatabaseHelper.cardname: name,
	      DatabaseHelper.cardsuit: suit,
        DatabaseHelper.cardimageUrl: '/assets/${name.toLowerCase()}.png',
        DatabaseHelper.cardfolderID: num,
        DatabaseHelper.cardcreatedAt: DateTime.now().toIso8601String(),
	    };
	    final id = await dbHelper.insertcard(row);
	    debugPrint('inserted row id: $id');
	  }
void _update(int id, String name, String suit) async {
    int num;
      if (suit == 'spades') {
        num = 1;
      } else if (suit == 'hearts') {
        num = 2;
      } else if (suit == 'diamonds') {
        num = 3;
      } else {
        num = 4;
      }
	    // row to update
	    Map<String, dynamic> row = {
	      DatabaseHelper.cardid: id,
	      DatabaseHelper.cardname: name,
        DatabaseHelper.cardsuit: suit,
	      DatabaseHelper.cardimageUrl: '/assets/${name.toLowerCase()}.png',
        DatabaseHelper.cardfolderID: num,
        DatabaseHelper.cardcreatedAt: DateTime.now().toIso8601String(),
	    };
	    final rowsAffected = await dbHelper.updatecard(row);
	    debugPrint('updated $rowsAffected row(s)');
	  }
void _delete(int id) async {
	    final rowsDeleted = await dbHelper.delete(id);
	    debugPrint('deleted $rowsDeleted card(s): row $id');
	  }
void _getimage(int id) async {
    urlstring = await dbHelper.getcardimage(id);
    debugPrint('image url: $urlstring');
}
}

class Folder {
  int? id;
  String name;
  String? previewImage;
  DateTime createdAt;

  Folder({this.id, required this.name, this.previewImage, required this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'previewImage': previewImage,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Folder.fromMap(Map<String, dynamic> map) {
    return Folder(
      id: map['id'],
      name: map['name'],
      previewImage: map['previewImage'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}

class Card {
  int? id;
  String name;
  String suit;
  String imageUrl;
  String? imageBytes; // base64 string
  int? folderId;
  DateTime createdAt;

  Card({
    this.id,
    required this.name,
    required this.suit,
    required this.imageUrl,
    this.imageBytes,
    this.folderId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'suit': suit,
      'imageUrl': imageUrl,
      'imageBytes': imageBytes,
      'folderId': folderId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Card.fromMap(Map<String, dynamic> map) {
    return Card(
      id: map['id'],
      name: map['name'] ?? '' ,
      suit: map['suit'] ?? '',
      imageUrl: ((map['imageUrl'] ?? map['imageURl'] ?? '').replaceFirst(RegExp(r'^/'), '')),
      imageBytes: map['imageBytes'],
      folderId: map['folderId'],
      createdAt: DateTime.parse(map['createdAt']?? '') ?? DateTime.now(),
    );
  }
}
