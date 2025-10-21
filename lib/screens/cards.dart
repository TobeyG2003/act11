import 'package:flutter/material.dart';
import '../repository_class/cardsrepo.dart';
import '../main.dart' as models;

class CardsScreen extends StatefulWidget {
  final models.Folder folder;
  const CardsScreen({super.key, required this.folder});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  final CardRepository _cardRepo = CardRepository();
  List<models.Card> cards = [];

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  Future<void> _loadCards() async {
  await _cardRepo.debugPrintAllCards();
  final loadedCards = await _cardRepo.getCardsByFolder(widget.folder.id!);
  print('cards for ${widget.folder.name}: ${loadedCards.length}');
  setState(() {
    cards = loadedCards;
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.folder.name)),
      body: ListView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: Image.asset(card.imageUrl, width: 50, height: 50),
              title: Text(card.name),
              subtitle: Text(card.suit),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await _cardRepo.deleteCard(card.id!);
                      await _loadCards();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () async {
                      // placeholder for update
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
 
          await _cardRepo.insertCard(
            models.Card(
              name: 'Ace',
              suit: widget.folder.name.toLowerCase(),
              imageUrl: '/assets/ace.png',
              createdAt: DateTime.now(),
            ),
          );
          await _loadCards();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
