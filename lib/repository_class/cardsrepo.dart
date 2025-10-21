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
