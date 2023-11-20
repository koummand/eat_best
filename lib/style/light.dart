import 'package:flutter/material.dart';

TextStyle StyletextAppbar =
    TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30);

class StyleLight extends StatelessWidget {

  // fond des page
  Color backgroundColorDetailsMenu =const Color.fromARGB(229, 255, 255, 255);
  Color backgroundColoParamettre=Colors.white;
  Color coloButtonPage= Colors.white;
  Color colorTextPage=Colors.black;
  Color colorIconPage=Colors.black;
  Color activeColorDart =Colors.black;

  // Style de AppBar
  // Color backgroundColorAppbar = const Color.fromARGB(142, 0, 0, 0);
    Color backgroundColorAppbar = Colors.white;
    Color coloTextAppbar =Colors.black;

  //Style du menu deroulan
  // Head
  Color backgroundColorHeadMenuDeroulant = Colors.black;
  Color colorTextHeadMenuDeroulant =const Color.fromARGB(182, 255, 255, 255);
  // Body
  Color backgrounColorBodyMenuDeroulant = Colors.white;
  Color colorIconBodyMenuDeroulant = Colors.black;
  Color colorTextBodyMenuDeroulant =  Colors.black;

  StyleLight({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}
