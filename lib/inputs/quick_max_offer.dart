// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:calculators/globals.dart';
import 'package:calculators/home.dart';
import 'package:calculators/models/calculator.dart';
import 'package:calculators/models/database_utils.dart';
import 'package:calculators/models/financing_type.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/financing_type_drop_down.dart';
import 'package:calculators/widgets/integer_text_field.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:calculators/widgets/percent_text_field.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:calculators/widgets/sign_out_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class QuickMaxOffer extends ConsumerStatefulWidget {
  const QuickMaxOffer({
    Key? key,
  }) : super(key: key);

  @override
  _QuickMaxOfferState createState() => _QuickMaxOfferState();
}

class _QuickMaxOfferState extends ConsumerState<QuickMaxOffer> {
  TextEditingController addressController = TextEditingController();
  TextEditingController arvController = TextEditingController();
  TextEditingController purchasePriceController = TextEditingController();
  TextEditingController rehabController = TextEditingController();
  TextEditingController refinancePercentage = TextEditingController();
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
  String taxesPerMonthString = '';
  String insurancePerMonthString = '';

  FinancingType financingType = FinancingType.commercial;

  List<BottomNavigationBarItem> buttonsForReport = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(icon: Icon(Icons.save), label: 'Save'),
  ];

  @override
  void initState() {
    addressController.text = ref.read(quickMaxProvider).address;
    arv = ref.read(quickMaxProvider).arv;
    if (arv != 0) {
      arvController.text = kCurrencyFormat.format(arv);
    }
    if (ref.read(quickMaxProvider).purchasePrice != 0) {
      purchasePriceController.text =
          kCurrencyFormat.format(ref.read(quickMaxProvider).purchasePrice);
    }
    if (ref.read(quickMaxProvider).rehab != 0) {
      rehabController.text =
          kCurrencyFormat.format(ref.read(quickMaxProvider).rehab);
    }
    financingType = ref.read(quickMaxProvider).financingType;
    downPaymentPercentage = ref.read(quickMaxProvider).downPaymentPercentage;
    if (downPaymentPercentage != 0) {
      refinancePercentage.text = (downPaymentPercentage * 100).toString();
    }
    interestRate = ref.read(quickMaxProvider).interestRate;
    if (interestRate != 0) {
      interestRateController.text = (interestRate * 100).toString();
    }
    termInYears = ref.read(quickMaxProvider).termInYears;
    if (termInYears != 0) {
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
      insurancePerYearController.text =
          kCurrencyFormat.format(insurancePerYear);
    }
    insurancePerMonth = ref.read(quickMaxProvider).insurancePerMonth;
    if (insurancePerMonth != 0) {
      insurancePerMonthString = kCurrencyFormat.format(insurancePerMonth);
    }
    utilitiesPerMonth = ref.read(quickMaxProvider).utilitiesPerMonth;
    if (utilitiesPerMonth != 0) {
      utilitiesPerMonthController.text =
          kCurrencyFormat.format(utilitiesPerMonth);
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
      body: Form(
        key: quickMaxOfferKey,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
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
                            child: PlacesAutocompleteFormField(
                              controller: addressController,
                              hint: 'Address *',
                              onSaved: (String? newAddress) {
                                if (newAddress != null) {
                                  ref
                                      .read(quickMaxProvider)
                                      .updateAddress(newAddress);
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Address is required';
                                }
                                return null;
                              },
                              apiKey: kGoogleAPIkey,
                              mode: Mode.overlay,
                            ),
                          ),
                          MoneyTextField(
                            labelText: 'ARV *',
                            controller: arvController,
                            onChanged: (String newValue) {
                              newValue = newValue.replaceAll(',', '');
                              double? arvTemp = double.tryParse(newValue);
                              if (arvTemp != null) {
                                ref
                                    .read(quickMaxProvider)
                                    .updateAfterRepairValue(arvTemp);
                                setState(() {
                                  arv = arvTemp;
                                });
                              } else {
                                ref
                                    .read(quickMaxProvider)
                                    .updateAfterRepairValue(0.0);
                                setState(() {
                                  arv = 0;
                                });
                              }
                              ref
                                  .read(quickMaxProvider)
                                  .calculateAllQuickMaxOffer();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'ARV is required';
                              }
                              return null;
                            },
                          ),
                          MoneyTextField(
                            labelText: 'Purchase Price *',
                            controller: purchasePriceController,
                            onChanged: (String newValue) {
                              newValue = newValue.replaceAll(',', '');
                              double? temp = double.tryParse(newValue);
                              if (temp != null) {
                                ref
                                    .read(quickMaxProvider)
                                    .updatePurchasePrice(temp);
                              } else {
                                ref
                                    .read(quickMaxProvider)
                                    .updatePurchasePrice(0.0);
                              }
                              ref
                                  .read(quickMaxProvider)
                                  .calculateAllQuickMaxOffer();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Purchase price is required';
                              }
                              return null;
                            },
                          ),
                          MoneyTextField(
                            labelText: 'Estimated rehab costs *',
                            controller: rehabController,
                            onChanged: (String newValue) {
                              newValue = newValue.replaceAll(',', '');
                              double? temp = double.tryParse(newValue);
                              if (temp != null) {
                                ref.read(quickMaxProvider).updateRehab(temp);
                              } else {
                                ref.read(quickMaxProvider).updateRehab(0.0);
                              }
                              ref
                                  .read(quickMaxProvider)
                                  .calculateAllQuickMaxOffer();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Rehab is required';
                              }
                              return null;
                            },
                          ),
                          Row(
                            children: [
                              const Text(
                                'Financing Type',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                  child: FinancingTypeDropDown(
                                initialValue: financingType,
                                onChanged: (FinancingType? newType) {
                                  if (newType != null) {
                                    ref
                                        .read(quickMaxProvider)
                                        .updateFinancingType(newType);
                                    setState(() {
                                      financingType = newType;
                                    });
                                  }
                                },
                              )),
                            ],
                          ),
                          PercentTextField(
                            labelText: 'Refinance Loan to Value % *',
                            controller: refinancePercentage,
                            onChanged: (String newPercentage) {
                              newPercentage = newPercentage.replaceAll(',', '');
                              double? newValue = double.tryParse(newPercentage);
                              if (newValue != null) {
                                ref
                                    .read(quickMaxProvider)
                                    .updateDownPaymentPercentage(
                                        newValue / 100);
                                setState(() {
                                  downPaymentPercentage = newValue / 100;
                                });
                              } else {
                                ref
                                    .read(quickMaxProvider)
                                    .updateDownPaymentPercentage(0.0);
                                setState(() {
                                  downPaymentPercentage = 0;
                                });
                              }
                              ref
                                  .read(quickMaxProvider)
                                  .calculateAllQuickMaxOffer();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Percentage is required';
                              }
                              return null;
                            },
                          ),
                          MoneyListTile(
                            'Down Payment',
                            kCurrencyFormat.format(
                                ref.watch(quickMaxProvider).downPayment),
                            subtitle: 'Equity',
                          ),
                          MoneyListTile(
                            'Loan Amount',
                            kCurrencyFormat
                                .format(ref.watch(quickMaxProvider).loanAmount),
                          ),
                          PercentTextField(
                            labelText: 'Interest Rate *',
                            controller: interestRateController,
                            onChanged: (String newPercentage) {
                              newPercentage = newPercentage.replaceAll(',', '');
                              double? newValue = double.tryParse(newPercentage);
                              if (newValue != null) {
                                ref
                                    .read(quickMaxProvider)
                                    .updateInterestRate(newValue / 100);
                                setState(() {
                                  interestRate = newValue / 100;
                                });
                              } else {
                                ref
                                    .read(quickMaxProvider)
                                    .updateInterestRate(0.0);
                                setState(() {
                                  interestRate = 0;
                                });
                              }
                              ref
                                  .read(quickMaxProvider)
                                  .calculateAllQuickMaxOffer();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Interest rate is required';
                              }
                              return null;
                            },
                          ),
                          IntegerTextField(
                            labelText: 'Term in Years *',
                            controller: termInYearsController,
                            onChanged: (String newTerm) {
                              newTerm = newTerm.replaceAll(',', '');
                              int? newValue = int.tryParse(newTerm);
                              if (newValue != null) {
                                ref.read(quickMaxProvider).updateTerm(newValue);
                                setState(() {
                                  termInYears = newValue;
                                });
                              } else {
                                ref.read(quickMaxProvider).updateTerm(0);
                                setState(() {
                                  termInYears = 0;
                                });
                              }
                              ref
                                  .read(quickMaxProvider)
                                  .calculateAllQuickMaxOffer();
                            },
                            leftPadding: 0,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Term is required';
                              }
                              return null;
                            },
                          ),
                          MoneyTextField(
                            labelText: 'Closing Costs *',
                            controller: closingCostsController,
                            onChanged: (String newValue) {
                              newValue = newValue.replaceAll(',', '');
                              double? costs = double.tryParse(newValue);
                              if (costs != null) {
                                ref
                                    .read(quickMaxProvider)
                                    .updateClosingCosts(costs);
                                setState(() {
                                  closingCosts = costs;
                                });
                              } else {
                                ref
                                    .read(quickMaxProvider)
                                    .updateClosingCosts(0.0);
                                setState(() {
                                  closingCosts = 0;
                                });
                              }
                              ref
                                  .read(quickMaxProvider)
                                  .calculateAllQuickMaxOffer();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Closing costs are required';
                              }
                              return null;
                            },
                          ),
                          MoneyTextField(
                            labelText: 'Taxes Per Year *',
                            controller: taxesPerYearController,
                            onChanged: (String newValue) {
                              newValue = newValue.replaceAll(',', '');
                              double? taxes = double.tryParse(newValue);
                              if (taxes != null) {
                                ref
                                    .read(quickMaxProvider)
                                    .updateTaxesPerYear(taxes);
                                setState(() {
                                  taxesPerYear = taxes;
                                  taxesPerMonth = taxesPerYear / 12;
                                  taxesPerMonthString =
                                      kCurrencyFormat.format(taxesPerMonth);
                                });
                              } else {
                                ref
                                    .read(quickMaxProvider)
                                    .updateTaxesPerYear(0.0);
                                setState(() {
                                  taxesPerYear = 0;
                                  taxesPerMonth = taxesPerYear / 12;
                                  taxesPerMonthString =
                                      kCurrencyFormat.format(taxesPerMonth);
                                });
                              }
                              ref
                                  .read(quickMaxProvider)
                                  .calculateAllQuickMaxOffer();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Taxes are required';
                              }
                              return null;
                            },
                          ),
                          MoneyListTile('Taxes Per Month', taxesPerMonthString),
                          MoneyTextField(
                            labelText: 'Insurance Per Year *',
                            controller: insurancePerYearController,
                            onChanged: (String newValue) {
                              newValue = newValue.replaceAll(',', '');
                              double? insurance = double.tryParse(newValue);
                              if (insurance != null) {
                                ref
                                    .read(quickMaxProvider)
                                    .updateInsurancePerYear(insurance);
                                setState(() {
                                  insurancePerYear = insurance;
                                  insurancePerMonth = insurancePerYear / 12;
                                  insurancePerMonthString =
                                      kCurrencyFormat.format(insurancePerMonth);
                                });
                              } else {
                                ref
                                    .read(quickMaxProvider)
                                    .updateInsurancePerYear(0.0);
                                setState(() {
                                  insurancePerYear = 0;
                                  insurancePerMonth = insurancePerYear / 12;
                                  insurancePerMonthString =
                                      kCurrencyFormat.format(insurancePerMonth);
                                });
                              }
                              ref
                                  .read(quickMaxProvider)
                                  .calculateAllQuickMaxOffer();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Insurance is required';
                              }
                              return null;
                            },
                          ),
                          MoneyListTile(
                              'Insurance Per Month', insurancePerMonthString),
                          MoneyTextField(
                            labelText: 'Utilities Per Month *',
                            controller: utilitiesPerMonthController,
                            onChanged: (String newValue) {
                              newValue = newValue.replaceAll(',', '');
                              double? costs = double.tryParse(newValue);
                              if (costs != null) {
                                ref
                                    .read(quickMaxProvider)
                                    .updateUtilitiesPerMonth(costs);
                                setState(() {
                                  utilitiesPerMonth = costs;
                                });
                              } else {
                                ref
                                    .read(quickMaxProvider)
                                    .updateUtilitiesPerMonth(0.0);
                                setState(() {
                                  utilitiesPerMonth = 0;
                                });
                              }
                              ref
                                  .read(quickMaxProvider)
                                  .calculateAllQuickMaxOffer();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Utilities are required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          CupertinoSlidingSegmentedControl<PaymentType>(
                            thumbColor:
                                Theme.of(context).primaryColor.withOpacity(0.4),
                            groupValue: ref.watch(quickMaxProvider).paymentType,
                            children: const {
                              PaymentType.principalAndInterest:
                                  Text('Principal & Interest'),
                              PaymentType.interestOnly: Text('Interest Only'),
                            },
                            onValueChanged: (PaymentType? newValue) {
                              ref
                                  .read(quickMaxProvider)
                                  .updatePaymentType(newValue!);
                              ref.read(quickMaxProvider).calculateAllQuickMaxOffer();
                            },
                          ),
                          MoneyListTile(
                            'Monthly\nPayment',
                            kCurrencyFormat.format(
                                ref.watch(quickMaxProvider).monthlyPayment),
                          ),
                          IntegerTextField(
                            labelText: 'Months of Holding *',
                            controller: monthsOfHoldingController,
                            onChanged: (String newTerm) {
                              newTerm = newTerm.replaceAll(',', '');
                              int? newValue = int.tryParse(newTerm);
                              if (newValue != null) {
                                ref
                                    .read(quickMaxProvider)
                                    .updateMonthsOfHolding(newValue);
                                setState(() {
                                  monthsOfHolding = newValue;
                                });
                              } else {
                                ref
                                    .read(quickMaxProvider)
                                    .updateMonthsOfHolding(0);
                                setState(() {
                                  monthsOfHolding = 0;
                                });
                              }
                              ref
                                  .read(quickMaxProvider)
                                  .calculateAllQuickMaxOffer();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Months is required';
                              }
                              return null;
                            },
                          ),
                          MoneyListTile(
                              'Total Holding Costs',
                              kCurrencyFormat.format(ref
                                  .watch(quickMaxProvider)
                                  .totalHoldingCosts)),
                          MoneyListTile(
                              'Equity / Down \nPayment',
                              kCurrencyFormat.format(
                                  ref.watch(quickMaxProvider).downPayment)),
                          MoneyListTile(
                              (MediaQuery.of(context).size.width < 640)
                                  ? 'Max\nOffer'
                                  : 'Max Offer',
                              kCurrencyFormat.format(
                                  ref.watch(quickMaxProvider).maxOffer)),
                          MoneyListTile(
                            (MediaQuery.of(context).size.width < 640)
                                ? 'Rehab\nFunds'
                                : 'Rehab Funds',
                            kCurrencyFormat
                                .format(ref.watch(quickMaxProvider).rehabFunds),
                            subtitle: 'Max Available',
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                BottomNavigationBar(
                    onTap: (int tappedNumber) async {
                      if (tappedNumber == 0) {
                        resetAllData(ref);
                        Get.offAll(() =>
                            const MyHomePage(title: 'Vereifi', startingTab: 0));
                      } else if (tappedNumber == 1) {
                        if (quickMaxOfferKey.currentState?.validate() ??
                            false) {
                          Calculator currentCalculator =
                              ref.read(calculatorProvider).type;
                          Map<String, dynamic> data = {};
                          if (currentCalculator == Calculator.brrrr) {
                            data = ref.read(brrrrProvider).toJson();
                          } else if (currentCalculator ==
                              Calculator.quickMaxOffer) {
                            data = ref.read(quickMaxProvider).toJson();
                          } else if (currentCalculator ==
                              Calculator.fixAndFlip) {
                            data = ref.read(fixFlipProvider).toJson();
                          } else if (currentCalculator ==
                              Calculator.turnkeyRental) {
                            data = ref.read(turnkeyProvider).toJson();
                          }

                          // get the document ID to update the record, otherwise create a new document
                          String docID = ref.read(savedCalculatorProvider).uid;
                          await DatabaseUtils.saveDataToDatabase(
                              uid: FirebaseAuth.instance.currentUser!.uid,
                              data: data,
                              docID: (docID != '' ? docID : null));
                          resetAllData(ref);
                          Get.offAll(() => const MyHomePage(
                                title: '',
                                startingTab: 1,
                              ));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            margin: const EdgeInsets.all(16),
                            content: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.check, color: Colors.white),
                                SizedBox(width: 4),
                                Text(
                                  'Place saved!',
                                ),
                              ],
                            ),
                            shape: const StadiumBorder(),
                            behavior: SnackBarBehavior.floating,
                          ));
                        }
                      }
                    },
                    unselectedItemColor: Theme.of(context).indicatorColor,
                    items:
                        buttonsForReport // show a save button on the report page
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
