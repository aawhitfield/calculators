import 'package:calculators/globals.dart';
import 'package:calculators/outputs/report.dart';
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

  late double sellersClosingCosts;
  late double buyersClosingCosts;

  @override
  void initState() {
    double realtorsFeesDecimal = ref.read(ffSellingCostsProvider).realtorFeesPercentage;
    double realtorsFeesPercentage = realtorsFeesDecimal * 100;
    if(realtorsFeesPercentage != 0) {
      realtorsFeesController.text = kWholeNumber.format(realtorsFeesPercentage);
    }

    sellersClosingCosts = ref.read(ffSellingCostsProvider).sellersClosingCosts;
    if (sellersClosingCosts != 0) {
      sellersClosingCostsController.text = kCurrencyFormat.format(sellersClosingCosts);
    }

    buyersClosingCosts = ref.read(ffSellingCostsProvider).buyersClosingCosts;
    if (buyersClosingCosts != 0) {
      buyersClosingCostsController.text = kCurrencyFormat.format(buyersClosingCosts);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double realtorsFees = ref.watch(brrrrProvider).afterRepairValue *
        ref.watch(ffSellingCostsProvider).realtorFeesPercentage;

    int numberOfMonthsToRehabRent =
        ref.read(brrrrProvider).monthsToRehabRent;
    double taxes = ref.watch(brrrrProvider).taxesYearly;
    if (numberOfMonthsToRehabRent != 0) {
      taxes = taxes / numberOfMonthsToRehabRent;
    }
    double other = ref.watch(brrrrProvider).afterRepairValue * 0.02;
    double total = realtorsFees + taxes + sellersClosingCosts + buyersClosingCosts + other;
    total = ref.watch(ffSellingCostsProvider).totalClosingCosts;

    String taxesString = kCurrencyFormat.format(taxes);
    String realtorsFeesString = kCurrencyFormat.format(realtorsFees);
    String otherString = kCurrencyFormat.format(other);
    String totalString = kCurrencyFormat.format(total);

    return MyInputPage(
      imageUri: 'images/transfer.svg',
      headerText: 'Fix and Flip',
      subheadText: 'Selling Costs',
      position:
          kResidentialREIQuestions.indexOf(FixAndFlipSellingCostsInput) + 1,
      totalQuestions: kResidentialREIQuestions.length,
      onSubmit: () {
        ref.read(ffSellingCostsProvider).calculateTotal();
        Get.to(() => const Report());
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
                    .read(ffSellingCostsProvider)
                    .updateRealtorFeesPercentage(realtorFeesPercentage);
                double afterRepairValue =
                    ref.read(brrrrProvider).afterRepairValue;
                double realtorsFees = afterRepairValue * realtorFeesPercentage;

                ref
                    .read(ffSellingCostsProvider)
                    .updateRealtorFees(realtorsFees);
                ref.read(ffSellingCostsProvider).updateTaxes(taxes);
                ref.read(ffSellingCostsProvider).updateOtherClosingCosts(other);
              } else {
                ref.read(ffSellingCostsProvider).updateRealtorFeesPercentage(0);
                ref.read(ffSellingCostsProvider).updateRealtorFees(0);
              }
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
                    .read(ffSellingCostsProvider)
                    .updateSellersClosingCosts(newValue);
                ref.read(ffSellingCostsProvider).updateTaxes(taxes);
                ref.read(ffSellingCostsProvider).updateOtherClosingCosts(other);
                ref.read(ffSellingCostsProvider).calculateTotal();
              } else {
                ref.read(ffSellingCostsProvider).updateSellersClosingCosts(0);
              }
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
                    .read(ffSellingCostsProvider)
                    .updateBuyersClosingCosts(newValue);
                ref.read(ffSellingCostsProvider).updateTaxes(taxes);
                ref.read(ffSellingCostsProvider).updateOtherClosingCosts(other);
                ref.read(ffSellingCostsProvider).calculateTotal();
              } else {
                ref.read(ffSellingCostsProvider).updateBuyersClosingCosts(0);
              }
            },
          ),
          MoneyListTile(
              (MediaQuery.of(context).size.width < 640)
                  ? 'Other'
                  : context.isTablet
                      ? 'Other Closing Costs'
                      : 'Other\nClosing Costs',
              otherString),
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
    );
  }
}
