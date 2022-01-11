// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:calculators/globals.dart';
import 'package:calculators/models/calculator.dart';
import 'package:calculators/models/financing_type.dart';
import 'package:calculators/outputs/final_options_buttons.dart';
import 'package:calculators/providers.dart';
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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TurnkeyRental extends ConsumerStatefulWidget {
  const TurnkeyRental({
    Key? key,
  }) : super(key: key);

  @override
  _QuickMaxOfferState createState() => _QuickMaxOfferState();
}

class _QuickMaxOfferState extends ConsumerState<TurnkeyRental> {
  TextEditingController addressController = TextEditingController();
  TextEditingController arvController = TextEditingController();
  TextEditingController downPaymentPercentageController = TextEditingController();
  TextEditingController interestRateController = TextEditingController();
  TextEditingController termInYearsController = TextEditingController();
  TextEditingController closingCostsController = TextEditingController();
  TextEditingController taxesPerYearController = TextEditingController();
  TextEditingController insurancePerYearController = TextEditingController();
  TextEditingController utilitiesPerMonthController = TextEditingController();
  TextEditingController monthsOfHoldingController = TextEditingController();
  TextEditingController rehabCostsController = TextEditingController();
  TextEditingController holdingCostsController = TextEditingController();
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
    addressController.text = ref.read(quickMaxProvider).address;
    arv = ref.read(quickMaxProvider).arv;
    if (arv != 0) {
      arvController.text = kCurrencyFormat.format(arv);
    }
    financingType = ref.read(quickMaxProvider).financingType;
    downPaymentPercentage = ref.read(quickMaxProvider).downPaymentPercentage;
    if(downPaymentPercentage != 0) {
      downPaymentPercentageController.text = (downPaymentPercentage * 100).toString();
    }
    interestRate = ref.read(quickMaxProvider).interestRate;
    if(interestRate != 0) {
      interestRateController.text = (interestRate * 100).toString();
    }
    termInYears = ref.read(quickMaxProvider).termInYears;
    if(termInYears != 0) {
      termInYearsController.text = kWholeNumber.format(termInYears);
    }
    closingCosts = ref.read(quickMaxProvider).closingCosts;
    if (closingCosts != 0) {
      closingCostsController.text = kCurrencyFormat.format(closingCosts);
    }
    taxesPerYear = ref.read(quickMaxProvider).taxesPerYear;
    if (taxesPerYear != 0) {
      taxesPerYearController.text = kCurrencyFormat.format(taxesPerYear);
    }
    taxesPerMonth = ref.read(quickMaxProvider).taxesPerMonth;
    if (taxesPerMonth != 0) {
      taxesPerMonthString = kCurrencyFormat.format(taxesPerMonth);
    }
    insurancePerYear = ref.read(quickMaxProvider).insurancePerYear;
    if (insurancePerYear != 0) {
      insurancePerYearController.text = kCurrencyFormat.format(insurancePerYear);
    }
    insurancePerMonth = ref.read(quickMaxProvider).insurancePerMonth;
    if (insurancePerMonth != 0) {
      insurancePerMonthString = kCurrencyFormat.format(insurancePerMonth);
    }
    utilitiesPerMonth = ref.read(quickMaxProvider).utilitiesPerMonth;
    if (utilitiesPerMonth != 0) {
      utilitiesPerMonthController.text = kCurrencyFormat.format(utilitiesPerMonth);
    }
    monthsOfHolding = ref.read(quickMaxProvider).monthsOfHolding;
    if (monthsOfHolding != 0) {
      monthsOfHoldingController.text = kWholeNumber.format(monthsOfHolding);
    }
    rehabCosts = ref.read(quickMaxProvider).rehabCosts;
    if (rehabCosts != 0) {
      rehabCostsController.text = kCurrencyFormat.format(rehabCosts);
    }
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
                      controller: addressController,
                      hint: 'Address',
                      onChanged: (String? newAddress) {
                        if (newAddress != null) {
                          ref.read(quickMaxProvider).updateAddress(newAddress);
                        }
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
                          ref.read(quickMaxProvider).updateAfterRepairValue(arvTemp);
                          setState(() {
                            arv = arvTemp;
                          });
                        }
                        else {
                          ref.read(quickMaxProvider).updateAfterRepairValue(0.0);
                          setState(() {
                            arv = 0;
                          });
                        }
                        ref.read(quickMaxProvider).calculateAllQuickMaxOffer();
                      }),
                  MoneyListTile('Total Holding Costs', totalHoldingCostsString),
                  Row(
                    children: [
                      const Text('Financing Type', style: TextStyle(fontWeight: FontWeight.w700),),
                      const SizedBox(width: 8),
                      Expanded(child: FinancingTypeDropDown(initialValue: financingType,
                        onChanged: (FinancingType? newType) {
                          if (newType != null) {
                            ref.read(quickMaxProvider).updateFinancingType(newType);
                            setState(() {
                              financingType = newType;
                            });
                          }
                        },
                      )),
                    ],
                  ),
                  PercentTextField(labelText: 'Down Payment Percentage',
                    controller: downPaymentPercentageController,
                    onChanged: (String newPercentage) {
                      newPercentage = newPercentage.replaceAll(',', '');
                      double? newValue = double.tryParse(newPercentage);
                      if (newValue != null) {
                        ref.read(quickMaxProvider).updateDownPaymentPercentage(newValue / 100);
                        setState(() {
                          downPaymentPercentage = newValue / 100;
                        });
                      }
                      else {
                        ref.read(quickMaxProvider).updateDownPaymentPercentage(0.0);
                        setState(() {
                          downPaymentPercentage = 0;
                        });
                      }
                      ref.read(quickMaxProvider).calculateAllQuickMaxOffer();
                    },
                      ),
                  MoneyListTile('Loan Amount', loanAmountString),
                  MoneyListTile('Down Payment', downPaymentString),
                  PercentTextField(labelText: 'Interest Rate',
                    controller: interestRateController,
                    onChanged: (String newPercentage) {
                      newPercentage = newPercentage.replaceAll(',', '');
                      double? newValue = double.tryParse(newPercentage);
                      if (newValue != null) {
                        ref.read(quickMaxProvider).updateInterestRate(newValue / 100);
                        setState(() {
                          interestRate = newValue / 100;
                        });
                      }
                      else {
                        ref.read(quickMaxProvider).updateInterestRate(0.0);
                        setState(() {
                          interestRate = 0;
                        });
                      }
                      ref.read(quickMaxProvider).calculateAllQuickMaxOffer();
                    },
                  ),
                  IntegerTextField(labelText: 'Term in Years',
                    controller: termInYearsController,
                    onChanged: (String newTerm) {
                      newTerm = newTerm.replaceAll(',', '');
                      int? newValue = int.tryParse(newTerm);
                      if (newValue != null) {
                        ref.read(quickMaxProvider).updateTerm(newValue);
                        setState(() {
                          termInYears = newValue;
                        });
                      }
                      else {
                        ref.read(quickMaxProvider).updateTerm(0);
                        setState(() {
                          termInYears = 0;
                        });
                      }
                      ref.read(quickMaxProvider).calculateAllQuickMaxOffer();
                    },
                    leftPadding: 0,),
                  MoneyTextField(labelText: 'Closing Costs',
                    controller: closingCostsController,
                    onChanged: (String newValue) {
                      newValue = newValue.replaceAll(',', '');
                      double? costs = double.tryParse(newValue);
                      if (costs != null) {
                        ref.read(quickMaxProvider).updateClosingCosts(costs);
                        setState(() {
                          closingCosts = costs;
                        });
                      }
                      else {
                        ref.read(quickMaxProvider).updateClosingCosts(0.0);
                        setState(() {
                          closingCosts = 0;
                        });
                      }
                      ref.read(quickMaxProvider).calculateAllQuickMaxOffer();
                    },
                  ),
                  MoneyTextField(labelText: 'Taxes Per Year',
                    controller: taxesPerYearController,
                    onChanged: (String newValue) {
                      newValue = newValue.replaceAll(',', '');
                      double? taxes = double.tryParse(newValue);
                      if (taxes != null) {
                        ref.read(quickMaxProvider).updateTaxesPerYear(taxes);
                        setState(() {
                          taxesPerYear = taxes;
                          taxesPerMonth = taxesPerYear / 12;
                          taxesPerMonthString = kCurrencyFormat.format(taxesPerMonth);
                        });
                      }
                      else {
                        ref.read(quickMaxProvider).updateTaxesPerYear(0.0);
                        setState(() {
                          taxesPerYear = 0;
                          taxesPerMonth = taxesPerYear / 12;
                          taxesPerMonthString = kCurrencyFormat.format(taxesPerMonth);
                        });
                      }
                      ref.read(quickMaxProvider).calculateAllQuickMaxOffer();
                    },
                  ),
                  MoneyListTile('Taxes Per Month', taxesPerMonthString),
                  MoneyTextField(labelText: 'Insurance Per Year',
                    controller: insurancePerYearController,
                    onChanged: (String newValue) {
                      newValue = newValue.replaceAll(',', '');
                      double? insurance = double.tryParse(newValue);
                      if (insurance != null) {
                        ref.read(quickMaxProvider).updateInsurancePerYear(insurance);
                        setState(() {
                          insurancePerYear = insurance;
                          insurancePerMonth = insurancePerYear / 12;
                          insurancePerMonthString = kCurrencyFormat.format(insurancePerMonth);
                        });
                      }
                      else {
                        ref.read(quickMaxProvider).updateInsurancePerYear(0.0);
                        setState(() {
                          insurancePerYear = 0;
                          insurancePerMonth = insurancePerYear / 12;
                          insurancePerMonthString = kCurrencyFormat.format(insurancePerMonth);
                        });
                      }
                      ref.read(quickMaxProvider).calculateAllQuickMaxOffer();
                    },
                  ),
                  MoneyListTile('Insurance Per Month', insurancePerMonthString),
                  MoneyTextField(labelText: 'Utilities Per Month',
                    controller: utilitiesPerMonthController,
                    onChanged: (String newValue) {
                      newValue = newValue.replaceAll(',', '');
                      double? costs = double.tryParse(newValue);
                      if (costs != null) {
                        ref.read(quickMaxProvider).updateUtilitiesPerMonth(costs);
                        setState(() {
                          utilitiesPerMonth = costs;
                        });
                      }
                      else {
                        ref.read(quickMaxProvider).updateUtilitiesPerMonth(0.0);
                        setState(() {
                          utilitiesPerMonth = 0;
                        });
                      }
                      ref.read(quickMaxProvider).calculateAllQuickMaxOffer();
                    },
                  ),
                  MoneyListTile('Principle \n& Interest',
                      principleInterestMonthlyString, subtitle: 'Monthly',),
                  IntegerTextField(labelText: 'Months of Holding',
                    controller: monthsOfHoldingController,
                    onChanged: (String newTerm) {
                      newTerm = newTerm.replaceAll(',', '');
                      int? newValue = int.tryParse(newTerm);
                      if (newValue != null) {
                        ref.read(quickMaxProvider).updateMonthsOfHolding(newValue);
                        setState(() {
                          monthsOfHolding = newValue;
                        });
                      }
                      else {
                        ref.read(quickMaxProvider).updateMonthsOfHolding(0);
                        setState(() {
                          monthsOfHolding = 0;
                        });
                      }
                      ref.read(quickMaxProvider).calculateAllQuickMaxOffer();
                    },
                  ),
                  MoneyListTile('Total Holding Costs', totalHoldingCostsString),
                  MoneyTextField(
                    labelText: 'Rehab Costs',
                    controller: rehabCostsController,
                      onChanged: (String newValue) {
                        newValue = newValue.replaceAll(',', '');
                        double? rehabTemp = double.tryParse(newValue);
                        if (rehabTemp != null) {
                          ref.read(quickMaxProvider).updateRehabCosts(rehabTemp);
                          setState(() {
                            rehabCosts = rehabTemp;
                          });
                        }
                        else {
                          ref.read(quickMaxProvider).updateRehabCosts(0.0);
                          setState(() {
                            rehabCosts = 0;
                          });
                        }
                        ref.read(quickMaxProvider).calculateAllQuickMaxOffer();
                      }
                  ),

                  MoneyListTile('Equity / Down \nPayment', downPaymentString),
                  MoneyListTile((MediaQuery.of(context).size.width < 640)
                      ? 'Max\nOffer' : 'Max Offer', maxOfferString),
                ],
              ),
              const SizedBox(height: 16),
              const FinalOptionsButtons(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
