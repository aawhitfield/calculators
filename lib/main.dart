import 'package:calculators/initialization.dart';
import 'package:calculators/onboarding/auth_gate.dart';
import 'package:calculators/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

void main() async {
  await Initialization.initialize();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: buildThemeData(context),
        home: const AuthGate(),
      ),
    );
  }
}


