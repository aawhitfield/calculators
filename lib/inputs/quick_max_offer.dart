import 'package:calculators/globals.dart';
import 'package:calculators/models/calculator.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:calculators/widgets/percent_text_field.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class QuickMaxOffer extends StatefulWidget {
  const QuickMaxOffer({
    Key? key,
  }) : super(key: key);

  @override
  State<QuickMaxOffer> createState() => _QuickMaxOfferState();
}

class _QuickMaxOfferState extends State<QuickMaxOffer> {
  TextEditingController arvController = TextEditingController();
  TextEditingController holdingCostsController = TextEditingController();
  TextEditingController rehabController = TextEditingController();
  TextEditingController equityController = TextEditingController();

  double arv = 0;
  double holdingCosts = 0;
  double rehabCosts = 0;
  double equityPercentage = 0;
  double equity = 0;
  double maxOffer = 0;
  String equityString = '';
  String maxOfferString = '';

  void update() {
    equity = arv * equityPercentage;
    equityString = kCurrencyFormat.format(equity);

    maxOffer = arv - holdingCosts - rehabCosts - equity;
    maxOfferString = kCurrencyFormat.format(maxOffer);
  }

  @override
  void initState() {
    equityString = kCurrencyFormat.format(equity);
    maxOfferString = kCurrencyFormat.format(maxOffer);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? headline = context.isTablet
        ? Theme.of(context).textTheme.headline2
        : Theme.of(context).textTheme.headline3;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
          icon: Icon(
              GetPlatform.isAndroid ? Icons.arrow_back : CupertinoIcons.back),
          onPressed: () => Get.back(),
        ),
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
                CalculatorUtils.getName(Calculator.quickMaxOffer),
                style: headline,
              ),
              const SizedBox(height: 32),
              SvgPicture.asset(
                'images/offer.svg',
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              const SizedBox(height: 32),
              ResponsiveLayout(
                children: [
                  MoneyTextField(
                      labelText: 'ARV',
                      controller: arvController,
                      onChanged: (String newValue) {
                        newValue = newValue.replaceAll(',', '');
                        double? arvTemp = double.tryParse(newValue);
                        if (arvTemp != null) {
                          setState(() {
                            arv = arvTemp;
                            update();
                          });
                        }
                        else {
                          setState(() {
                            arv = 0;
                            update();
                          });
                        }
                      }),
                  MoneyTextField(
                    labelText: 'Holding Costs',
                    controller: holdingCostsController,
                    onChanged: (String newValue) {
                      newValue = newValue.replaceAll(',', '');
                      double? holdingTemp = double.tryParse(newValue);
                      if (holdingTemp != null) {
                        setState(() {
                          holdingCosts = holdingTemp;
                          update();
                        });
                      }
                      else {
                        setState(() {
                          holdingCosts = 0;
                          update();
                        });
                      }
                    }
                  ),
                  MoneyTextField(
                    labelText: 'Rehab Costs',
                    controller: rehabController,
                      onChanged: (String newValue) {
                        newValue = newValue.replaceAll(',', '');
                        double? rehabTemp = double.tryParse(newValue);
                        if (rehabTemp != null) {
                          setState(() {
                            rehabCosts = rehabTemp;
                            update();
                          });
                        }
                        else {
                          setState(() {
                            rehabCosts = 0;
                            update();
                          });
                        }
                      }
                  ),
                  PercentTextField(
                    labelText: 'Equity',
                    controller: equityController,
                      onChanged: (String newValue) {
                        newValue = newValue.replaceAll(',', '');
                        double? equityPercentageTemp = double.tryParse(newValue);
                        if (equityPercentageTemp != null) {
                          setState(() {
                            equityPercentage = equityPercentageTemp / 100;
                            update();
                          });
                        }
                        else {
                          setState(() {
                            equityPercentage = 0;
                            update();
                          });
                        }
                      }
                  ),
                  MoneyListTile('Equity', equityString),
                  MoneyListTile('Max Offer', maxOfferString),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
