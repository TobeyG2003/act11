import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart'; 
import '../database_setup.dart';
import '../main.dart' show dbHelper;
import '../main.dart' as models; 

class CardRepository {

  Future<List<models.Card>> getAllCards() async {
    final db = dbHelper.cardsdb;
    final result = await db.query('cardstable');
    return result.map((e) => models.Card.fromMap(e)).toList();
  }

  Future<List<models.Card>> getCardsByFolder(int folderId) async {
    final db = dbHelper.cardsdb;
    final result = await db.query(
      'cardstable',
      where: 'folderId = ?',
      whereArgs: [folderId],
    );
    return result.map((e) => models.Card.fromMap(e)).toList();
  }

  Future<List<models.Card>> getUnassignedCards() async {
    final db = dbHelper.cardsdb;
    final result = await db.query('cardstable', where: 'folderId IS NULL');
    return result.map((e) => models.Card.fromMap(e)).toList();
  }

  Future<int> insertCard(models.Card card) async {
    final db = dbHelper.cardsdb;

    // enforce max 6 cards per folder
    final countResult = await db.rawQuery(
      'SELECT COUNT(*) FROM cardstable WHERE folderId = ?',
      [card.folderId],
    );
    final count = Sqflite.firstIntValue(countResult) ?? 0;

    if (count >= 6) {
      throw Exception('This folder already has 6 cards.');
    }

    return await db.insert('cardstable', card.toMap());
  }

  Future<int> updateCard(models.Card card) async {
    final db = dbHelper.cardsdb;
    return await db.update(
      'cardstable',
      card.toMap(),
      where: 'id = ?',
      whereArgs: [card.id],
    );
  }

  Future<int> deleteCard(int id) async {
    final db = dbHelper.cardsdb;


    final folderResult = await db.query(
      'cardstable',
      columns: ['folderId'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (folderResult.isNotEmpty) {
      final folderId = folderResult.first['folderId'];
      if (folderId != null) {
        final countResult = await db.rawQuery(
          'SELECT COUNT(*) FROM cardstable WHERE folderId = ?',
          [folderId],
        );
        final count = Sqflite.firstIntValue(countResult) ?? 0;
        if (count <= 3) {
          throw Exception('Each folder must have at least 3 cards.');
        }
      }
    }

    return await db.delete(
      'cardstable',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> countCardsInFolder(int folderId) async {
    final db = dbHelper.cardsdb;
    final result = Sqflite.firstIntValue(
      await db.rawQuery(
        'SELECT COUNT(*) FROM cardstable WHERE folderId = ?',
        [folderId],
      ),
    );
    return result ?? 0;
  }

  Future<void> debugPrintAllCards() async {
    final db = dbHelper.cardsdb;
    final result = await db.query('cardstable');
    print('--- all cards in DB ---');
    for (final row in result) {
      print(row);
    }
  }
}
