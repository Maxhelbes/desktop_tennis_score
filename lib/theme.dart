import 'package:flutter/material.dart';

final theme = ThemeData(
  appBarTheme: appBarTheme,
  textTheme: textTheme,
);

final appBarTheme = AppBarTheme(
  titleTextStyle: TextStyle(color: Colors.white, fontSize: 40),
  backgroundColor: Colors.black,
  centerTitle: true,
);

final textTheme = TextTheme(
  headlineLarge:
      TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 50),
);
