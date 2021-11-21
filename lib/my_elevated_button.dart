import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyElevatedButton extends StatelessWidget {
  final Widget goTo;

  const MyElevatedButton({
    Key? key,
    required this.width, required this.goTo,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: width,
        child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)))),
          onPressed: () => Get.to(() => goTo),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Continue',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
