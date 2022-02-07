import 'package:calculators/home.dart';
import 'package:calculators/models/calculator.dart';
import 'package:calculators/outputs/report.dart';
import 'package:calculators/outputs/turnkey/report_turnkey_rental.dart';
import 'package:calculators/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class NavigationBarHomeReport extends ConsumerWidget {
  const NavigationBarHomeReport({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        TextButton(
            onPressed: () {
              Get.offAll(() => const MyHomePage(
                    title: 'Vereifi',
                    startingTab: 0,
                  ));
            },
            child: const Text('Home', style: TextStyle(
              fontSize: 18,
            ),)),
        const Spacer(),
        (ref.read(savedCalculatorProvider).uid != '')
        ? TextButton(
            onPressed: () => Get.to(() {
                  Calculator currentCalculator =
                      ref.read(calculatorProvider).type;
                  switch (currentCalculator) {
                    case Calculator.turnkeyRental:
                      return const TurnkeyRentalReport();
                    default:
                      return const Report();
                  }
                }),
            child: const Text('Report', style: TextStyle(
              fontSize: 18,
            )))
        : Container(),
      ],
    );
  }
}
