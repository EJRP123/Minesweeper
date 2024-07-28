import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper/game/cubit/board_cubit/board_cubit.dart';

class BoardOptions extends StatefulWidget {
  final BoardState initialValue;

  const BoardOptions({super.key, required this.initialValue});

  @override
  State<BoardOptions> createState() => _BoardOptionsState();
}

class _BoardOptionsState extends State<BoardOptions> {
  late double _density;
  late int _width;
  late int _height;

  @override
  void initState() {
    super.initState();
    _density = widget.initialValue.density;
    _width = widget.initialValue.width;
    _height = widget.initialValue.height;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('Choose board options')),
      content: FittedBox(
        fit: BoxFit.contain,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const Text(
                  "Width: ",
                  style: TextStyle(color: Colors.black),
                ),
                Slider(
                  value: _width.toDouble(),
                  min: 1.0,
                  max: 50.0,
                  divisions: 50,
                  label: _width.toString(),
                  onChanged: (double value) => setState(() {
                    _width = value.round();
                  }),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  "Height: ",
                  style: TextStyle(color: Colors.black),
                ),
                Slider(
                  value: _height.toDouble(),
                  min: 1.0,
                  max: 50.0,
                  divisions: 50,
                  label: _height.toString(),
                  onChanged: (double value) => setState(() {
                    _height = value.round();
                  }),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  "Density: ",
                  style: TextStyle(color: Colors.black),
                ),
                Slider(
                  value: _density,
                  min: 0.0,
                  max: 1.0,
                  divisions: 100,
                  label: ((_density * 100).roundToDouble() / 100).toString(),
                  onChanged: (double value) => setState(() {
                    _density = value;
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Generate Board'),
          onPressed: () {

            context.read<BoardCubit>().setBoard(_density, _width, _height);
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
