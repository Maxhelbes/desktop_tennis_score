import 'package:flutter/material.dart';

final theme = ThemeData(
  appBarTheme: appBarTheme,
  textTheme: textTheme,
);

final appBarTheme = AppBarTheme(
  titleTextStyle: TextStyle(color: Colors.white, fontSize: 40),
  backgroundColor: Colors.black,
  centerTitle: true,
  iconTheme: IconThemeData(color: Colors.blue),
);

final textTheme = TextTheme(
  headlineLarge:
      TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 50),
  headlineSmall:
      TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 30),
  bodyMedium:
      TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 20),
);
