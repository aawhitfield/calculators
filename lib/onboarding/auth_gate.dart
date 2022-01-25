import 'package:calculators/home.dart';
import 'package:calculators/onboarding/vereifi_sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return const VereifiSignInScreen();
        }

        // Render your application if authenticated
        return const MyHomePage(title: 'Vereifi');
      },
    );
  }
}
