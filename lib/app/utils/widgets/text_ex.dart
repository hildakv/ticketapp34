import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextEx extends StatelessWidget {
  final String value;
  final double fontSize;

  TextEx(this.value, {this.fontSize = 18});

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: GoogleFonts.abel(fontSize: fontSize, fontWeight: FontWeight.bold),
    );
  }
}
