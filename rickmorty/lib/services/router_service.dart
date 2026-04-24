
import 'package:go_router/go_router.dart';
import 'package:rickmorty/screens/home_page.dart';
import 'package:rickmorty/screens/info_card.dart';
import 'package:rickmorty/models/character.dart'; 

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(), 
    ),
    GoRoute(
      path: '/dettagli',
      builder: (context, state) {
        // 3. ORA CHARACTER VERRÀ RICONOSCIUTO GRAZIE ALL'IMPORT
        final character = state.extra as Character;
        return InfoCard(character: character);
      },
    )
  ],
);