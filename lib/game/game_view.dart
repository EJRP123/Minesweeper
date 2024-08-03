import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper/game/board_view.dart';
import 'package:minesweeper/game/number_minesweeper_display.dart';
import 'package:minesweeper/game/settings.dart';

import 'board_options.dart';
import 'cubit/board_cubit/board_cubit.dart';
import 'cubit/game_cubit/game_cubit.dart';
import 'cubit/settings_cubit/settings_cubit.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
  builder: (context, settingState) {
    return Scaffold(
        backgroundColor: settingState.backgroundColor,
        appBar: AppBar(
          backgroundColor: settingState.backgroundColor,
          title: BlocBuilder<GameCubit, GameState>(
            builder: (context, state) {
              final numFlags = state.squareStates.where((e) => e.flag).length;
              final numMines = context.read<BoardCubit>().state.numMines();

              return NumberMinesweeperDisplay(
                  numberToDisplay: max(numMines - numFlags, 0));
            },
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                final boardState = context.read<BoardCubit>().state;
                context
                    .read<GameCubit>()
                    .resetBoard(boardState.height * boardState.width);
              },
              icon: const FittedBox(
                child: Icon(
                  Icons.restart_alt_rounded,
                  // I know hardcoded constants are bad, but double.maxFinite doe not work
                  size: 500.0,
                  color: Colors.white,
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return BlocProvider<BoardCubit>.value(
                      value: context.read<BoardCubit>(),
                      child: BoardOptions(
                          initialValue: context.read<BoardCubit>().state),
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.dashboard_customize,
                color: Colors.black54,
              ),
            ),
            IconButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return BlocProvider<SettingsCubit>.value(
                      value: context.read<SettingsCubit>(),
                      child: const Settings(),
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.black54,
              ),
            )
          ],
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider<BoardCubit>.value(
                value: BlocProvider.of<BoardCubit>(context)),
            BlocProvider<GameCubit>.value(
                value: BlocProvider.of<GameCubit>(context)),
          ],
          child: const BoardView(),
        ));
  },
);
  }
}
