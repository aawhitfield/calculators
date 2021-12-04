import 'dart:math';

import 'package:calculators/inputs/location.dart';
import 'package:calculators/widgets/card_button.dart';
import 'package:calculators/widgets/responsive_row_column_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    double minSize = min(MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height);
    double imageSize = minSize * 0.35;

    List<CardButton> calculators = [
      CardButton(label: 'Residential REI',
        svgImage: 'images/residential.svg',
        imageSize: imageSize,
        onPressed: () {
        Get.to(() => Location());
        },
      ),
      CardButton(label: 'Fix & Flip',
        svgImage: 'images/fix-flip.svg',
        imageSize: imageSize,
        onPressed: () {},
      ),
    ];

    return ResponsiveRowColumnGrid(
      heading: 'Verefi',
      subheading: 'Which calculator would you like to use today?',
      children: calculators,
    );
  }
}
