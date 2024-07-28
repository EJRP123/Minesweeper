part of 'board_cubit.dart';

@immutable
sealed class BoardState {
  final double density;
  final int width;
  final int height;

  const BoardState(this.density, this.width, this.height);

  int numMines() => (width * height * density).ceil();

  @override
  String toString() =>
      "BoardOption(density: $density, width: $width, height: $height)";
}

final class BoardInitial extends BoardState {
  const BoardInitial(super.density, super.width, super.height);

  static BoardState initial() => const BoardInitial(0.20, 10, 10);
}
