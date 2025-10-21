import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'main.dart';

class FolderRepository {
  final dbHelper = DatabaseHelper();

  Future<List<Folder>> getAllFolders() async {
    final db = dbHelper.foldersdb;
    final result = await db.query('folderstable');
    return result.map((e) => Folder.fromMap(e)).toList();
  }

  Future<Folder?> getFolder(int id) async {
    final db = dbHelper.foldersdb;
    final result = await db.query('folderstable', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) return Folder.fromMap(result.first);
    return null;
  }

  Future<int> insertFolder(Folder folder) async {
    final db = dbHelper.foldersdb;
    return await db.insert('folderstable', folder.toMap());
  }

  Future<int> updateFolder(Folder folder) async {
    final db = dbHelper.foldersdb;
    return await db.update('folderstable', folder.toMap(), where: 'id = ?', whereArgs: [folder.id]);
  }

  Future<int> deleteFolder(int id) async {
    final db = dbHelper.foldersdb;
    return await db.delete('folderstable', where: 'id = ?', whereArgs: [id]);
  }
}

