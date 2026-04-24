import 'package:flutter/material.dart';
import 'package:rickmorty/models/character.dart';

class InfoCard extends StatelessWidget{
  final Character character;
  
  const InfoCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(tag: 'avatar-${character.id}', 
            child: Image.network(
              character.image,
              width: double.infinity,
              height: 350,
              fit:BoxFit.cover
            ),
            ),
          Padding(padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //info personaggio
            const Text(
              "Informazioni",
              style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const Divider(),
            _infoRow("Stato", character.status),
            _infoRow("Specie", character.species),
            _infoRow("Genere", character.gender),
            _infoRow("Origine", character.origin.name),
            _infoRow("Posizione attuale", character.location.name),
                  
            const SizedBox(height: 30),

            //episodi
            Text(
              "Apparizioni (${character.episode.length})",
              style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const Divider(),

            //contenitori episodi

            Wrap(
                    spacing: 8.0, // spazio orizzontale
                    runSpacing: 4.0, // spazio verticale
                    children: character.episode.map((url) {
                      // Estraiamo il numero dell'episodio dall'URL (es: https://.../episode/1)
                      final episodeNumber = url.split('/').last;
                      return Chip(
                        label: Text("Episodio $episodeNumber"),
                        backgroundColor: Colors.green.withOpacity(0.1),
                        avatar: const Icon(Icons.movie_creation_outlined, size: 16),
                      );
                    }).toList(),
            ),
            ],
          ),
          )
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }

}


Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

