import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameInitial(List.filled(100, SquareState.invalid(), growable: false), true));

  void resetBoard(int boardSize) {
    emit(GameInitial(List.filled(boardSize, SquareState.invalid(), growable: false), true));
  }

  void reveal(int index) {
    final n_state = state.squareStates.toList(growable: false);
    n_state[index] = state.squareStates[index]._revealSquare();
    emit(GameInitial(n_state, state.firstClick));
    // I have no clue if the "standard" practice is to use GameInitial again
    // For my program right now, it would be overkill to create another subclass
    // of GameState which would be identical to GameInitial just with another name
    // Thus I will keep using GameInitial for now
  }

  void revealBulk(List<int> indices) {
    final nState = state.squareStates.toList(growable: false);
    for (int index in indices) {
      nState[index] = state.squareStates[index]._revealSquare();
    }
    emit(GameInitial(nState, state.firstClick));
  }

  void revealAll() {
    final nState = state.squareStates.map((e) => e._revealSquare()).toList(growable: false);
    emit(GameInitial(nState, state.firstClick));
  }

  void flag(int index) {
    final nState = state.squareStates.toList(growable: false);
    nState[index] = state.squareStates[index]._flagSquare();
    emit(GameInitial(nState, state.firstClick));
  }

  void unFlag(int index) {
    final nState = state.squareStates.toList(growable: false);
    nState[index] = state.squareStates[index]._unflagSquare();
    emit(GameInitial(nState, state.firstClick));
  }

  void generateValidBoard(
      int firstClickIndex, int numMines, int boardWidth, int boardHeight) {
    int boardSize = boardWidth * boardHeight;
    final squareStates = List.filled(boardSize, SquareState.invalid());

    int index(int x, int y) => boardWidth * y + x;

    // Randomly distributing mines
    int xCoord;
    int yCoord;

    // This max iterations is to prevent infinite loops
    // when we do not have enough squares for every mine
    const maxIterations = 1000;

    for (int i = 0; i < numMines; i++) {

      int iterations = 0;
      do {
        xCoord = Random().nextInt(boardWidth);
        yCoord = Random().nextInt(boardHeight);
        iterations++;
      } while ((squareStates[index(xCoord, yCoord)].isMine() ||
          index(xCoord, yCoord) == firstClickIndex) && iterations != maxIterations);

      // This is so 1 x 1 don't have a mine in them
      if (iterations == maxIterations) {
        continue;
      }

      SquareState squareState = SquareState.mine();
      if (state.squareStates[index(xCoord, yCoord)].flag) {
        squareState = squareState._flagSquare();
      }
      squareStates[index(xCoord, yCoord)] = squareState;

    }

    // Filling in the numeric squares
    for (int i = 0; i < boardSize; i++) {
      if (squareStates[i].isMine()) continue;

      SquareState squareState = SquareState.number(
          _numMinesAroundSquare(squareStates, i, boardWidth, boardHeight));

      if (state.squareStates[i].flag) {
        squareState = squareState._flagSquare();
      }
      squareStates[i] = squareState;
    }

    emit(GameInitial(squareStates, false));
  }

  /*
  ============================
  ====== Helper Methods ======
  ============================
  */

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

  int _numMinesAroundSquare(List<SquareState> squareStates, int index,
      int boardWidth, int boardHeight) {
    int x = index % boardWidth;
    int y = index ~/ boardWidth;
    return _getAdjacentSquares(x, y, boardWidth, boardHeight)
        .where((element) => squareStates[element].isMine())
        .length;
  }
}
