import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const MyElevatedButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)))),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            label,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
