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
      {required this.nb0,
      required this.nb1,
      required this.nb2,
      required this.nb3,
      required this.nb4,
      required this.nb5,
      required this.nb6,
      required this.nb7,
      required this.nb8,
      required this.nb9,
      required this.borderColor,
      required this.backgroundColor});

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

  Map<String, dynamic> toMap() {
    return {
      'nb0': nb0.value,
      'nb1': nb1.value,
      'nb2': nb2.value,
      'nb3': nb3.value,
      'nb4': nb4.value,
      'nb5': nb5.value,
      'nb6': nb6.value,
      'nb7': nb7.value,
      'nb8': nb8.value,
      'nb9': nb9.value,
      'borderColor': borderColor.value,
      'backgroundColor': backgroundColor.value,
    };
  }

  Future<void> toLocalStorage() async {
    try {
      final directory = await _localPath;

      final file = File("$directory/settings.json");

      final jsonMap = json.encode(toMap());

      file.writeAsString(jsonMap);
    } catch (e) {
      if (kDebugMode) {
        print("ERROR while saving settings to local storage: \n\t$e");
      }
    }
  }

  @override
  String toString() {
    return 'SettingsState{nb0: $nb0, nb1: $nb1, nb2: $nb2, nb3: $nb3, nb4: $nb4, nb5: $nb5, nb6: $nb6, nb7: $nb7, nb8: $nb8, nb9: $nb9, borderColor: $borderColor, backgroundColor: $backgroundColor}';
  }
}

final class SettingsInitial extends SettingsState {
  const SettingsInitial(
      {required super.nb0,
      required super.nb1,
      required super.nb2,
      required super.nb3,
      required super.nb4,
      required super.nb5,
      required super.nb6,
      required super.nb7,
      required super.nb8,
      required super.nb9,
      required super.borderColor,
      required super.backgroundColor});

  factory SettingsInitial.fromMap(Map<String, dynamic> map) {
    return SettingsInitial(
      nb0: Color(map['nb0']),
      nb1: Color(map['nb1']),
      nb2: Color(map['nb2']),
      nb3: Color(map['nb3']),
      nb4: Color(map['nb4']),
      nb5: Color(map['nb5']),
      nb6: Color(map['nb6']),
      nb7: Color(map['nb7']),
      nb8: Color(map['nb8']),
      nb9: Color(map['nb9']),
      borderColor: Color(map['borderColor']),
      backgroundColor: Color(map['backgroundColor']),
    );
  }

  // Colors are based off this reddit posts
  // https://www.reddit.com/r/Minesweeper/comments/qf1735/minesweeper_numbers_tier_list/
  static SettingsState defaultSettings() => const SettingsInitial(
      // 0 is not hardcoded to transparent since this case is handled
      // in the Square widget directly
      nb0: Color(0xFF4D4D4D),
      nb1: Color(0xFF0000fd),
      nb2: Color(0xFF017e00),
      nb3: Color(0xFFfe0000),
      nb4: Color(0xFF010082),
      nb5: Color(0xFF810101),
      nb6: Color(0xFF008080),
      nb7: Color(0xFF77008A),
      nb8: Color(0xFF808080),
      nb9: Color(0xFF2C2C2C),
      borderColor: Color(0xFF808080),
      backgroundColor: Color(0xFFc0c0c0));

  static Future<SettingsState> fromLocalStorage() async {
    try {
      final directory = await _localPath;

      final file = File("$directory/settings.json");
      final contents = await file.readAsString();

      final map = json.decode(contents);

      return SettingsInitial.fromMap(map);
    } catch (e) {
      return SettingsInitial.defaultSettings();
    }
  }
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}
