import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lalalala/provider/game_provider.dart';
import 'package:provider/provider.dart';

class SettingsDialog extends StatefulWidget {
  @override
  _SettingsDialog createState() => _SettingsDialog();
}

class _SettingsDialog extends State<SettingsDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[850], // Couleur d'arrière-plan sombre
      title: Text(
        "Paramètres",
        style: TextStyle(
          color: Colors.orangeAccent, // Couleur du titre
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20), // Espace entre le titre et les boutons

          // Bouton "Recommencer"
          ElevatedButton(
            onPressed: () {
              Provider.of<GameProvider>(context, listen: false).newGame();
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent, // Couleur du bouton
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            child: const Text("Recommencer"),
          ),

          const SizedBox(height: 10), // Espace entre les boutons

          // Bouton "Retourner au menu"
          ElevatedButton(
            onPressed: () {
              GoRouter.of(context).go('/');
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
