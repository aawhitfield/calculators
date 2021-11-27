import 'package:flutter/material.dart';

class MoneyListTile extends StatelessWidget {
  final String label;
  final String amount;
  final String? subtitle;

  const MoneyListTile(this.label, this.amount, {
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
          const Icon(Icons.attach_money),
          const SizedBox(width: 8),
          Text(
            amount,
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
      subtitle: (subtitle != null) ? Text(subtitle!) : Container(),
    );
  }
}
