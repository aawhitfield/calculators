import 'package:calculators/widgets/money_list_tile.dart';
import 'package:flutter/material.dart';

class ColoredMoneyListTile extends StatelessWidget {
  const ColoredMoneyListTile({
    Key? key,
    required this.value,
    required this.smallScreenTitle,
    required this.largeScreenTitle,
    required this.valueString,
    this.subtitle = '',
  }) : super(key: key);

  final double value;
  final String smallScreenTitle;
  final String largeScreenTitle;
  final String valueString;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        color: (value > 0)
            ? Colors.green.withOpacity(0.5)
            : (value < 0)
                ? Colors.red.withOpacity(0.5)
                : Colors.transparent,
        child: MoneyListTile(
          (MediaQuery.of(context).size.width < 640)
              ? smallScreenTitle
              : largeScreenTitle,
          valueString,
          subtitle: subtitle,
        ),
      ),
    );
  }
}
