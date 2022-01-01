import 'package:calculators/home.dart';
import 'package:calculators/models/db/database_utils.dart';
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
            Map<String, dynamic> data = ref.read(brrrrProvider).toJson();
            await DatabaseUtils.saveDataToDatabase(uid: FirebaseAuth.instance.currentUser!.uid, data: data);
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
