import 'dart:math';

import 'package:flutter/material.dart';
import 'package:minesweeper/game/game_view.dart';

class NumberMinesweeperDisplay extends StatelessWidget {
  final int numberToDisplay;

  const NumberMinesweeperDisplay({super.key, required this.numberToDisplay});

  @override
  Widget build(BuildContext context) {
    final numberOfDigits = (log(numberToDisplay + 1) / ln10).ceil();
    final digits = List.filled(numberOfDigits, -1);

    int tempNum = numberToDisplay;
    int iteration = numberOfDigits - 1;
    while (iteration >= 0) {
      digits[iteration] = tempNum % 10;
      tempNum ~/= 10;
      iteration--;
    }

    final numberWidgets = digits
        .map((digit) => FittedBox(
          child: Text(digit.toString(),
              style: TextStyle(
                fontSize: 50,
                  color: digit != 0 ? numberColors[digit] : Colors.grey.shade700,
                  fontFamily: "minesweeper")),
        ))
        .toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: numberWidgets,
    );
  }
}
