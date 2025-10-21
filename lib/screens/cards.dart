import 'package:flutter/material.dart';
import '../main.dart';  
import '../repository class/cardsrepo.dart';
import '../repository class/folderrepo.dart';

class CardsScreen extends StatefulWidget {
  final Folder folder;
  const CardsScreen({super.key, required this.folder});
  @override
  State<CardsScreen> createState() => _CardsScreenState();
}
class _CardsScreenState extends State<CardsScreen> {
  final CardRepository _cardRepo = CardRepository();
  List<CardModel> cards = [];

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  Future<void> _loadCards() async {
    final loadedCards = await _cardRepo.getCardsByFolderId(widget.folder.id);
    setState(() {
      cards = loadedCards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.folder.name} Cards')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // placeholder for add 
        },
        child: const Icon(Icons.add),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];
          return Stack(
            children: [
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    card.imageURl != null && card.imageURl.isNotEmpty
                        ? Image.asset(card.imageURl, width: 60, height: 60)
                        : const SizedBox(width: 60, height: 60),
                    const SizedBox(height: 4),
                    Text(card.name),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
                      onPressed: () {
                        // placeholder for update 
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                      onPressed: () {
                        // placeholder for delete 
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}