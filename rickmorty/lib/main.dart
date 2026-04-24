import 'package:flutter/material.dart';
import 'package:rickmorty/providers/preferiti_provider.dart';
import 'package:rickmorty/screens/home_page.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(
  ChangeNotifierProvider(
    create: (context) => PreferitiProvider(),
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rick & Morty',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      // Carica direttamente la classe HomePage dal file esterno
      home: const HomePage(),
    );
  }
}