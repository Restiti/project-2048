import 'package:flutter/material.dart';
import 'package:lalalala/provider/game_provider.dart';
import 'package:lalalala/widget/GameBoard.dart';
import 'package:lalalala/widget/GameOverDialog.dart';
import 'package:lalalala/widget/Settings.dart';
import 'package:provider/provider.dart';

import '../provider/ScoreProvider.dart';

class GameHomePage extends StatelessWidget {
  const GameHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent, // Couleur de la barre d'app
        title: const Text('2048 Game'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              _settingsPopUp(context);
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[900], // Couleur d'arrière-plan de la page
      body: Consumer<GameProvider>(
        builder: (context, gameProvider, child) {
          if (Provider.of<GameProvider>(context, listen: true).isGameOver) {
            // Afficher la boîte de dialogue Game Over si le jeu est terminé
            Future.delayed(Duration.zero, () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  final scoreProvider = Provider.of<ScoreProvider>(context);
                  final gameProvider = Provider.of<GameProvider>(context);
                  scoreProvider.updateBestScore(gameProvider.score);
                  return GameOverDialog();
                },
              );
            });
          }
          return Column(
              mainAxisAlignment:
              MainAxisAlignment.center, // Centre verticalement les éléments
              crossAxisAlignment:
              CrossAxisAlignment.center, // Centre horizontalement les éléments
              children: [
                const SizedBox(height: 20),

                // Partie principale du jeu avec la grille
                Expanded(
                  child: Center(
                    child: GestureDetector(
                      onVerticalDragEnd: (details) {
                        if (details.primaryVelocity! < 0) {
                          // Swipe Up
                          Provider.of<GameProvider>(context, listen: false)
                              .moveUp();
                        } else if (details.primaryVelocity! > 0) {
                          // Swipe Down
                          Provider.of<GameProvider>(context, listen: false)
                              .moveDown();
                        }
                      },
                      onHorizontalDragEnd: (details) {
                        if (details.primaryVelocity! < 0) {
                          // Swipe Left
                          Provider.of<GameProvider>(context, listen: false)
                              .moveLeft();
                        } else if (details.primaryVelocity! > 0) {
                          // Swipe Right
                          Provider.of<GameProvider>(context, listen: false)
                              .moveRight();
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child:
                        GameBoard(), // Gère les couleurs du plateau dans GameBoard
                      ),
                    ),
                  ),
                ),
              ]
          );
        }
      ),
    );
  }
}

Future<void> _settingsPopUp(BuildContext context) async {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return SettingsDialog();
      });
}
