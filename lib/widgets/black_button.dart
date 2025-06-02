import 'package:flutter/material.dart';

class BlackButton extends StatelessWidget {
  const BlackButton({
    super.key,
    required this.onPressed,
    required this.height,
    required this.text,
    this.textColor = Colors.white,
  });

  final String text;
  final void Function() onPressed;
  final double height;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: ColoredBox(
          color: const Color.fromARGB(255, 0, 0, 0),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextButton(
                onPressed: onPressed,
                child: Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: height,
                  ),
                )),
          )),
    );
  }
}
