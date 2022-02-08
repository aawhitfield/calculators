import 'package:calculators/home.dart';
import 'package:calculators/models/calculator.dart';
import 'package:calculators/outputs/report.dart';
import 'package:calculators/outputs/turnkey/report_turnkey_rental.dart';
import 'package:calculators/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class NavigationBarHomeReport extends ConsumerWidget {
  final int position;
  final int totalQuestions;
  final VoidCallback onSubmit;
  const NavigationBarHomeReport({
    Key? key,
    required this.position,
    required this.totalQuestions,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isFromSaved = ref.read(savedCalculatorProvider).uid != '';
    bool isHome(int buttonNumber) {
      return buttonNumber == 0;
    }

    bool isNext(int buttonNumber) {
      return buttonNumber == 1;
    }

    // determines if it is the report page of a calculator entry
    bool isLastPage = (position == totalQuestions);

    void goHome() {
      resetAllData(ref);
      Get.offAll(() => const MyHomePage(title: 'Vereifi', startingTab: 0));
    }

    void goToReport() {
      Get.to(() {
        Calculator currentCalculator = ref.read(calculatorProvider).type;
        switch (currentCalculator) {
          case Calculator.turnkeyRental:
            return const TurnkeyRentalReport();
          default:
            return const Report();
        }
      });
    }

    void onButtonPress(int buttonNumber) {
      if (isHome(buttonNumber)) {
        goHome();
      } else if (isNext(buttonNumber)) {
        onSubmit();
      } else if (buttonNumber == 2) {
        goToReport();
      }
    }

    List<BottomNavigationBarItem> buttonsFromSaved = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.arrow_forward), label: 'Next'),
      const BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Report'),
    ];

    List<BottomNavigationBarItem> buttonsForNew = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.arrow_forward), label: 'Next'),
    ];

    FloatingActionButton homeButton = FloatingActionButton(
      onPressed: goHome,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Spacer(),
          Icon(Icons.home),
          Text(
            'Home',
            style: TextStyle(fontSize: 12),
          ),
          Spacer(),
        ],
      ),
    );

    return isLastPage
        ? homeButton
        : BottomNavigationBar(
            onTap: onButtonPress,
            unselectedItemColor: Theme.of(context).indicatorColor,
            items:
                (isFromSaved) // only show report button if from a saved calculator
                    ? buttonsFromSaved
                    : buttonsForNew, // buttons if is a new calculator entry
          );
  }
}
