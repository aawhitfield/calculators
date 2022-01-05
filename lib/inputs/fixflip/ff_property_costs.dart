import 'package:calculators/globals.dart';
import 'package:calculators/inputs/fixflip/ff_expenses_input.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/integer_text_field.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class FixFlipPropertyCosts extends ConsumerStatefulWidget {
  const FixFlipPropertyCosts({Key? key}) : super(key: key);

  @override
  PropertyCostsState createState() => PropertyCostsState();
}

class PropertyCostsState extends ConsumerState<FixFlipPropertyCosts> {
  TextEditingController listPriceController = TextEditingController();
  TextEditingController renovationsController = TextEditingController();
  TextEditingController afterRepairController = TextEditingController();
  TextEditingController purchasePriceController = TextEditingController();
  TextEditingController unitsController = TextEditingController();
  TextEditingController investorsController = TextEditingController();

  @override
  void initState() {
    double afterRepairValue = ref.read(fixFlipProvider).afterRepairValue;
    if (afterRepairValue != 0) {
      afterRepairController.text = kCurrencyFormat.format(afterRepairValue);
    }
    double purchasePrice = ref.read(fixFlipProvider).purchasePrice;
    if (purchasePrice != 0) {
      purchasePriceController.text = kCurrencyFormat.format(purchasePrice);
    }
    int units = ref.read(fixFlipProvider).units;
    if (units != 0) {
      unitsController.text = units.toString();
    }
    int investors = ref.read(fixFlipProvider).investors;
    if (investors != 0) {
      investorsController.text = investors.toString();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double listPrice = ref.read(fixFlipProvider).listPrice;
    double renovations = ref.read(fixFlipProvider).totalRenovations;

    String listPriceString = kCurrencyFormat.format(listPrice);
    String renovationsString = kCurrencyFormat.format(renovations);

    return MyInputPage(
        imageUri: 'images/property.svg',
        headerText: 'Property Costs',
        subheadText: 'Now let\'s get some information about costs associated '
            'with this property.',
        onSubmit: () {
            Get.to(() => const FixFlipExpensesInput());
        },
        position: kFixFlipQuestions.indexOf(FixFlipPropertyCosts) + 1,
        totalQuestions: kFixFlipQuestions.length,
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
                labelText: 'After Repair Value',
                controller: afterRepairController,
                onChanged: (String newPrice) {
                  newPrice = newPrice.replaceAll(',', '');
                  double? price = double.tryParse(newPrice);
                  if(price != null) {
                    ref.read(fixFlipProvider).updateAfterRepairValue(price);
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
                    ref.read(fixFlipProvider).updatePurchasePrice(price);
                  }
                }
            ),
            IntegerTextField(
                labelText: 'Number of Units',
                controller: unitsController,
                onChanged: (String newValue) {
                  int? value = int.tryParse(newValue);
                  if(value != null) {
                    ref.read(fixFlipProvider).updateUnits(value);
                  }
                }),
            IntegerTextField(
                labelText: 'Number of Investors',
                controller: investorsController,
                onChanged: (String newValue) {
                  int? value = int.tryParse(newValue);
                  if(value != null) {
                    ref.read(fixFlipProvider).updateInvestors(value);
                  }
                }),
          ],),
    );
  }
}
