import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class RGBColorPicker extends StatefulWidget {
  const RGBColorPicker({
    Key? key,
    required this.pickerColor,
    required this.onColorChanged,
  }) : super(key: key);

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;

  @override
  State<RGBColorPicker> createState() => _RGBColorPicker();
}

class _RGBColorPicker extends State<RGBColorPicker> {
  int red = 0;
  int green = 0;
  int blue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ColorPicker(
          pickerColor: widget.pickerColor,
          onColorChanged: (Color color) {
            setState(() {
              red = color.red;
              green = color.green;
              blue = color.blue;
            });
            widget.onColorChanged(color);
          },
          showLabel: false, // Make the RGBA text invisible
          enableAlpha: false, // Remove the RGB selection box
          pickerAreaBorderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(10),
          ),
          paletteType: PaletteType.hueWheel,
        ),
      ],
    );
  }
}
