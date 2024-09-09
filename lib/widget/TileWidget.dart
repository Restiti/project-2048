import 'package:flutter/material.dart';

class TileWidget extends StatelessWidget {
  final int value;

  const TileWidget({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getTileColor(value),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: value != 0
            ? Text(
                value.toString(),
                style: TextStyle(
                  fontSize: _getTileFontSize(value),
                  fontWeight: FontWeight.bold,
                  color: _getTileTextColor(value),
                ),
              )
            : null,
      ),
    );
  }

  Color _getTileColor(int value) {
    switch (value) {
      case 2:
        return Colors.yellow[100]!;
      case 4:
        return Colors.yellow[200]!;
      case 8:
        return Colors.orange[300]!;
      case 16:
        return Colors.orange[400]!;
      case 32:
        return Colors.orange[500]!;
      case 64:
        return Colors.red[400]!;
      case 128:
        return Colors.red[500]!;
      case 256:
        return Colors.red[600]!;
      case 512:
        return Colors.red[700]!;
      case 1024:
        return Colors.red[800]!;
      case 2048:
        return Colors.red[900]!;
      default:
        return Colors.grey[300]!;
    }
  }

  double _getTileFontSize(int value) {
    if (value < 100) {
      return 30;
    } else if (value < 1000) {
      return 24;
    } else {
      return 18;
    }
  }

  Color _getTileTextColor(int value) {
    return (value < 8) ? Colors.grey[800]! : Colors.white;
  }
}
