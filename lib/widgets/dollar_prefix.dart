import 'package:flutter/material.dart';

class DollarPrefix extends StatelessWidget {
  final TextFormField child;

  const DollarPrefix({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('\$'),
        const SizedBox(width: 4),
        Expanded(child: child),
      ],
    );
  }
}
