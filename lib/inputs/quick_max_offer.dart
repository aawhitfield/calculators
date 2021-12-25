import 'package:calculators/globals.dart';
import 'package:calculators/models/calculator.dart';
import 'package:calculators/models/financing_type.dart';
import 'package:calculators/widgets/financing_type_drop_down.dart';
import 'package:calculators/widgets/integer_text_field.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:calculators/widgets/percent_text_field.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:calculators/widgets/sign_out_button.dart';
import 'package:finance/finance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
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
  double rehabCosts = 0;
  double equity = 0;
  double maxOffer = 0;
  double downPaymentPercentage = 0;
  double interestRate = 0;
  int termInYears = 0;
  double closingCosts = 0;
  double taxesPerYear = 0;
  double taxesPerMonth = 0;
  double insurancePerYear = 0;
  double insurancePerMonth = 0;
  double utilitiesPerMonth = 0;

  int monthsOfHolding = 0;



  String equityString = '';
  String maxOfferString = '';
  String taxesPerMonthString = '';
  String insurancePerMonthString = '';


  FinancingType financingType = FinancingType.commercial;


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

    double loanAmount = (1 - downPaymentPercentage) * arv;
    double downPayment = arv - loanAmount;
    double principleInterestMonthly = Finance.pmt(rate: interestRate / 12, nper: termInYears * 12, pv: -1*loanAmount).toDouble();
    double totalHoldingCosts = (taxesPerMonth + insurancePerMonth + utilitiesPerMonth + principleInterestMonthly) * monthsOfHolding;
    double maxOffer = arv - totalHoldingCosts - rehabCosts - downPayment;

    String loanAmountString = kCurrencyFormat.format(loanAmount);
    String downPaymentString = kCurrencyFormat.format(downPayment);
    String principleInterestMonthlyString = kCurrencyFormat.format(principleInterestMonthly);
    String totalHoldingCostsString = kCurrencyFormat.format(totalHoldingCosts);
    maxOfferString = kCurrencyFormat.format(maxOffer);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        actions: const [SignOutButton()],
        leading: IconButton(
          icon: Icon(
              GetPlatform.isAndroid ? Icons.arrow_back : CupertinoIcons.back),
          onPressed: () => Get.back(),
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.transparent,
          statusBarColor: Theme.of(context).primaryColor,
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PlacesAutocompleteField(
                      hint: 'Address',
                      onChanged: (String? newAddress) {
                        // if (newAddress != null) {
                        //   ref.read(propertyProvider).updateAddress(newAddress);
                        // }
                      },
                      apiKey: kGoogleAPIkey,
                      mode: Mode.overlay,
                    ),
                  ),
                  MoneyTextField(
                      labelText: 'ARV',
                      controller: arvController,
                      onChanged: (String newValue) {
                        newValue = newValue.replaceAll(',', '');
                        double? arvTemp = double.tryParse(newValue);
                        if (arvTemp != null) {
                          setState(() {
                            arv = arvTemp;
                          });
                        }
                        else {
                          setState(() {
                            arv = 0;
                          });
                        }
                      }),
                  MoneyListTile('Total Holding Costs', totalHoldingCostsString),
                  Row(
                    children: [
                      const Text('Financing Type', style: TextStyle(fontWeight: FontWeight.w700),),
                      const SizedBox(width: 8),
                      Expanded(child: FinancingTypeDropDown(initialValue: financingType,
                        onChanged: (FinancingType? newType) {
                          if (newType != null) {
                            setState(() {
                              financingType = newType;
                            });
                          }
                        },
                      )),
                    ],
                  ),
                  PercentTextField(labelText: 'Down Payment Percentage',
                    onChanged: (String newPercentage) {
                      newPercentage = newPercentage.replaceAll(',', '');
                      double? newValue = double.tryParse(newPercentage);
                      if (newValue != null) {
                        setState(() {
                          downPaymentPercentage = newValue / 100;
                        });
                      }
                      else {
                        setState(() {
                          downPaymentPercentage = 0;
                        });
                      }
                    },
                      ),
                  MoneyListTile('Loan Amount', loanAmountString),
                  MoneyListTile('Down Payment', downPaymentString),
                  PercentTextField(labelText: 'Interest Rate',
                    onChanged: (String newPercentage) {
                      newPercentage = newPercentage.replaceAll(',', '');
                      double? newValue = double.tryParse(newPercentage);
                      if (newValue != null) {
                        setState(() {
                          interestRate = newValue / 100;
                        });
                      }
                      else {
                        setState(() {
                          interestRate = 0;
                        });
                      }
                    },
                  ),
                  IntegerTextField(labelText: 'Term in Years',
                    onChanged: (String newTerm) {
                      newTerm = newTerm.replaceAll(',', '');
                      int? newValue = int.tryParse(newTerm);
                      if (newValue != null) {
                        setState(() {
                          termInYears = newValue;
                        });
                      }
                      else {
                        setState(() {
                          termInYears = 0;
                        });
                      }
                    },
                    leftPadding: 0,),
                  MoneyTextField(labelText: 'Closing Costs',
                    onChanged: (String newValue) {
                      newValue = newValue.replaceAll(',', '');
                      double? costs = double.tryParse(newValue);
                      if (costs != null) {
                        setState(() {
                          closingCosts = costs;
                        });
                      }
                      else {
                        setState(() {
                          closingCosts = 0;
                        });
                      }
                    },
                  ),
                  MoneyTextField(labelText: 'Taxes Per Year',
                    onChanged: (String newValue) {
                      newValue = newValue.replaceAll(',', '');
                      double? taxes = double.tryParse(newValue);
                      if (taxes != null) {
                        setState(() {
                          taxesPerYear = taxes;
                          taxesPerMonth = taxesPerYear / 12;
                          taxesPerMonthString = kCurrencyFormat.format(taxesPerMonth);
                        });
                      }
                      else {
                        setState(() {
                          taxesPerYear = 0;
                          taxesPerMonth = taxesPerYear / 12;
                          taxesPerMonthString = kCurrencyFormat.format(taxesPerMonth);
                        });
                      }
                    },
                  ),
                  MoneyListTile('Taxes Per Month', taxesPerMonthString),
                  MoneyTextField(labelText: 'Insurance Per Year',
                    onChanged: (String newValue) {
                      newValue = newValue.replaceAll(',', '');
                      double? insurance = double.tryParse(newValue);
                      if (insurance != null) {
                        setState(() {
                          insurancePerYear = insurance;
                          insurancePerMonth = insurancePerYear / 12;
                          insurancePerMonthString = kCurrencyFormat.format(insurancePerMonth);
                        });
                      }
                      else {
                        setState(() {
                          insurancePerYear = 0;
                          insurancePerMonth = insurancePerYear / 12;
                          insurancePerMonthString = kCurrencyFormat.format(insurancePerMonth);
                        });
                      }
                    },
                  ),
                  MoneyListTile('Insurance Per Month', insurancePerMonthString),
                  MoneyTextField(labelText: 'Utilities Per Month',
                    onChanged: (String newValue) {
                      newValue = newValue.replaceAll(',', '');
                      double? costs = double.tryParse(newValue);
                      if (costs != null) {
                        setState(() {
                          utilitiesPerMonth = costs;
                        });
                      }
                      else {
                        setState(() {
                          utilitiesPerMonth = 0;
                        });
                      }
                    },
                  ),
                  MoneyListTile('Principle \n& Interest',
                      principleInterestMonthlyString, subtitle: 'Monthly',),
                  IntegerTextField(labelText: 'Months of Holding',
                    onChanged: (String newTerm) {
                      newTerm = newTerm.replaceAll(',', '');
                      int? newValue = int.tryParse(newTerm);
                      if (newValue != null) {
                        setState(() {
                          monthsOfHolding = newValue;
                        });
                      }
                      else {
                        setState(() {
                          monthsOfHolding = 0;
                        });
                      }
                    },
                  ),
                  MoneyListTile('Total Holding Costs', totalHoldingCostsString),
                  MoneyTextField(
                    labelText: 'Rehab Costs',
                    controller: rehabController,
                      onChanged: (String newValue) {
                        newValue = newValue.replaceAll(',', '');
                        double? rehabTemp = double.tryParse(newValue);
                        if (rehabTemp != null) {
                          setState(() {
                            rehabCosts = rehabTemp;
                          });
                        }
                        else {
                          setState(() {
                            rehabCosts = 0;
                          });
                        }
                      }
                  ),

                  MoneyListTile('Equity / Down \nPayment', downPaymentString),
                  MoneyListTile((MediaQuery.of(context).size.width < 640)
                      ? 'Max\nOffer' : 'Max Offer', maxOfferString),
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
