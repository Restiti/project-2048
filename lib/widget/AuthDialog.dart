import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lalalala/provider/ScoreProvider.dart';
import 'package:provider/provider.dart';
import '../provider/AuthProvider.dart';

class AuthDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Utilisation de listen: true pour mettre à jour l'UI lorsque l'état change
    final authProvider = Provider.of<AuthProvider>(context);
    final scoreProvider = Provider.of<ScoreProvider>(context);

    return AlertDialog(
      title: const Text(
        "Connexion",
        style: TextStyle(
          color: Colors.orangeAccent, // Couleur du titre
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),

          // Message de bienvenue ou bouton de connexion, se met à jour automatiquement
          authProvider.isSignedIn()
              ? Column(
                  children: [
                    Text(
                      'Bienvenue, ${authProvider.user!.displayName}!',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Meilleur Score : ${scoreProvider.bestScore}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              : const Text(
                  'Connectez-vous avec Google pour continuer.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),

          const SizedBox(height: 20), // Espace entre le texte et les boutons

          // Bouton de connexion ou déconnexion, se met à jour automatiquement
          ElevatedButton(
            onPressed: () {
              if (authProvider.isSignedIn()) {
                authProvider.signOut(); // Se déconnecter si déjà connecté
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
              } else {
                authProvider.signInWithGoogle(); // Se connecter avec Google
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: authProvider.isSignedIn()
                  ? Colors.redAccent
                  : Colors
                      .orangeAccent, // Rouge pour déconnexion, orange pour connexion
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: Text(
              authProvider.isSignedIn()
                  ? "Se déconnecter"
                  : "Se connecter avec Google",
            ),
          ),

          const SizedBox(height: 10), // Espace entre les boutons

          // Bouton pour retourner au menu principal
          ElevatedButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent, // Couleur du bouton
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: const Text("Retourner au menu"),
          ),
        ],
      ),
    );
  }
}
