import 'package:calculators/globals.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/integer_text_field.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PropertyCosts extends ConsumerStatefulWidget {
  const PropertyCosts({Key? key}) : super(key: key);

  @override
  PropertyCostsState createState() => PropertyCostsState();
}

class PropertyCostsState extends ConsumerState<PropertyCosts> {
  TextEditingController listPriceController = TextEditingController();
  TextEditingController renovationsController = TextEditingController();

  @override
  void initState() {
    listPriceController.text = kCurrencyFormat.format(ref.read(propertyProvider)
        .listPrice).toString();
    renovationsController.text = kCurrencyFormat.format(ref.read(renovationsProvider)
        .total).toString();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return MyInputPage(
        imageUri: 'images/property.svg',
        headerText: 'Property Costs',
        subheadText: 'Now let\'s get some information about costs associated '
            'with this property.',
        onSubmit: () {},
        position: kResidentialREIQuestions.indexOf(PropertyCosts) + 1,
        totalQuestions: kResidentialREIQuestions.length,
        child: ResponsiveLayout(
          children: [
            MoneyTextField(
                labelText: 'List Price',
                controller: listPriceController,
                onChanged: (String newListPrice) {
                  newListPrice = newListPrice.replaceAll(',', '');
                  double? listPrice = double.tryParse(newListPrice);
                  if (listPrice != null) {
                    ref.read(propertyProvider).updateListPrice(listPrice);
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
                    ref.read(renovationsProvider).updateTotal(total);
                  }
                },
            ),
            MoneyTextField(
                labelText: 'After Repair Price',
                onChanged: (String newPrice) {
                  newPrice = newPrice.replaceAll(',', '');
                  double? price = double.tryParse(newPrice);
                  if(price != null) {
                    ref.read(propertyProvider).updateAfterRepairValue(price);
                  }
                }
            ),
            MoneyTextField(
                labelText: 'Purchase Price',
                onChanged: (String newPrice) {
                  newPrice = newPrice.replaceAll(',', '');
                  double? price = double.tryParse(newPrice);
                  if(price != null) {
                    ref.read(propertyProvider).updatePurchasePrice(price);
                  }
                }
            ),
            IntegerTextField(
                labelText: 'Months to Rehab\/Rent',
                onChanged: (String newValue) {
                  int? value = int.tryParse(newValue);
                  if(value != null) {
                    ref.read(propertyProvider).updateMonthsToRehabRent(value);
                  }
                }),
            IntegerTextField(
                labelText: 'Units',
                onChanged: (String newValue) {
                  int? value = int.tryParse(newValue);
                  if(value != null) {
                    ref.read(propertyProvider).updateUnits(value);
                  }
                }),
            IntegerTextField(
                labelText: 'Investors',
                onChanged: (String newValue) {
                  int? value = int.tryParse(newValue);
                  if(value != null) {
                    ref.read(propertyProvider).updateInvestors(value);
                  }
                }),
          ],),
    );
  }
}
