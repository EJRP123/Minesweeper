import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper/game/board_view.dart';
import 'package:minesweeper/game/number_minesweeper_display.dart';

import 'board_options.dart';
import 'cubit/board_cubit/board_cubit.dart';
import 'cubit/game_cubit/game_cubit.dart';

// Colors are based off this reddit posts
// https://www.reddit.com/r/Minesweeper/comments/qf1735/minesweeper_numbers_tier_list/
const List<Color> numberColors = [
  Colors.transparent, // default value (0)
  Color(0xFF0000fd),
  Color(0xFF017e00),
  Color(0xFFfe0000),
  Color(0xFF010082),
  Color(0xFF810101),
  Color(0xFF008080),
  Color(0xFF77008A),
  Color(0xFF808080),
  Color(0xFF2C2C2C) // Added for impossible number 9
];
const Color borderColor = Color(0xFF808080);
const Color backgroundColor = Color(0xFFc0c0c0);

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          title: BlocBuilder<GameCubit, GameState>(
            builder: (context, state) {
              return NumberMinesweeperDisplay(
                  numberToDisplay: context.read<BoardCubit>().state.numMines() - state.squareStates.where((e) => e.flag).length);
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
                await showDialog<BoardInitial>(
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
                Icons.settings,
                color: Colors.grey,
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
  }
}
