import 'package:calculators/globals.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/percent_text_field.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class FixAndFlipSellingCostsInput extends ConsumerWidget {
  const FixAndFlipSellingCostsInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double realtorsFees = ref.watch(propertyProvider).afterRepairValue *
        ref.watch(ffSellingCostsProvider).realtorFeesPercentage;

    int numberOfMonthsToRehabRent =
        ref.read(propertyProvider).monthsToRehabRent;
    double taxes = 0;
    if (numberOfMonthsToRehabRent != 0) {
      taxes = ref.watch(expensesProvider).taxes / numberOfMonthsToRehabRent;
    }
    double other = ref.watch(propertyProvider).afterRepairValue * 0.02;
    double total = ref.watch(ffSellingCostsProvider).totalClosingCosts;

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
      onSubmit: () {},
      child: ResponsiveLayout(
        children: [
          PercentTextField(
            labelText: 'Realtor\'s Fees',
            onChanged: (String newPercentage) {
              newPercentage = newPercentage.replaceAll(',', '');
              double? newValue = double.tryParse(newPercentage);
              if (newValue != null) {
                double realtorFeesPerecentage = newValue / 100;
                ref
                    .read(ffSellingCostsProvider)
                    .updateRealtorFeesPercentage(realtorFeesPerecentage);
                double afterRepairValue =
                    ref.read(propertyProvider).afterRepairValue;
                double realtorsFees = afterRepairValue * realtorFeesPerecentage;

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
            onChanged: (String newCost) {
              newCost = newCost.replaceAll(',', '');
              double? newValue = double.tryParse(newCost);
              if (newValue != null) {
                ref
                    .read(ffSellingCostsProvider)
                    .updateSellersClosingCosts(newValue);
                ref.read(ffSellingCostsProvider).updateTaxes(taxes);
                ref.read(ffSellingCostsProvider).updateOtherClosingCosts(other);
              } else {
                ref.read(ffSellingCostsProvider).updateSellersClosingCosts(0);
              }
            },
          ),
          MoneyTextField(
            labelText: 'Buyer\'s Closing Costs',
            onChanged: (String newCost) {
              newCost = newCost.replaceAll(',', '');
              double? newValue = double.tryParse(newCost);
              if (newValue != null) {
                ref
                    .read(ffSellingCostsProvider)
                    .updateBuyersClosingCosts(newValue);
                ref.read(ffSellingCostsProvider).updateTaxes(taxes);
                ref.read(ffSellingCostsProvider).updateOtherClosingCosts(other);
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
                      ? 'Total CLosing Costs'
                      : 'Total \nClosing Costs',
              totalString),
        ],
      ),
    );
  }
}
