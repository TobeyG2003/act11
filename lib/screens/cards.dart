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
    if (loadedCards.length > 6){
        loadedCards.removeRange(6,loadedCards.length);
    }
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
                      final count = await _cardRepo.countCardsInFolder(widget.folder.id!);
                      if (count <= 3) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Each folder must have at least 3 cards.'),
                          ),
                        );
                        return;
                      }

                      await _cardRepo.deleteCard(card.id!);
                      await _loadCards();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () async {
                      final newNameController = TextEditingController(text: card.name);
                      final newSuitController = TextEditingController(text: card.suit);

                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Edit Card'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: newNameController,
                                decoration: const InputDecoration(labelText: 'Name'),
                              ),
                              TextField(
                                controller: newSuitController,
                                decoration: const InputDecoration(labelText: 'Suit'),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                final updatedCard = models.Card(
                                  id: card.id,
                                  name: newNameController.text.trim(),
                                  suit: newSuitController.text.trim(),
                                  imageUrl:
                                      '/assets/${newNameController.text.trim().toLowerCase()}.png',
                                  folderId: card.folderId,
                                  createdAt: DateTime.now(),
                                );

                                await _cardRepo.updateCard(updatedCard);
                                Navigator.pop(context);
                                await _loadCards();
                              },
                              child: const Text('Save'),
                            ),
                          ],
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final count = await _cardRepo.countCardsInFolder(widget.folder.id!);
          if (count >= 6) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Each folder can only have up to 6 cards.'),
              ),
            );
            return;
          }

          final nameController = TextEditingController();
          final suitController =
              TextEditingController(text: widget.folder.name.toLowerCase());

          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Add Card'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: suitController,
                    decoration: const InputDecoration(labelText: 'Suit'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    final name = nameController.text.trim();
                    final suit = suitController.text.trim();

                    if (name.isEmpty || suit.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Both fields required.')),
                      );
                      return;
                    }

                    final newCard = models.Card(
                      name: name,
                      suit: suit,
                      imageUrl: '/assets/${name.toLowerCase()}.png',
                      folderId: widget.folder.id!,
                      createdAt: DateTime.now(),
                    );

                    await _cardRepo.insertCard(newCard);
                    Navigator.pop(context);
                    await _loadCards();
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
