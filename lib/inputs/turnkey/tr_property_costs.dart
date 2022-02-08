import 'package:calculators/globals.dart';
import 'package:calculators/inputs/turnkey/tr_income_input.dart';
import 'package:calculators/inputs/turnkey/turnkey_rental.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/integer_text_field.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class TurnkeyRentalPropertyCosts extends ConsumerStatefulWidget {
  const TurnkeyRentalPropertyCosts({Key? key}) : super(key: key);

  @override
  PropertyCostsState createState() => PropertyCostsState();
}

class PropertyCostsState extends ConsumerState<TurnkeyRentalPropertyCosts> {
  TextEditingController listPriceController = TextEditingController();
  TextEditingController renovationsController = TextEditingController();
  TextEditingController afterRepairController = TextEditingController();
  TextEditingController purchasePriceController = TextEditingController();
  TextEditingController unitsController = TextEditingController();
  TextEditingController investorsController = TextEditingController();

  @override
  void initState() {
    double purchasePrice = ref.read(turnkeyProvider).purchasePrice;
    if (purchasePrice != 0) {
      purchasePriceController.text = kCurrencyFormat.format(purchasePrice);
    }
    int units = ref.read(turnkeyProvider).units;
    if (units != 0) {
      unitsController.text = units.toString();
    }
    int investors = ref.read(turnkeyProvider).investors;
    if (investors != 0) {
      investorsController.text = investors.toString();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double listPrice = ref.read(turnkeyProvider).listPrice;

    String listPriceString = kCurrencyFormat.format(listPrice);

    return MyInputPage(
        imageUri: 'images/property.svg',
        headerText: 'Property Costs',
        subheadText: 'Now let\'s get some information about costs associated '
            'with this property.',
      onBack: () {
        String savedCalculatorID = ref.read(savedCalculatorProvider).uid;
        bool shouldOverrideBackButton = savedCalculatorID != '';
        if (shouldOverrideBackButton) {
          Get.off(() => TurnkeyRentalInput('Turnkey Rental'));
        } else {
          Get.back();
        }
      },
        onSubmit: () {
            {
              if (turnkeyPropertyCostsKey.currentState?.validate() ?? false) {
                Get.to(() => const TurnkeyRentalIncomeInput());
              }
            }
        },
        position: kTurnKeyRentalQuestions.indexOf(TurnkeyRentalPropertyCosts) + 1,
        totalQuestions: kTurnKeyRentalQuestions.length,
        child: Form(
          key: turnkeyPropertyCostsKey,
          child: ResponsiveLayout(
            children: [
              MoneyListTile(
                'List Price',
                listPriceString,
              ),
              MoneyTextField(
                  labelText: 'Purchase Price * ',
                  controller: purchasePriceController,
                  onChanged: (String newPrice) {
                    newPrice = newPrice.replaceAll(',', '');
                    double? price = double.tryParse(newPrice);
                    if(price != null) {
                      ref.read(turnkeyProvider).updatePurchasePrice(price);
                    }
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
                      ref.read(turnkeyProvider).updateUnits(value);
                    }
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
                      ref.read(turnkeyProvider).updateInvestors(value);
                    }
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
