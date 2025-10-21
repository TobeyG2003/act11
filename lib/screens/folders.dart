import 'package:flutter/material.dart';
import '../main.dart';  
import '../repository class/cardsrepo.dart';
import '../repository class/folderrepo.dart';


class FoldersScreen extends StatefulWidget {
  const FoldersScreen({super.key});
  @override
  State<FoldersScreen> createState() => _FoldersScreenState();
}
class _FoldersScreenState extends State<FoldersScreen> {
  final FolderRepository _folderRepo = FolderRepository();
  List<Folder> folders = [];

  @override
  void initState() {
    super.initState();
    _loadFolders();
  }

  Future<void> _loadFolders() async {
    final loadedFolders = await _folderRepo.getAllFolders();
    setState(() {
      folders = loadedFolders;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Folders')),
      body: ListView.builder(
        itemCount: folders.length,
        itemBuilder: (context, index) {
          final folder = folders[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: folder.previewImage != null && folder.previewImage.isNotEmpty
                  ? Image.asset(folder.previewImage, width: 50, height: 50)
                  : const SizedBox(width: 50, height: 50),
              title: Text(folder.name),
              subtitle: Text('${folder.cardCount} cards'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // placeholder for delete 
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CardsScreen(folder: folder),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
