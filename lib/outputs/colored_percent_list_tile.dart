import 'package:calculators/widgets/percent_list_tile.dart';
import 'package:flutter/material.dart';

class ColoredPercentListTile extends StatelessWidget {
  const ColoredPercentListTile({
    Key? key,
    required this.value,
    required this.smallScreenTitle,
    required this.largeScreenTitle,
    required this.valueString,
  }) : super(key: key);

  final double value;
  final String smallScreenTitle;
  final String largeScreenTitle;
  final String valueString;


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
        child: PercentListTile(
            (MediaQuery.of(context).size.width < 640)
                ? smallScreenTitle
                : largeScreenTitle,
            valueString),
      ),
    );
  }
}
