import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rickmorty/models/character.dart';
import 'package:rickmorty/services/api_service.dart';
import 'package:rickmorty/services/rick_morty_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:rickmorty/info_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
      home: const CharacterListScreen(),
    );
  }
}

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  // Inizializziamo il service (essendo un Singleton, ApiService() richiama l'istanza interna)
  late final RickMortyService _service;
  late Future<CharactersResponse> _charactersFuture;

  @override
  void initState() {
    super.initState();
    _service = RickMortyService(ApiService());
    _charactersFuture = _service.getAllCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rick & Morty Characters')),
      body: FutureBuilder<CharactersResponse>(
        future: _charactersFuture,
        builder: (context, snapshot) {
          // 1. Caso Caricamento
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Caso Errore
          if (snapshot.hasError) {
            return Center(child: Text('Errore: ${snapshot.error}'));
          }

          // 3. Caso Successo
          if (snapshot.hasData) {
            final characters = snapshot.data!.results;

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: characters.length,
              itemBuilder: (context, index) {
                final char = characters[index];
                return CharacterCard(character: char);
              },
            );
          }

          return const Center(child: Text('Nessun dato trovato'));
        },
      ),
    );
  }
}

// Widget della Card personalizzata
class CharacterCard extends StatelessWidget {
  final Character character;

  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child:GestureDetector(
        onTap:(){
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context)=> InfoCard(character:character),
              ),
          );
        },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Immagine del personaggio
          Image.network(
            character.image,
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
          // Dettagli
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      // Pallino colorato per lo stato
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: character.status == 'Alive' ? Colors.green : Colors.red,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text('${character.status} - ${character.species}'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Last known location:',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(character.location.name, style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }
}