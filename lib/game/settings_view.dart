import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper/game/cubit/settings_cubit/settings_cubit.dart';
import 'package:minesweeper/game/number_minesweeper_display.dart';

import 'custom_color_picker.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final settingState = context.read<SettingsCubit>();

    return Material(
        color: Colors.transparent,
        child: SingleChildScrollView(
          child: Column(children: [
            BlocProvider.value(
              value: settingState,
              child: const NumberColorPicker(),
            ),

            WheelColorPicker(
              pickerColor: settingState.state.backgroundColor,
              onColorChanged: settingState.changeBackgroundColor,
              title: Text("Background",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white)),
            ),
              WheelColorPicker(
                pickerColor: settingState.state.borderColor,
                onColorChanged: settingState.changeBorderColor,
                title: Text("Border",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white)),
              ),
          ]),
        ));
  }
}

class NumberColorPicker extends StatefulWidget {
  const NumberColorPicker({super.key});

  @override
  State<NumberColorPicker> createState() => _NumberColorPickerState();
}

class _NumberColorPickerState extends State<NumberColorPicker> {
  int numberToPickColor = 1;

  ValueChanged<Color> changedColorFunction(
      int number, SettingsCubit settingCubit) {
    return [
      settingCubit.changeColor0,
      settingCubit.changeColor1,
      settingCubit.changeColor2,
      settingCubit.changeColor3,
      settingCubit.changeColor4,
      settingCubit.changeColor5,
      settingCubit.changeColor6,
      settingCubit.changeColor7,
      settingCubit.changeColor8,
      settingCubit.changeColor9,
    ][number];
  }

  Widget leftArrow() {
    return IconButton(
        onPressed: () {
          setState(() {
            numberToPickColor = max(numberToPickColor - 1, 0);
          });
        },
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white));
  }

  Widget rightArrow() {
    return IconButton(
        onPressed: () {
          setState(() {
            numberToPickColor = min(numberToPickColor + 1, 9);
          });
        },
        icon: const Icon(Icons.arrow_forward_ios, color: Colors.white,));
  }

  @override
  Widget build(BuildContext context) {
    final settingCubit = context.read<SettingsCubit>();

    return SizedBox(
      width: 200.0,
      child: WheelColorPicker(
        pickerColor: settingCubit.state.getDigitColor(numberToPickColor),
        onColorChanged: changedColorFunction(numberToPickColor, settingCubit),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leftArrow(),
            NumberMinesweeperDisplay(numberToDisplay: numberToPickColor),
            rightArrow()
          ],
        ),
      ),
    );
  }
}

