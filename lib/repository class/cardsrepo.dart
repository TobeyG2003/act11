import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'main.dart';


class CardRepository {
  final dbHelper = DatabaseHelper();

  Future<List<CardModel>> getAllCards() async {
    final db = dbHelper.cardsdb;
    final result = await db.query('cardstable');
    return result.map((e) => CardModel.fromMap(e)).toList();
  }

  Future<List<CardModel>> getCardsByFolder(int folderId) async {
    final db = dbHelper.cardsdb;
    final result = await db.query('cardstable', where: 'folderId = ?', whereArgs: [folderId]);
    return result.map((e) => CardModel.fromMap(e)).toList();
  }

  Future<List<CardModel>> getUnassignedCards() async {
    final db = dbHelper.cardsdb;
    final result = await db.query('cardstable', where: 'folderId IS NULL');
    return result.map((e) => CardModel.fromMap(e)).toList();
  }

  Future<int> insertCard(CardModel card) async {
    final db = dbHelper.cardsdb;
    return await db.insert('cardstable', card.toMap());
  }

  Future<int> updateCard(CardModel card) async {
    final db = dbHelper.cardsdb;
    return await db.update('cardstable', card.toMap(), where: 'id = ?', whereArgs: [card.id]);
  }

  Future<int> deleteCard(int id) async {
    final db = dbHelper.cardsdb;
    return await db.delete('cardstable', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> countCardsInFolder(int folderId) async {
    final db = dbHelper.cardsdb;
    final result = Sqflite.firstIntValue(await db.rawQuery(
        'SELECT COUNT(*) FROM cardstable WHERE folderId = ?', [folderId]));
    return result ?? 0;
  }
}
