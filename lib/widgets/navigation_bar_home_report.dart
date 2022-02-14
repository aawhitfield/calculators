import 'package:calculators/home.dart';
import 'package:calculators/models/calculator.dart';
import 'package:calculators/models/database_utils.dart';
import 'package:calculators/outputs/report.dart';
import 'package:calculators/outputs/turnkey/report_turnkey_rental.dart';
import 'package:calculators/providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class NavigationBarHomeReport extends ConsumerWidget {
  final int position;
  final int totalQuestions;
  final VoidCallback goBack;
  final VoidCallback onSubmit;
  const NavigationBarHomeReport({
    Key? key,
    required this.position,
    required this.totalQuestions,
    required this.goBack,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isFromSaved = ref.read(savedCalculatorProvider).uid != '';
    bool isHome(int buttonNumber) {
      return buttonNumber == 0;
    }

    bool isBack(int buttonNumber) {
      return buttonNumber == 1;
    }

    bool isNext(int buttonNumber) {
      return buttonNumber == 2;
    }

    bool isSave(int buttonNumber) {
      return buttonNumber == 2;
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
      } else if(isBack(buttonNumber)) {
        goBack();
      }
      else if (isNext(buttonNumber)) {
        onSubmit();
      } else if (buttonNumber == 3) {
        goToReport();
      }
    }

    void onReportButtonPress(int buttonNumber) async {
      if (isHome(buttonNumber)) {
        goHome();
      } else if(isBack(buttonNumber))
        {
          goBack();
        }else if (isSave(buttonNumber)) {
        Calculator currentCalculator = ref.read(calculatorProvider).type;
        Map<String, dynamic> data = {};
        if (currentCalculator == Calculator.brrrr) {
          data = ref.read(brrrrProvider).toJson();
        } else if (currentCalculator == Calculator.quickMaxOffer) {
          data = ref.read(quickMaxProvider).toJson();
        } else if (currentCalculator == Calculator.fixAndFlip) {
          data = ref.read(fixFlipProvider).toJson();
        } else if (currentCalculator == Calculator.turnkeyRental) {
          data = ref.read(turnkeyProvider).toJson();
        }

        // get the document ID to update the record, otherwise create a new document
        String docID = ref.read(savedCalculatorProvider).uid;
        await DatabaseUtils.saveDataToDatabase(
            uid: FirebaseAuth.instance.currentUser!.uid,
            data: data,
            docID: (docID != '' ? docID : null));
        resetAllData(ref);
        Get.offAll(() => const MyHomePage(
              title: '',
              startingTab: 1,
            ));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          margin: const EdgeInsets.all(16),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.check, color: Colors.white),
              SizedBox(width: 4),
              Text(
                'Place saved!',
              ),
            ],
          ),
          shape: const StadiumBorder(),
          behavior: SnackBarBehavior.floating,
        ));
      }
    }

    List<BottomNavigationBarItem> buttonsForReport = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      const BottomNavigationBarItem(icon: Icon(Icons.arrow_back), label: 'Back'),
      const BottomNavigationBarItem(icon: Icon(Icons.save), label: 'Save'),
    ];

    List<BottomNavigationBarItem> buttonsFromSaved = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      const BottomNavigationBarItem(icon: Icon(Icons.arrow_back), label: 'Back'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.arrow_forward), label: 'Next'),
      const BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Report'),
    ];

    List<BottomNavigationBarItem> buttonsForNew = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      const BottomNavigationBarItem(icon: Icon(Icons.arrow_back), label: 'Back'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.arrow_forward), label: 'Next'),
    ];

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (isLastPage) ? onReportButtonPress : onButtonPress,
      unselectedItemColor: Theme.of(context).indicatorColor,
      items: (isLastPage)
          ? buttonsForReport // show a save button on the report page
          : (isFromSaved) // only show report button if from a saved calculator
              ? buttonsFromSaved
              : buttonsForNew, // buttons if is a new calculator entry
    );
  }
}
