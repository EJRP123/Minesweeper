import 'package:flutter/material.dart';
import 'package:minesweeper/game/game_page.dart';
import 'package:flutter/gestures.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      title: "MineSweeper",
      home: GamePage(),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {

  const MyCustomScrollBehavior();

  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };

}