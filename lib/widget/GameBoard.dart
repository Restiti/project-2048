import 'package:flutter/material.dart';
import 'package:lalalala/widget/TileWidget.dart';
import 'package:provider/provider.dart';
import '../provider/game_provider.dart';
import 'ScoreBox.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        return Column(
          children: [
            // Affiche le score
            ScoreBox(score: gameProvider.score),
            const SizedBox(height: 20),

            // Affiche la grille du jeu
            Expanded(
              child: GridView.builder(
                physics:
                    const NeverScrollableScrollPhysics(), // Désactive le défilement

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: 16,
                itemBuilder: (context, index) {
                  int row = index ~/ 4;
                  int col = index % 4;
                  int value = gameProvider.grid[row][col];
                  return TileWidget(value: value);
                },
              ),
            ),
            const SizedBox(height: 20),

            // Affiche la dernière direction de mouvement
            Text(
              'Last Move: ${gameProvider.lastMoveDirection}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }
}
