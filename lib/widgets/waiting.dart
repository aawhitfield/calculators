import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Waiting extends StatelessWidget {
  const Waiting({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SpinKitWave(color: Theme.of(context).primaryColor,),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}
