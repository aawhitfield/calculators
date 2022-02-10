import 'package:calculators/globals.dart';
import 'package:calculators/inputs/brrrr/expenses_input.dart';
import 'package:calculators/inputs/brrrr/income_input.dart';
import 'package:calculators/inputs/brrrr/renovations_calculator.dart';
import 'package:calculators/models/calculator.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/integer_text_field.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class PropertyCosts extends ConsumerStatefulWidget {
  const PropertyCosts({Key? key}) : super(key: key);

  @override
  PropertyCostsState createState() => PropertyCostsState();
}

class PropertyCostsState extends ConsumerState<PropertyCosts> {
  TextEditingController listPriceController = TextEditingController();
  TextEditingController renovationsController = TextEditingController();
  TextEditingController afterRepairController = TextEditingController();
  TextEditingController purchasePriceController = TextEditingController();
  TextEditingController unitsController = TextEditingController();
  TextEditingController investorsController = TextEditingController();

  GlobalKey<FormState> brrrrPropertyKey = GlobalKey<FormState>();

  @override
  void initState() {
    double afterRepairValue = ref.read(brrrrProvider).afterRepairValue;
    if (afterRepairValue != 0) {
      afterRepairController.text = kCurrencyFormat.format(afterRepairValue);
    }
    double purchasePrice = ref.read(brrrrProvider).purchasePrice;
    if (purchasePrice != 0) {
      purchasePriceController.text = kCurrencyFormat.format(purchasePrice);
    }
    int units = ref.read(brrrrProvider).units;
    if (units != 0) {
      unitsController.text = units.toString();
    }
    int investors = ref.read(brrrrProvider).investors;
    if (investors != 0) {
      investorsController.text = investors.toString();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double listPrice = ref.read(brrrrProvider).listPrice;
    double renovations = ref.read(brrrrProvider).totalRenovations;

    String listPriceString = kCurrencyFormat.format(listPrice);
    String renovationsString = kCurrencyFormat.format(renovations);

    return MyInputPage(
        imageUri: 'images/property.svg',
        headerText: 'Property Costs',
        subheadText: 'Now let\'s get some information about costs associated '
            'with this property.',
      onBack: () {
        String savedCalculatorID = ref.read(savedCalculatorProvider).uid;
        bool shouldOverrideBackButton = savedCalculatorID != '';
        if (shouldOverrideBackButton) {
          Get.off(() => const RenovationsCalculator());
        } else {
          Get.back();
        }
      },
        onSubmit: () {
          Calculator calculatorType = ref.read(calculatorProvider).type;
          if (brrrrPropertyKey.currentState?.validate() ?? false) {
            if (calculatorType == Calculator.brrrr) {
              Get.to(() => const IncomeInput());
            }
            else {
              Get.to(() => const ExpensesInput());
            }
          }
        },
        position: kBRRRRQuestions.indexOf(PropertyCosts) + 1,
        totalQuestions: kBRRRRQuestions.length,
        child: Form(
          key: brrrrPropertyKey,
          child: ResponsiveLayout(
            children: [
              MoneyListTile(
                'List Price',
                listPriceString,
              ),
              MoneyListTile(
                'Rehab',
                renovationsString,
              ),
              MoneyTextField(
                  labelText: 'After Repair Value *',
                  controller: afterRepairController,
                  onChanged: (String newPrice) {
                    newPrice = newPrice.replaceAll(',', '');
                    double? price = double.tryParse(newPrice);
                    if(price != null) {
                      ref.read(brrrrProvider).updateAfterRepairValue(price);
                    }
                    else {
                      ref.read(brrrrProvider).updateAfterRepairValue(0.0);
                    }
                    ref.read(brrrrProvider).calculateAll();
                  },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'After repair value is required';
                  }
                  return null;
                },
              ),
              MoneyTextField(
                  labelText: 'Purchase Price *',
                  controller: purchasePriceController,
                  onChanged: (String newPrice) {
                    newPrice = newPrice.replaceAll(',', '');
                    double? price = double.tryParse(newPrice);
                    if(price != null) {
                      ref.read(brrrrProvider).updatePurchasePrice(price);
                    }else {
                      ref.read(brrrrProvider).updatePurchasePrice(0.0);
                    }
                    ref.read(brrrrProvider).calculateAll();
                  },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Purchase price is required';
                  }
                  return null;
                },
              ),
              IntegerTextField(
                  labelText: 'Number of Units *',
                  controller: unitsController,
                  onChanged: (String newValue) {
                    int? value = int.tryParse(newValue);
                    if(value != null) {
                      ref.read(brrrrProvider).updateUnits(value);
                    }
                    else {
                      ref.read(brrrrProvider).updateUnits(0);
                    }
                    ref.read(brrrrProvider).calculateAll();
                  },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Number of units is required';
                  }
                  return null;
                },
              ),
              IntegerTextField(
                  labelText: 'Number of Investors *',
                  controller: investorsController,
                  onChanged: (String newValue) {
                    int? value = int.tryParse(newValue);
                    if(value != null) {
                      ref.read(brrrrProvider).updateInvestors(value);
                    }
                    else {
                      ref.read(brrrrProvider).updateInvestors(0);
                    }
                    ref.read(brrrrProvider).calculateAll();
                  },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Number of investors is required';
                  }
                  return null;
                },
              ),
            ],),
        ),
    );
  }
}
