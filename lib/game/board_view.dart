import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:minesweeper/game/cubit/game_cubit/game_cubit.dart';

import 'cubit/board_cubit/board_cubit.dart';
import 'square.dart';

class BoardView extends StatelessWidget {
  const BoardView({super.key});

  List<int> _getAdjacentSquares(int x, int y, int boardWidth, int boardHeight) {
    final result = <int>[];

    int index(int x, int y) => boardWidth * y + x;

    if (y != 0) result.add(index(x, y - 1));
    if (y + 1 != boardHeight) result.add(index(x, y + 1));
    if (x != 0) result.add(index(x - 1, y));
    if (x + 1 != boardWidth) result.add(index(x + 1, y));

    if (x != 0 && y != 0) result.add(index(x - 1, y - 1));
    if (x != 0 && y + 1 != boardHeight) result.add(index(x - 1, y + 1));
    if (x + 1 != boardWidth && y != 0) result.add(index(x + 1, y - 1));
    if (x + 1 != boardWidth && y + 1 != boardHeight) {
      result.add(index(x + 1, y + 1));
    }

    return result;
  }

  void revealSquare(List<int> result, BoardState boardState,
      GameState gameState, int index, bool isPressingControl) {
    if (!gameState.squareStates[index].flag &&
        !gameState.squareStates[index].revealed) {
      result.add(index);
    }

    if (isPressingControl || gameState.squareStates[index].value == 0) {
      int x = index % boardState.width;
      int y = index ~/ boardState.width;
      _getAdjacentSquares(x, y, boardState.width, boardState.height)
          .where((element) =>
              !gameState.squareStates[element].revealed &&
              !gameState.squareStates[element].flag &&
              !result.contains(element))
          .forEach((element) {
        revealSquare(result, boardState, gameState, element, false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final gameState = context.read<GameCubit>();

    if (gameState.state.squareStates.isEmpty) {
      return const Center(
        child: Text(
          "Set the board dimensions and mine density to play!",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black,
              fontFamily: "impact",
              fontSize: 60,
              fontWeight: FontWeight.bold),
        ),
      );
    }

    return InteractiveViewer(
      panEnabled: true,
      panAxis: PanAxis.free,
      minScale: 0.25,
      maxScale: 4,
      child: Center(
        child: BlocBuilder<BoardCubit, BoardState>(
          builder: (context, state) {
            // Always reseting the board when the board dimensions
            // or the density changes
            gameState.resetBoard(state.width * state.height);

            return AspectRatio(
              aspectRatio: state.width / state.height,
              child: LayoutGrid(
                  columnSizes: List.filled(state.width, 1.fr),
                  rowSizes: List.filled(state.height, 1.fr),
                  children: List.generate(state.width * state.height, (index) {
                    return GestureDetector(
                      onTap: () async => await leftClickedSquare(
                          gameState, index, state, context),
                      onSecondaryTap: () =>
                          rightClickedSquare(gameState, index),
                      child: Stack(children: [
                        SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: BlocBuilder<GameCubit, GameState>(
                              buildWhen: (previousState, state) =>
                                  previousState.squareStates[index] !=
                                  state.squareStates[index],
                              builder: (context, state) {
                                return Square(
                                  squareState: state.squareStates[index],
                                  boardSize: state.squareStates.length,
                                );
                              },
                            )),
                      ]),
                    );
                  })),
            );
          },
        ),
      ),
    );
  }

  void rightClickedSquare(GameCubit gameState, int index) {
    final squareState = gameState.state.squareStates[index];
    if (squareState.revealed) return;
    if (squareState.flag) {
      gameState.unFlag(index);
    } else {
      gameState.flag(index);
    }
  }

  Future<void> leftClickedSquare(GameCubit gameState, int index,
      BoardState state, BuildContext context) async {
    if (gameState.state.firstClick) {
      gameState.generateValidBoard(
          index, state.numMines(), state.width, state.height);
    }

    final squareState = gameState.state.squareStates[index];
    final isControlPressed = HardwareKeyboard.instance.physicalKeysPressed
        .contains(PhysicalKeyboardKey.controlLeft);

    if ((squareState.revealed || squareState.flag) && !isControlPressed) {
      return;
    }

    List<int> indicesToReveal = <int>[];
    revealSquare(
        indicesToReveal, state, gameState.state, index, isControlPressed);
    gameState.revealBulk(indicesToReveal);

    final areAllNumbersRevealed = !gameState.state.squareStates
        .any((element) => element.isNumber() && !element.revealed);
    final isMineRevealed = gameState.state.squareStates
        .any((element) => element.isMine() && element.revealed);
    if (areAllNumbersRevealed) {
      await gameWon(context, gameState);
    } else if (isMineRevealed) {
      await revealedMine(gameState, context);
    }
  }

  Future<void> gameWon(BuildContext context, GameCubit gameState) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Center(child: Text("You won!")),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Start again?"))
              ],
            ));

    gameState.resetBoard(gameState.state.squareStates.length);
  }

  Future<void> revealedMine(GameCubit gameState, BuildContext context) async {
    gameState.revealAll();

    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Center(child: Text("You lost!")),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Start again?"))
              ],
            ));

    gameState.resetBoard(gameState.state.squareStates.length);
  }
}
