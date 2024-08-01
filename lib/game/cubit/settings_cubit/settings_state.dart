part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {
  final Color nb0;
  final Color nb1;
  final Color nb2;
  final Color nb3;
  final Color nb4;
  final Color nb5;
  final Color nb6;
  final Color nb7;
  final Color nb8;
  final Color nb9;

  final Color borderColor;
  final Color backgroundColor;

  const SettingsState(
      this.nb0,
      this.nb1,
      this.nb2,
      this.nb3,
      this.nb4,
      this.nb5,
      this.nb6,
      this.nb7,
      this.nb8,
      this.nb9,
      this.borderColor,
      this.backgroundColor);

  Color getDigitColor(int digit) {
    assert(0 <= digit && digit <= 9);
    switch (digit) {
      case 0:
        return nb0;
      case 1:
        return nb1;
      case 2:
        return nb2;
      case 3:
        return nb3;
      case 4:
        return nb4;
      case 5:
        return nb5;
      case 6:
        return nb6;
      case 7:
        return nb7;
      case 8:
        return nb8;
      case 9:
        return nb9;
      default:
        throw ArgumentError("Digit should be between 0 and 9");
      // The default case should never happen because of the assert
    }
  }
}

final class SettingsInitial extends SettingsState {
  const SettingsInitial(
      super.nb0,
      super.nb1,
      super.nb2,
      super.nb3,
      super.nb4,
      super.nb5,
      super.nb6,
      super.nb7,
      super.nb8,
      super.nb9,
      super.borderColor,
      super.backgroundColor);

  // Colors are based off this reddit posts
  // https://www.reddit.com/r/Minesweeper/comments/qf1735/minesweeper_numbers_tier_list/
  static SettingsState defaultSettings() => const SettingsInitial(
      Colors.transparent,
      Color(0xFF0000fd),
      Color(0xFF017e00),
      Color(0xFFfe0000),
      Color(0xFF010082),
      Color(0xFF810101),
      Color(0xFF008080),
      Color(0xFF77008A),
      Color(0xFF808080),
      Color(0xFF2C2C2C),
      Color(0xFF808080),
      Color(0xFFc0c0c0));
}
