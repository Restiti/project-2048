import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lalalala/provider/game_provider.dart';
import 'package:lalalala/widget/AuthDialog.dart';
import 'package:provider/provider.dart';

import '../provider/ScoreProvider.dart';

class MenuHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scoreProvider = Provider.of<ScoreProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.grey[900], // Couleur de fond sombre
      body: Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center, // Centre les éléments verticalement
          crossAxisAlignment:
          CrossAxisAlignment.center, // Centre les éléments horizontalement
          children: [
            // Titre du jeu
            Text(
              "2048",
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent, // Couleur du titre
              ),
            ),
            const SizedBox(height: 300), // Espace entre le titre et les boutons

            // Bouton pour créer une partie
            ElevatedButton(
              onPressed: () {
                Provider.of<GameProvider>(context, listen: false).newGame();
                GoRouter.of(context).go('/play');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent, // Couleur du bouton
                padding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: const Tooltip(
                message: "Créer une partie",
                child: Text("Créer une partie"),
              ),
            ),
            const SizedBox(height: 20), // Espace entre les boutons

            // Bouton pour accéder au profil
            ElevatedButton(
              onPressed: () {
                scoreProvider.fetchBestScore();
                _AuthPopUp(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors
                    .blueAccent, // Couleur différente pour le bouton profil
                padding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: const Text("Mon profil"),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _AuthPopUp(BuildContext context) async {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AuthDialog();
      });
}
