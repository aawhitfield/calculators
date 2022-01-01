import 'package:flutter/material.dart';

class PercentListTile extends StatelessWidget {
  final String label;
  final String amount;
  final String? subtitle;

  const PercentListTile(this.label, this.amount, {
    Key? key, this.subtitle,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        label,
        style: Theme.of(context).textTheme.headline6,
      ),
      title: Row(
        children: [
          Text(
            amount,
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(width: 8),
          const Text('%'),
        ],
      ),
      subtitle: (subtitle != null) ? Text(subtitle!) : Container(),
    );
  }
}
