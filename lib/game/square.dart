import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'cubit/game_cubit/game_cubit.dart';

// TODO: Add the colors in the theme
class Square extends StatelessWidget {
  final SquareState state;
  final int boardSize;

  // Colors are based off this reddit posts
  // https://www.reddit.com/r/Minesweeper/comments/qf1735/minesweeper_numbers_tier_list/
  static const List<Color> numberColors = [
    Colors.transparent, // default value (0)
    Color(0xFF0000fd),
    Color(0xFF017e00),
    Color(0xFFfe0000),
    Color(0xFF010082),
    Color(0xFF810101),
    Color(0xFF008080),
    Color(0xFF77008A),
    Color(0xFF808080),
    Color(0xFFFFFFFF) // Added for impossible number 9
  ];
  static const Color borderColor = Color(0xFF808080);
  static const Color backgroundColor = Color(0xFFc0c0c0);

  const Square({super.key, required this.state, required this.boardSize});

  @override
  Widget build(BuildContext context) {

    Widget squareVisualData = const Placeholder();
    // If chains FTW
    if (!state.revealed) {
      if (state.flag) {
        return flag();
      } else {
        return concealed();
      }
    } else {
      if (state.isMine()) {
        squareVisualData = mineRevealed();
      } else {
        squareVisualData = numberRevealed();
      }
    }

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: borderColor), color: backgroundColor),
      padding: EdgeInsets.all((boardSize >= 400) ? 4000 / boardSize : 10.0),
      child: FittedBox(fit: BoxFit.fill, child: squareVisualData),
    );
  }

  Widget concealed() {
    const assetName = "assets/minesweeper_tile.svg";
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: borderColor), color: backgroundColor),
      child: FittedBox(fit: BoxFit.fill, child: SvgPicture.asset(assetName)),
    );
  }

  Widget mineRevealed() {
    return const Text(
      "*",
      style: TextStyle(fontFamily: "minesweeper"),
    );
  }

  Widget numberRevealed() {
    Color numberColor = numberColors[state.value];
    return Text(state.value.toString(),
        style: TextStyle(color: numberColor, fontFamily: "minesweeper"));
  }

  Widget flag() {
    const assetName = "assets/minesweeper_flag.svg";
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: borderColor), color: backgroundColor),
      child: FittedBox(fit: BoxFit.fill, child: SvgPicture.asset(assetName)),
    );
  }
}
