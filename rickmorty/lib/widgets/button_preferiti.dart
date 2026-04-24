import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickmorty/providers/preferiti_provider.dart';
import 'package:rickmorty/screens/preferiti_screen.dart';

class ButtonPreferiti extends StatelessWidget {
  const ButtonPreferiti({super.key});

  @override
  Widget build(BuildContext context) {
    final int favNumber = context.watch<PreferitiProvider>().numeroPreferiti;
    return GestureDetector(
        onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PreferitiScreen()),
        );
      },
      child: Padding
      ( padding:const EdgeInsets.only(right: 20.0, top: 10.0), 
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Icon(
            Icons.favorite, 
            size: 30, 
            color: Colors.black, // Cambiato in bianco per vederlo meglio nell'AppBar
          ),
          if (favNumber > 0)
            Positioned(
              top: -4,
              right: -4,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue, width: 1.5), 
                ),
                constraints: const BoxConstraints(
                  minWidth: 18,
                  minHeight: 18,
                ),
                child: Text(
                  '$favNumber',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    ));
  }
}