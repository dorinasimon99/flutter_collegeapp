import 'package:flutter/material.dart';

AppBar header(BuildContext context, {bool isMenu = true}){
  return AppBar(
    leading: isMenu ?
      IconButton(
        onPressed: () => Navigator.pushNamed(context, 'menu'),
        icon: Image.asset('assets/hamburger.png'),
        iconSize: 120,
      )
    : IconButton(
      icon: Image.asset('assets/back.png'),
      iconSize: 120,
      onPressed: () => Navigator.pop(context),
    ),
    toolbarHeight: 80.0,
    automaticallyImplyLeading: true,
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
  );
}

IconButton homeButton(BuildContext context){
  return IconButton(
    onPressed: () => Navigator.popUntil(context, (route) => route.settings.name == "root"),
    icon: Image.asset("assets/home.png"),
    iconSize: 45,
  );
}