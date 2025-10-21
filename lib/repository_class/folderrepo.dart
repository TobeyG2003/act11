import '../database_setup.dart';
import '../main.dart' show dbHelper;
import '../main.dart' as models;

class FolderRepository {

  Future<List<models.Folder>> getAllFolders() async {
    final db = dbHelper.foldersdb;
    final result = await db.query('folderstable');
    return result.map((e) => models.Folder.fromMap(e)).toList();
  }

  Future<models.Folder?> getFolder(int id) async {
    final db = dbHelper.foldersdb;
    final result =
        await db.query('folderstable', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) return models.Folder.fromMap(result.first);
    return null;
  }

  Future<int> insertFolder(models.Folder folder) async {
    final db = dbHelper.foldersdb;
    return await db.insert('folderstable', folder.toMap());
  }

  Future<int> updateFolder(models.Folder folder) async {
    final db = dbHelper.foldersdb;
    return await db.update(
      'folderstable',
      folder.toMap(),
      where: 'id = ?',
      whereArgs: [folder.id],
    );
  }

  Future<int> deleteFolder(int id) async {
    final db = dbHelper.foldersdb;
    return await db.delete('folderstable', where: 'id = ?', whereArgs: [id]);
  }
}

