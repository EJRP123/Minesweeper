part of 'game_cubit.dart';

@immutable
sealed class GameState {
  final bool firstClick;
  final List<SquareState> squareStates;

  const GameState(this.squareStates, this.firstClick);
}

// Please note that this state could fit into 1 byte
// But like, we ain't in C (yet), so no
final class SquareState extends Equatable {
  final int value;
  final bool revealed;
  final bool flag;

  const SquareState._(this.value, this.revealed, this.flag);

  static SquareState mine() => const SquareState._(-1, false, false);

  static SquareState number(int value) {
    assert(value >= 0 && value <= 8); // Valid square values for minesweeper
    return SquareState._(value, false, false);
  }

  /// This is a method for the NumberMinesweeperDisplay widget
  static SquareState numberRevealed(int value) {
    // Added 9 for the NumberMinesweeperDisplay widget to work
    assert(value >= 0 && value <= 9);
    return SquareState._(value, true, false);
  }

  static SquareState invalid() => const SquareState._(-2, false, false);

  SquareState _revealSquare() => SquareState._(value, true, false);

  SquareState _flagSquare() => SquareState._(value, false, true);

  SquareState _unflagSquare() => SquareState._(value, false, false);

  bool isMine() => value == -1;

  bool isNumber() => value >= 0 && value <= 8;

  bool isInvalid() => value == -2;

  @override
  String toString() {
    return 'SquareState{revealed: $revealed, value: $value, flag: $flag}';
  }

  @override
  List<Object?> get props => [value, revealed, flag];
}

final class GameInitial extends GameState {
  const GameInitial(super.squareStates, super.firstClick);
}
