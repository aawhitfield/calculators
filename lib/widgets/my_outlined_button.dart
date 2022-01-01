import 'package:flutter/material.dart';

class MyOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const MyOutlinedButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: OutlinedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
          side: MaterialStateProperty.all(BorderSide(color: Theme.of(context).primaryColor))
        ),
        onPressed: onPressed,
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
