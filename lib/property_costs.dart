import 'package:calculators/globals.dart';
import 'package:calculators/providers.dart';
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

  @override
  void initState() {
    listPriceController.text = kCurrencyFormat.format(ref.read(propertyProvider)
        .listPrice).toString();
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
          ],),
    );
  }
}
