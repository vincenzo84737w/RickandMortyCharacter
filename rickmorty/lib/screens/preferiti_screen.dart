import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickmorty/providers/preferiti_provider.dart';
import 'package:rickmorty/widgets/item_card.dart'; // Importa la tua card

class PreferitiScreen extends StatelessWidget {
  const PreferitiScreen({super.key});

  @override
  Widget build(BuildContext context) {
   
    final preferiti = context.watch<PreferitiProvider>().preferiti;

    return Scaffold(
      appBar: AppBar(
        title: const Text('I miei Preferiti'),
        centerTitle: true,
      ),
      body: preferiti.isEmpty
          ? const Center(
              child: Text(
                'Non hai ancora aggiunto preferiti!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: preferiti.length,
              itemBuilder: (context, index) {
                // Riutilizziamo la tua Item Card
                return CharacterCard(character: preferiti[index]);
              },
            ),
    );
  }
}