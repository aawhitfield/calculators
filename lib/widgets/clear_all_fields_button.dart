import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClearAllFieldsButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ClearAllFieldsButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topRight,
        child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              primary: Colors.red,
              side: const BorderSide(color: Colors.red),
            ),
            icon: const Icon(
              CupertinoIcons.delete,
              color: Colors.red,
            ),
            onPressed: onPressed,
            label: const Text(
              'Clear All Fields',
              style: TextStyle(
                color: Colors.red,
              ),
            )));
  }
}
