import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class VereifiSignInScreen extends StatelessWidget {
  const VereifiSignInScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
        headerBuilder: (context, constraints, _) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset('images/logo.png'),
          );
        },
        sideBuilder: (context, constraints) {
          return Image.asset('images/logo.png');
        },
        providerConfigs: const [
          EmailProviderConfiguration(),
          // AppleProviderConfiguration(),
          // GoogleProviderConfiguration(
          //   clientId: 'vereifiapp',
          // ),
        ]);
  }
}
