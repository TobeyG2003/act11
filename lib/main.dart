import 'package:flutter/material.dart';

void main() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          ],
        ),
      ),
    );
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
      name: map['name'],
      suit: map['suit'],
      imageUrl: map['imageUrl'],
      imageBytes: map['imageBytes'],
      folderId: map['folderId'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}

