import 'package:flutter/material.dart';

class PercentSuffix extends StatelessWidget {
  final TextField child;

  const PercentSuffix({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: child),
        const SizedBox(width: 8),
        const Text('%'),
      ],
    );
  }
}
