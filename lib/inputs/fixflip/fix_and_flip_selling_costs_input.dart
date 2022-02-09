import 'package:calculators/globals.dart';
import 'package:calculators/inputs/fixflip/ff_holding_costs.dart';
import 'package:calculators/outputs/fix_flip_statement.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/percent_text_field.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class FixAndFlipSellingCostsInput extends ConsumerStatefulWidget {
  const FixAndFlipSellingCostsInput({Key? key}) : super(key: key);

  @override
  _FixAndFlipSellingCostsInputState createState() => _FixAndFlipSellingCostsInputState();
}

class _FixAndFlipSellingCostsInputState extends ConsumerState<FixAndFlipSellingCostsInput> {
  TextEditingController realtorsFeesController = TextEditingController();
  TextEditingController sellersClosingCostsController = TextEditingController();
  TextEditingController buyersClosingCostsController = TextEditingController();
  TextEditingController closingCostsController = TextEditingController();
  TextEditingController otherClosingCostsController = TextEditingController();

  GlobalKey<FormState> ffSellingCostsKey = GlobalKey<FormState>();

  late double sellersClosingCosts;
  late double buyersClosingCosts;

  @override
  void initState() {
    double realtorsFeesDecimal = ref.read(fixFlipProvider).realtorFeesPercentage;
    double realtorsFeesPercentage = realtorsFeesDecimal * 100;
    if(realtorsFeesPercentage != 0) {
      realtorsFeesController.text = kWholeNumber.format(realtorsFeesPercentage);
    }

    sellersClosingCosts = ref.read(fixFlipProvider).sellersClosingCosts;
    if (sellersClosingCosts != 0) {
      sellersClosingCostsController.text = kCurrencyFormat.format(sellersClosingCosts);
    }

    buyersClosingCosts = ref.read(fixFlipProvider).buyersClosingCosts;
    if (buyersClosingCosts != 0) {
      buyersClosingCostsController.text = kCurrencyFormat.format(buyersClosingCosts);
    }
    double otherClosingCosts = ref.read(fixFlipProvider).otherClosingCosts;
    if(otherClosingCosts != 0) {
      otherClosingCostsController.text = kCurrencyFormat.format(otherClosingCosts);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double realtorsFees = ref.watch(fixFlipProvider).afterRepairValue *
        ref.watch(fixFlipProvider).realtorFeesPercentage;

    double taxes = ref.watch(fixFlipProvider).taxesYearly;
    double total = ref.watch(fixFlipProvider).totalClosingCosts;

    String taxesString = kCurrencyFormat.format(taxes);
    String realtorsFeesString = kCurrencyFormat.format(realtorsFees);
    String totalString = kCurrencyFormat.format(total);

    return Form(
      key: ffSellingCostsKey,
      child: MyInputPage(
        imageUri: 'images/transfer.svg',
        headerText: 'Fix and Flip',
        subheadText: 'Selling Costs',
        position:
            kFixFlipQuestions.indexOf(FixAndFlipSellingCostsInput) + 1,
        totalQuestions: kFixFlipQuestions.length,
        onBack: () {
          String savedCalculatorID = ref.read(savedCalculatorProvider).uid;
          bool shouldOverrideBackButton = savedCalculatorID != '';
          if (shouldOverrideBackButton) {
            Get.off(() => const FixFlipHoldingCosts());
          }
          else {
            Get.back();
          }
        },
        onSubmit: () {
          if (ffSellingCostsKey.currentState?.validate() ?? false) {
            Get.to(() => const FixFlipStatement());
          }
        },
        child: ResponsiveLayout(
          children: [
            PercentTextField(
              labelText: 'Realtor\'s Fees',
              controller: realtorsFeesController,
              onChanged: (String newPercentage) {
                newPercentage = newPercentage.replaceAll(',', '');
                double? newValue = double.tryParse(newPercentage);
                if (newValue != null) {
                  double realtorFeesPercentage = newValue / 100;
                  ref
                      .read(fixFlipProvider)
                      .updateRealtorFeesPercentage(realtorFeesPercentage);
                } else {
                  ref.read(fixFlipProvider).updateRealtorFeesPercentage(0.0);
                  ref.read(fixFlipProvider).updateRealtorFees(0);
                }
                ref.read(fixFlipProvider).calculateAllSellingCosts();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Realtor\'s fees are required';
                }
                return null;
              },
            ),
            MoneyListTile(
                (MediaQuery.of(context).size.width < 640)
                    ? 'Realtor\'s\nFees'
                    : 'Realtor\'s Fees',
                realtorsFeesString),
            MoneyListTile('Taxes', taxesString),
            MoneyTextField(
              labelText: 'Seller\'s Closing Costs',
              controller: sellersClosingCostsController,
              onChanged: (String newCost) {
                newCost = newCost.replaceAll(',', '');
                double? newValue = double.tryParse(newCost);
                if (newValue != null) {
                  ref
                      .read(fixFlipProvider)
                      .updateSellersClosingCosts(newValue);
                } else {
                  ref.read(fixFlipProvider).updateSellersClosingCosts(0.0);
                }
                ref.read(fixFlipProvider).calculateAllSellingCosts();
              },
            ),
            MoneyTextField(
              labelText: 'Buyer\'s Closing Costs',
              controller: buyersClosingCostsController,
              onChanged: (String newCost) {
                newCost = newCost.replaceAll(',', '');
                double? newValue = double.tryParse(newCost);
                if (newValue != null) {
                  ref
                      .read(fixFlipProvider)
                      .updateBuyersClosingCosts(newValue);
                } else {
                  ref.read(fixFlipProvider).updateBuyersClosingCosts(0.0);
                }
                ref.read(fixFlipProvider).calculateAllSellingCosts();
              },
            ),
            MoneyTextField(
              labelText: 'Other Closing Costs',
              controller: otherClosingCostsController,
              onChanged: (String newCost) {
                newCost = newCost.replaceAll(',', '');
                double? newValue = double.tryParse(newCost);
                if (newValue != null) {
                  ref.read(fixFlipProvider).updateOtherClosingCosts(newValue);
                } else {
                  ref.read(fixFlipProvider).updateOtherClosingCosts(0.0);
                }
                ref.read(fixFlipProvider).calculateAllSellingCosts();
              },
            ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            MoneyListTile(
                (MediaQuery.of(context).size.width < 640)
                    ? 'Total'
                    : context.isTablet
                        ? 'Total Closing Costs'
                        : 'Total \nClosing Costs',
                totalString),
          ],
        ),
      ),
    );
  }
}
