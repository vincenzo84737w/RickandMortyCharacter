import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rickmorty/models/character.dart';
import 'package:rickmorty/services/api_service.dart';
import 'package:rickmorty/services/rick_morty_service.dart';
import 'package:rickmorty/screens/info_card.dart';
import 'package:rickmorty/widgets/button_preferiti.dart';
import 'package:rickmorty/widgets/item_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      appBar: AppBar(
        title:Center( 
          child: Text('Rick & Morty Characters'),
            ),
            actions: [
              const ButtonPreferiti()
            ],
          ),
      body: FutureBuilder<CharactersResponse>(
        future: _charactersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Errore: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            final characters = snapshot.data!.results;
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: characters.length,
              itemBuilder: (context, index) => CharacterCard(character: characters[index]),
            );
          }
          return const Center(child: Text('Nessun dato trovato'));
        },
      ),
    );
  }
}

