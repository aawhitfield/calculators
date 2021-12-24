import 'package:calculators/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return SignInScreen(
            headerBuilder: (context, constraints, _) {
              return Image.asset('images/logo.png');
            },
            sideBuilder: (context, constraints) {
              return Image.asset('images/logo.png');
            },
              providerConfigs: const [
                EmailProviderConfiguration(),
                // GoogleProviderConfiguration(
                //   clientId: 'vereifiapp',
                // ),
              ]
          );
        }

        // Render your application if authenticated
        return const MyHomePage(title: 'Vereifi');
      },
    );
  }
}