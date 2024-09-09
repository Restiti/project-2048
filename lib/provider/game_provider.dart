// Suggested code may be subject to a license. Learn more: ~LicenseLog:895146300.
import 'dart:math';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class GameProvider extends ChangeNotifier {
  int _score = 0;
  String _lastMoveDirection = ''; // Stocke la dernière direction
  List<List<int>> _grid = List.generate(4, (_) => List.filled(4, 0));
  bool _isGameOver = false; // Variable pour stocker l'état du jeu
  bool get isGameOver => _isGameOver; // Expose l'état de Game Over

  int get score => _score;
  String get lastMoveDirection =>
      _lastMoveDirection; // Getter pour la direction
  List<List<int>> get grid => _grid;

  void newGame() {
    _score = 0;
    _isGameOver = false;
    _lastMoveDirection = ''; // Réinitialiser la direction
    _grid = List.generate(4, (_) => List.filled(4, 0));
    addRandomTile();
    addRandomTile();
    notifyListeners();
  }

  void addRandomTile() {
    List<List<int>> emptyCells = [];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (_grid[i][j] == 0) {
          emptyCells.add([i, j]);
        }
      }
    }
    if (emptyCells.isNotEmpty) {
      Random random = Random();
      int randomIndex = random.nextInt(emptyCells.length);
      List<int> cell = emptyCells[randomIndex];
      _grid[cell[0]][cell[1]] = (random.nextInt(10) < 9) ? 2 : 4;
    }
  }

  void moveLeft() {
    bool moved = false;
    for (int i = 0; i < 4; i++) {
      List<int> newRow = _grid[i].where((tile) => tile != 0).toList();
      for (int j = 0; j < newRow.length - 1; j++) {
        if (newRow[j] == newRow[j + 1]) {
          newRow[j] *= 2;
          _score += newRow[j];
          newRow[j + 1] = 0;
        }
      }
      newRow = newRow.where((tile) => tile != 0).toList();
      while (newRow.length < 4) {
        newRow.add(0);
      }
      if (!ListEquality().equals(_grid[i], newRow)) {
        moved = true;
      }
      _grid[i] = newRow;
    }
    if (moved) {
      _lastMoveDirection = 'Left'; // Mettre à jour la direction
      addRandomTile();
      notifyListeners();
    }
  }

  void moveRight() {
    bool moved = false;
    for (int i = 0; i < 4; i++) {
      List<int> newRow =
          _grid[i].where((tile) => tile != 0).toList().reversed.toList();
      for (int j = 0; j < newRow.length - 1; j++) {
        if (newRow[j] == newRow[j + 1]) {
          newRow[j] *= 2;
          _score += newRow[j];
          newRow[j + 1] = 0;
        }
      }
      newRow = newRow.where((tile) => tile != 0).toList();
      while (newRow.length < 4) {
        newRow.add(0);
      }
      newRow = newRow.reversed.toList();
      if (!ListEquality().equals(_grid[i], newRow)) {
        moved = true;
      }
      _grid[i] = newRow;
    }
    if (moved) {
      _lastMoveDirection = 'Right'; // Mettre à jour la direction
      addRandomTile();
      notifyListeners();
    }
  }

  void moveUp() {
    bool moved = false;
    for (int j = 0; j < 4; j++) {
      List<int> newCol = [];
      for (int i = 0; i < 4; i++) {
        if (_grid[i][j] != 0) {
          newCol.add(_grid[i][j]);
        }
      }
      for (int i = 0; i < newCol.length - 1; i++) {
        if (newCol[i] == newCol[i + 1]) {
          newCol[i] *= 2;
          _score += newCol[i];
          newCol[i + 1] = 0;
        }
      }
      newCol = newCol.where((tile) => tile != 0).toList();
      while (newCol.length < 4) {
        newCol.add(0);
      }
      for (int i = 0; i < 4; i++) {
        if (_grid[i][j] != newCol[i]) {
          moved = true;
        }
        _grid[i][j] = newCol[i];
      }
    }
    if (moved) {
      _lastMoveDirection = 'Up'; // Mettre à jour la direction
      addRandomTile();
      notifyListeners();
    }
  }

  void moveDown() {
    bool moved = false;
    for (int j = 0; j < 4; j++) {
      List<int> newCol = [];
      for (int i = 0; i < 4; i++) {
        if (_grid[i][j] != 0) {
          newCol.add(_grid[i][j]);
        }
      }
      newCol = newCol.reversed.toList();
      for (int i = 0; i < newCol.length - 1; i++) {
        if (newCol[i] == newCol[i + 1]) {
          newCol[i] *= 2;
          _score += newCol[i];
          newCol[i + 1] = 0;
        }
      }
      newCol = newCol.where((tile) => tile != 0).toList();
      while (newCol.length < 4) {
        newCol.add(0);
      }
      newCol = newCol.reversed.toList();
      for (int i = 0; i < 4; i++) {
        if (_grid[i][j] != newCol[i]) {
          moved = true;
        }
        _grid[i][j] = newCol[i];
      }
    }
    if (moved) {
      _lastMoveDirection = 'Down'; // Mettre à jour la direction
      addRandomTile();
      notifyListeners();
    }
  }

  // Fonction pour vérifier si le jeu est terminé
  void checkGameOver() {
    // Vérifie s'il y a encore des cases vides
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (_grid[i][j] == 0) {
          return; // Il reste des cases vides, donc le jeu n'est pas fini
        }
      }
    }

    // Vérifie s'il est possible de fusionner des tuiles adjacentes
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        // Vérification des tuiles adjacentes
        if (i < 3 && _grid[i][j] == _grid[i + 1][j]) return; // En bas
        if (j < 3 && _grid[i][j] == _grid[i][j + 1]) return; // À droite
      }
    }

    // Si aucun mouvement possible, le jeu est terminé
    _isGameOver = true;
    notifyListeners();
  }
}
