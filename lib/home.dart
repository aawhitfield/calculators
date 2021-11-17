import 'package:calculators/address_form.dart';
import 'package:calculators/my_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    double width = context.isTablet
        ? MediaQuery.of(context).size.width * 0.5
        : MediaQuery.of(context).size.width;

    TextStyle? headline = context.isTablet
        ? Theme.of(context).textTheme.headline2
        : Theme.of(context).textTheme.headline3;

    TextStyle? header = context.isTablet
        ? Theme.of(context).textTheme.headline3
        : Theme.of(context).textTheme.headline4;

    TextStyle? subhead = context.isTablet
        ? Theme.of(context).textTheme.headline4
        : Theme.of(context).textTheme.headline5;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.transparent,
          statusBarColor: Colors.green.shade500,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Text(
                'Residential REI',
                style: headline,
              ),
              const SizedBox(height: 32),
              SvgPicture.asset(
                'images/house_searching.svg',
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              const SizedBox(height: 32),
              Text(
                'Let\'s first find the property',
                style: header,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Where is the property located?',
                style: subhead,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              AddressForm(width: width),
              MyElevatedButton(width: width),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
