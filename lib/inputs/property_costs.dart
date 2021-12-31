import 'package:calculators/globals.dart';
import 'package:calculators/inputs/expenses_input.dart';
import 'package:calculators/inputs/income_input.dart';
import 'package:calculators/models/calculator.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/integer_text_field.dart';
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

  @override
  void initState() {
    listPriceController.text = kCurrencyFormat.format(ref.read(brrrrProvider)
        .listPrice).toString();
    renovationsController.text = kCurrencyFormat.format(ref.read(brrrrProvider)
        .totalRenovations).toString();
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

    return MyInputPage(
        imageUri: 'images/property.svg',
        headerText: 'Property Costs',
        subheadText: 'Now let\'s get some information about costs associated '
            'with this property.',
        onSubmit: () {
          Calculator calculatorType = ref.read(calculatorProvider).type;
          if (calculatorType == Calculator.brrrr) {
            Get.to(() => const IncomeInput());
          }
          else {
            Get.to(() => const ExpensesInput());
          }
        },
        position: kBRRRRQuestions.indexOf(PropertyCosts) + 1,
        totalQuestions: kBRRRRQuestions.length,
        child: ResponsiveLayout(
          children: [
            MoneyTextField(
                labelText: 'List Price',
                controller: listPriceController,
                onChanged: (String newListPrice) {
                  newListPrice = newListPrice.replaceAll(',', '');
                  double? listPrice = double.tryParse(newListPrice);
                  if (listPrice != null) {
                    ref.read(brrrrProvider).updateListPrice(listPrice);
                  }
                },
            ),
            MoneyTextField(
                labelText: 'Rehab',
                controller: renovationsController,
                onChanged: (String newTotal) {
                  newTotal = newTotal.replaceAll(',', '');
                  double? total = double.tryParse(newTotal);
                  if(total != null) {
                    ref.read(brrrrProvider).updateTotalRenovations(total);
                  }
                },
            ),
            MoneyTextField(
                labelText: 'After Repair Value',
                controller: afterRepairController,
                onChanged: (String newPrice) {
                  newPrice = newPrice.replaceAll(',', '');
                  double? price = double.tryParse(newPrice);
                  if(price != null) {
                    ref.read(brrrrProvider).updateAfterRepairValue(price);
                  }
                }
            ),
            MoneyTextField(
                labelText: 'Purchase Price',
                controller: purchasePriceController,
                onChanged: (String newPrice) {
                  newPrice = newPrice.replaceAll(',', '');
                  double? price = double.tryParse(newPrice);
                  if(price != null) {
                    ref.read(brrrrProvider).updatePurchasePrice(price);
                  }
                }
            ),
            IntegerTextField(
                labelText: 'Number of Units',
                controller: unitsController,
                onChanged: (String newValue) {
                  int? value = int.tryParse(newValue);
                  if(value != null) {
                    ref.read(brrrrProvider).updateUnits(value);
                  }
                }),
            IntegerTextField(
                labelText: 'Number of Investors',
                controller: investorsController,
                onChanged: (String newValue) {
                  int? value = int.tryParse(newValue);
                  if(value != null) {
                    ref.read(brrrrProvider).updateInvestors(value);
                  }
                }),
          ],),
    );
  }
}
