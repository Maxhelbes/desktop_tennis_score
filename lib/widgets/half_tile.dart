import 'package:flutter/material.dart';

class HalfTile extends StatelessWidget {
  const HalfTile({
    super.key,
    required this.color,
    required this.child,
  });

  final MaterialColor color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: double.infinity,
      width: MediaQuery.sizeOf(context).width / 2,
      child: child,
    );
  }
}
