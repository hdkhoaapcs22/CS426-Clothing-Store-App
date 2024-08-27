import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double height;
  final double indent;
  final double endIndent;
  final double thickness;

  const CustomDivider({
    Key? key,
    this.height = 16.0,
    this.indent = 16.0,
    this.endIndent = 16.0,
    this.thickness = 0.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      indent: indent,
      endIndent: endIndent,
      thickness: thickness,
    );
  }
}
