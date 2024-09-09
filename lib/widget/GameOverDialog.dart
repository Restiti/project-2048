import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:lalalala/provider/game_provider.dart'; // Vérifie que le chemin est correct

class GameOverDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Récupérer le score actuel depuis le GameProvider
    final gameProvider = Provider.of<GameProvider>(context, listen: false);
    final int finalScore = gameProvider.score;

    return AlertDialog(
      backgroundColor: Colors.grey[850], // Couleur d'arrière-plan sombre
      title: Text(
        "Game Over",
        style: TextStyle(
          color: Colors.redAccent, // Couleur du titre "Game Over"
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),

          // Affichage du score final
          Text(
            'Votre score : $finalScore',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20), // Espace entre le score et les boutons

          // Bouton pour rejouer
          ElevatedButton(
            onPressed: () {
              gameProvider.newGame(); // Recommencer une nouvelle partie
              Navigator.of(context).pop(); // Fermer le dialogue Game Over
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent, // Couleur du bouton
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              textStyle:
              const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            child: const Text("Rejouer"),
          ),

          const SizedBox(height: 10), // Espace entre les boutons

          // Bouton pour retourner au menu principal
          ElevatedButton(
            onPressed: () {
              GoRouter.of(context).go('/'); // Retourner au menu principal
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent, // Couleur du bouton
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              textStyle:
              const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            child: const Text("Retourner au menu"),
          ),
        ],
      ),
    );
  }
}
