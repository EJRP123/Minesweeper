import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'cubit/game_cubit/game_cubit.dart';
import 'cubit/settings_cubit/settings_cubit.dart';

class Square extends StatelessWidget {
  final SquareState squareState;
  final int boardSize;

  const Square({super.key, required this.squareState, required this.boardSize});

  Color digitColor(SettingsState settingsState) {
    // Square widget is only used in the Board, thus when value == 0 then the
    // digit needs to be transparent, which is why it is hardcoded
    if (squareState.value == 0) {
      return Colors.transparent;
    }
    return settingsState.getDigitColor(squareState.value);
  }
  
  @override
  Widget build(BuildContext context) {
    // If chains FTW

    if (squareState.revealed) {
      return BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
                border: Border.all(color: state.borderColor),
                color: state.backgroundColor),
            padding:
                EdgeInsets.all((boardSize >= 400) ? 4000 / boardSize : 10.0),
            child: FittedBox(
                fit: BoxFit.fill,
                child: Text(
                  squareState.isMine() ? "*" : squareState.value.toString(),
                  style: TextStyle(
                      color: squareState.isNumber()
                          ? digitColor(state)
                          : Colors.black,
                      fontFamily: "minesweeper"),
                )),
          );
        },
      );
    }

    if (squareState.flag) {
      return flag();
    } else {
      return concealed();
    }
  }

  Widget concealed() {
    const assetName = "assets/minesweeper_tile.svg";
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              border: Border.all(color: state.borderColor),
              color: state.backgroundColor),
          child:
              FittedBox(fit: BoxFit.fill, child: SvgPicture.asset(assetName)),
        );
      },
    );
  }

  Widget flag() {
    const assetName = "assets/minesweeper_flag.svg";
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              border: Border.all(color: state.borderColor),
              color: state.backgroundColor),
          child:
              FittedBox(fit: BoxFit.fill, child: SvgPicture.asset(assetName)),
        );
      },
    );
  }
}
