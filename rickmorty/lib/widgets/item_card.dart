import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart'; 
import 'package:rickmorty/models/character.dart';
import 'package:rickmorty/screens/info_card.dart';
import 'package:rickmorty/providers/preferiti_provider.dart'; 

class CharacterCard extends StatelessWidget {
  final Character character;
  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    //controllo
    final isFav = context.watch<PreferitiProvider>().isPreferito(character);

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => InfoCard(character: character)),
          );
        },
        //doppio tocco
        onDoubleTap: () {
          if (isFav) {
            context.read<PreferitiProvider>().rimuoviPreferito(character);
          } else {
            context.read<PreferitiProvider>().addPreferito(character);
          }
        },
        child: Row(
          children: [
            Image.network(character.image, width: 120, height: 120, fit: BoxFit.cover),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(character.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('${character.status} - ${character.species}'),
                  ],
                ),
              ),
            ),
            // 
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : null,
                ),
                onPressed: () {
                  if (isFav) {
                    context.read<PreferitiProvider>().rimuoviPreferito(character);
                  } else {
                    context.read<PreferitiProvider>().addPreferito(character);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}