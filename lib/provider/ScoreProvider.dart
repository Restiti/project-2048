import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ScoreProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  int _bestScore = 0; // Stocke le meilleur score localement

  int get bestScore => _bestScore; // Getter pour accéder au meilleur score

  // Méthode pour récupérer le meilleur score depuis Firestore
  Future<void> fetchBestScore() async {
    try {
      final user = _auth.currentUser;

      if (user != null) {
        // Récupère le document du joueur depuis Firestore
        DocumentSnapshot snapshot = await _firestore.collection('scores').doc(user.uid).get();

        if (snapshot.exists && snapshot.data() != null) {
          // Si un score existe, on le récupère, sinon on le met à 0
          _bestScore = snapshot['bestScore'] ?? 0;
        } else {
          // Si le document n'existe pas, initialise le score à 0
          _bestScore = 0;
        }
      } else {
        _bestScore = 0; // Si aucun utilisateur n'est connecté, le score est 0
      }
      notifyListeners();
    } catch (e) {
      print('Erreur lors de la récupération du meilleur score : $e');
    }
  }

  // Méthode pour mettre à jour le meilleur score si le nouveau score est meilleur
  Future<void> updateBestScore(int newScore) async {
    final user = _auth.currentUser;

    if (user != null) {
      try {
        // Vérifie si le nouveau score est meilleur que l'actuel
        if (newScore > _bestScore) {
          _bestScore = newScore;

          // Ajoute un print pour vérifier si la fonction est bien appelée
          print('Nouveau meilleur score : $_bestScore');

          // Met à jour le score dans Firestore
          await _firestore.collection('scores').doc(user.uid).set({
            'bestScore': _bestScore,
          });

          print('Score mis à jour dans Firestore'); // Vérification
          notifyListeners(); // Informe les widgets de la mise à jour
        } else {
          print('Le score n\'est pas meilleur, pas de mise à jour');
        }
      } catch (e) {
        print('Erreur lors de la mise à jour du meilleur score : $e');
      }
    } else {
      print('Utilisateur non authentifié, impossible de mettre à jour le score.');
    }
  }
}
