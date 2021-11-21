import 'package:calculators/my_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyInputPage extends StatelessWidget {
  final String? headlineText;
  final String imageUri;
  final String headerText;
  final String subheadText;
  final Widget child;
  final Widget goTo;
  final int position;
  final int totalQuestions;

  const MyInputPage({
    Key? key,
    this.headlineText,
    required this.imageUri,
    required this.headerText,
    required this.subheadText,
    required this.child,
    required this.goTo,
    required this.position,
    required this.totalQuestions,
  }) : super(key: key);

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
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        leading: (position != 1) ? IconButton(
          icon: Icon(GetPlatform.isIOS ? Icons.arrow_back : CupertinoIcons.back),
          onPressed: () => Get.back(),
        ) : Container(),
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
              (headlineText != null)
                  ? Text(
                      headlineText!,
                      style: headline,
                    )
                  : Container(),
              const SizedBox(height: 32),
              SvgPicture.asset(
                imageUri,
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              const SizedBox(height: 32),
              Text(
                headerText,
                style: header,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                subheadText,
                style: subhead,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              child,
              MyElevatedButton(width: width, goTo: goTo,),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}