import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// Add the same color picker just with no display color circle and a title

class WheelColorPicker extends StatefulWidget {
  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final Widget title;

  final double colorPickerWidth = 300.0;
  final double pickerAreaHeightPercent = 2 / 3;

  const WheelColorPicker(
      {super.key,
      required this.pickerColor,
      required this.onColorChanged,
      required this.title});

  @override
  State<WheelColorPicker> createState() => _WheelColorPickerState();
}

class _WheelColorPickerState extends State<WheelColorPicker> {
  HSVColor currentHsvColor = const HSVColor.fromAHSV(0.0, 0.0, 0.0, 0.0);

  @override
  void initState() {
    currentHsvColor = HSVColor.fromColor(widget.pickerColor);

    super.initState();
  }

  void onColorChanging(HSVColor color) {
    // Update text in `hexInputController` if provided.
    // widget.hexInputController?.text = colorToHex(color.toColor(), enableAlpha: widget.enableAlpha);
    setState(() => currentHsvColor = color);
    widget.onColorChanged(currentHsvColor.toColor());
  }

  Widget colorPicker() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ColorPickerArea(
          currentHsvColor, onColorChanging, PaletteType.hueWheel),
    );
  }

  Widget colorPickerSlider(TrackType trackType) {
    return ColorPickerSlider(
      trackType,
      currentHsvColor,
      (HSVColor color) {
        // Update text in `hexInputController` if provided.
        // widget.hexInputController?.text = colorToHex(color.toColor(), enableAlpha: widget.enableAlpha);
        setState(() => currentHsvColor = color);
        widget.onColorChanged(currentHsvColor.toColor());
      },
      displayThumbColor: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        widget.title,
        SizedBox(
            width: widget.colorPickerWidth,
            height: widget.colorPickerWidth * widget.pickerAreaHeightPercent,
            child: colorPicker()),
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 5.0, 10.0, 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                        height: 40.0,
                        width: widget.colorPickerWidth - 75.0,
                        child: colorPickerSlider(TrackType.value)),
                    SizedBox(
                      height: 40.0,
                      width: widget.colorPickerWidth - 75.0,
                      child: colorPickerSlider(TrackType.alpha),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // No Hex input for now

        // ColorPickerInput(
        //   currentHsvColor.toColor(),
        //       (Color color) {
        //     setState(() => currentHsvColor = HSVColor.fromColor(color));
        //     widget.onColorChanged(currentHsvColor.toColor());
        //   },
        //   enableAlpha: true,
        //   embeddedText: false,
        // ),
      ],
    );
  }
}
