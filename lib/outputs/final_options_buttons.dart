import 'package:calculators/home.dart';
import 'package:calculators/models/calculator.dart';
import 'package:calculators/models/database_utils.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/my_elevated_button.dart';
import 'package:calculators/widgets/my_outlined_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class FinalOptionsButtons extends ConsumerWidget {
  const FinalOptionsButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyOutlinedButton(
          onPressed: () {
            resetAllData(ref);
            Get.offAll(() => const MyHomePage(title: '', startingTab: 0,));
          },
          label: 'Start Over',
        ),
        const Spacer(),
        MyElevatedButton(
          onPressed: () async {
            Calculator currentCalculator = ref.read(calculatorProvider).type;
            Map<String, dynamic> data = {};
            if(currentCalculator == Calculator.brrrr) {
              data = ref.read(brrrrProvider).toJson();
            }
            else if(currentCalculator == Calculator.quickMaxOffer) {
              data = ref.read(quickMaxProvider).toJson();
            }
            else if(currentCalculator == Calculator.fixAndFlip) {
              data = ref.read(fixFlipProvider).toJson();
            }

            // get the document ID to update the record, otherwise create a new document
            String docID = ref.read(savedCalculatorProvider).uid;
            await DatabaseUtils.saveDataToDatabase(uid: FirebaseAuth.instance.currentUser!.uid, data: data, docID: (docID != '' ? docID : null));
            resetAllData(ref);
            Get.offAll(() => const MyHomePage(title: '', startingTab: 1,));
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(margin: const EdgeInsets.all(16), content: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.check, color: Colors.white),
                SizedBox(width: 4),
                Text('Place saved!',),
              ],
            ), shape: const StadiumBorder(), behavior: SnackBarBehavior.floating,));
          },
          label: 'Save Info',
        ),
      ],
    );
  }
}
