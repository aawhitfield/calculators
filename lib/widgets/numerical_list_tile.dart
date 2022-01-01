import 'package:flutter/material.dart';

class NumericalListTile extends StatelessWidget {
  final String label;
  final String amount;
  final String? subtitle;

  const NumericalListTile(this.label, this.amount, {
    Key? key, this.subtitle,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        label,
        style: Theme.of(context).textTheme.headline6,
      ),
      title: Text(
        amount,
        style: Theme.of(context).textTheme.headline5,
      ),
      subtitle: (subtitle != null) ? Text(subtitle!) : Container(),
    );
  }
}
