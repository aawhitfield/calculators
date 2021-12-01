import 'package:flutter/material.dart';

class ReportHeader extends StatelessWidget {
  final String label;

  const ReportHeader(this.label, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                ))),
      ),
    );
  }
}
