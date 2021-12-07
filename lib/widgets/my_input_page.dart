import 'package:calculators/home.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/my_elevated_button.dart';
import 'package:calculators/widgets/my_outlined_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyInputPage extends ConsumerWidget {
  final String? headlineText;
  final String imageUri;
  final String headerText;
  final String subheadText;
  final Widget child;
  final VoidCallback onSubmit;
  final int position;
  final int totalQuestions;
  final bool? shouldShowBackButton;

  const MyInputPage({
    Key? key,
    this.headlineText,
    required this.imageUri,
    required this.headerText,
    required this.subheadText,
    required this.child,
    required this.onSubmit,
    required this.position,
    required this.totalQuestions,
    this.shouldShowBackButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = context.isTablet
        ? MediaQuery.of(context).size.width * 0.6
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        leading: (shouldShowBackButton != null)
            ? (shouldShowBackButton!)
                ? null
                : Container()
            : (position != 1)
                ? IconButton(
                    icon: Icon(GetPlatform.isAndroid
                        ? Icons.arrow_back
                        : CupertinoIcons.back),
                    onPressed: () => Get.back(),
                  )
                : Container(),
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.transparent,
          statusBarColor: Colors.green.shade500,
          statusBarIconBrightness: Brightness.light,
        ),
        title: LinearProgressIndicator(
          value: position / totalQuestions,
        ),
        centerTitle: true,
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
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.3,
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
              (position != totalQuestions)
                  ? MyElevatedButton(
                      width: width,
                      onPressed: onSubmit,
                      label: (position == totalQuestions - 1)
                          ? 'Generate report'
                          : 'Continue',
                    )
                  : Row(
                mainAxisSize: MainAxisSize.min,
                    children: [
                      MyOutlinedButton(
                          width: width * 0.4,
                          onPressed: () {
                            resetAllData(ref);
                            Get.offAll(() => const MyHomePage(title: '', startingTab: 0,));
                          },
                          label: 'Start over',
                        ),
                      const Spacer(),
                      MyElevatedButton(
                        width: width * 0.4,
                        onPressed: () {
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
                  ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void resetAllData(WidgetRef ref) {
    ref.read(expensesProvider).reset();
    ref.read(financeConstructionProvider).reset();
    ref.read(financeProvider).reset();
    ref.read(incomeProvider).reset();
    ref.read(optionsProvider).reset();
    ref.read(propertyProvider).reset();
    ref.read(refinanceProvider).reset();
    ref.read(renovationsProvider).reset();
    ref.read(sellerFinanceProvider).reset();
  }
}
