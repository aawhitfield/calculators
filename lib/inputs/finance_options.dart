import 'package:calculators/globals.dart';
import 'package:calculators/models/financing_type.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';

class FinanceOptions extends StatefulWidget {
  const FinanceOptions({Key? key}) : super(key: key);

  @override
  State<FinanceOptions> createState() => _FinanceOptionsState();
}

class _FinanceOptionsState extends State<FinanceOptions> {
  FinancingType value = FinancingType.commercial;

  @override
  Widget build(BuildContext context) {
    return MyInputPage(
        imageUri: 'images/finance.svg',
        headerText: 'Finance Options',
        subheadText: '',
        onSubmit: () {},
        position: kResidentialREIQuestions.indexOf(FinanceOptions),
        totalQuestions: kResidentialREIQuestions.length,
        child: ResponsiveLayout(
          children: [
            Row(
              children: [
                const Text('Financing Type'),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButton<FinancingType>(
                    value: value,
                    items: FinancingType.values.map((FinancingType financingType)
                      => DropdownMenuItem<FinancingType>(
                          value: financingType,
                          child: Text(FinancingTypeUtils(financingType).name))).toList(),
                    onChanged: (FinancingType? newValue) {
                      setState(() {
                        value = newValue!;
                      });
                    },
                  ),
                )
              ],
            )
          ],
        ),
    );
  }
}
