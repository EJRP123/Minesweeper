import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/settings_cubit/settings_cubit.dart';

class NumberMinesweeperDisplay extends StatelessWidget {
  final int numberToDisplay;

  const NumberMinesweeperDisplay({super.key, required this.numberToDisplay});

  @override
  Widget build(BuildContext context) {
    final numberOfDigits = numberToDisplay > 0 ? (log(numberToDisplay + 1) / ln10).ceil() : 1;
    final digits = List.filled(numberOfDigits, -1);

    int tempNum = numberToDisplay;
    int iteration = numberOfDigits - 1;
    while (iteration >= 0) {
      digits[iteration] = tempNum % 10;
      tempNum ~/= 10;
      iteration--;
    }

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: digits
              .map((digit) => FittedBox(
                    child: Text(digit.toString(),
                        style: TextStyle(
                            fontSize: 50,
                            color: state.getDigitColor(digit),
                            fontFamily: "minesweeper")),
                  ))
              .toList(),
        );
      },
    );
  }
}
