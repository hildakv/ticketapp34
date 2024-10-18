import 'package:flutter/material.dart';

// const bodyBackgroundColor = Color.fromRGBO(214, 214, 214, 1);
// const bodyBackgroundColor = Color(0xFFE9E9E9);
const primaryColor = Color.fromARGB(255, 112, 13, 161);
const textColor = Color(0xFF121212);
const textColorMedGrey = Color(0xFF202020);
const textColorGrey = Color(0xFF616161);

final themeData = ThemeData.light().copyWith(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: Colors.white,
  useMaterial3: true,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
  ),
);

const screenPadding = EdgeInsets.all(12);
final borderRadius = BorderRadius.circular(12);

const customOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(30)),
);

class TicketCartTheme {
  final Color panelBackground;

  final Color subFacilityBackground;

  final Color itemsBackground;

  final Color bottomBarBackground;

  final Color bottomBarButtonColor;

  TicketCartTheme(
      {this.subFacilityBackground = Colors.blue,
      this.itemsBackground = Colors.lightBlue,
      this.bottomBarBackground = Colors.blueAccent,
      this.bottomBarButtonColor = Colors.deepPurple,
      this.panelBackground = Colors.blueGrey});
}

final TicketCartTheme ticketCartTheme1 = TicketCartTheme(
    subFacilityBackground: Color.fromRGBO(177, 178, 255, 1),
    itemsBackground: Color.fromRGBO(170, 196, 255, 1),
    bottomBarBackground: Color.fromRGBO(210, 218, 255, 1),
    panelBackground: Color.fromRGBO(238, 241, 255, 1));
