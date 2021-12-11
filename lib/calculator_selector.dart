import 'dart:math';
import 'package:calculators/inputs/location.dart';
import 'package:calculators/models/calculator.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/card_button.dart';
import 'package:calculators/widgets/responsive_row_column_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class CalculatorSelector extends ConsumerWidget {
  const CalculatorSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double minSize = min(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    double imageSize = minSize * 0.3;

    List<CardButton> calculators = [
      CardButton(
        label: 'Residential REI',
        svgImage: 'images/residential.svg',
        imageSize: imageSize,
        onPressed: () {
          ref.read(propertyProvider).updateCalculator(Calculator.residentialREI);
          Get.to(() => Location());
        },
      ),
      CardButton(
        label: 'Fix & Flip',
        svgImage: 'images/fix-flip.svg',
        imageSize: imageSize,
        onPressed: () {
          ref.read(propertyProvider).updateCalculator(Calculator.fixAndFlip);
          Get.to(() => Location());
        },
      ),
    ];

    return ResponsiveRowColumnGrid(
      heading: 'Verefi',
      subheading: 'Which calculator would you like to use today?',
      children: calculators,
    );
  }
}
