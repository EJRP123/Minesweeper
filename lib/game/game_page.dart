import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/board_cubit/board_cubit.dart';
import 'cubit/game_cubit/game_cubit.dart';
import 'cubit/settings_cubit/settings_cubit.dart';
import 'game_view.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BoardCubit>(create: (_) => BoardCubit()),
        BlocProvider<GameCubit>(create: (_) => GameCubit()),
        BlocProvider<SettingsCubit>(create: (_) => SettingsCubit()),
      ],
      child: const GameView(),
    );
  }
}
