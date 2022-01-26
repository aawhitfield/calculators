import 'package:calculators/globals.dart';
import 'package:calculators/models/brrrr.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncomeExpansionTile extends ConsumerStatefulWidget {
  const IncomeExpansionTile({
    Key? key,
  }) : super(key: key);

  @override
  _IncomeExpansionTileState createState() => _IncomeExpansionTileState();
}

class _IncomeExpansionTileState extends ConsumerState<IncomeExpansionTile> {
  TextEditingController rentIncomeController = TextEditingController();
  TextEditingController otherIncomeController = TextEditingController();

  late double rentIncome;
  late double otherIncome;

  @override
  void initState() {
    rentIncome = ref.read(brrrrProvider).rent;
    if (rentIncome != 0) {
      rentIncomeController.text = kCurrencyFormat.format(rentIncome);
    }
    otherIncome = ref.read(brrrrProvider).otherIncome;
    if (otherIncome != 0) {
      otherIncomeController.text = kCurrencyFormat.format(otherIncome);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BRRRR provider = ref.watch(brrrrProvider);
    double income = provider.totalIncome;

    String incomeString = kCurrencyFormat.format(income);
    return ExpansionTile(
      leading: Text(
        'Income',
        style: Theme.of(context).textTheme.headline6,
      ),
      title: Text(
        '\$ $incomeString',
        style: Theme.of(context).textTheme.headline5,
      ),
      children: [
        MoneyTextField(
          controller: rentIncomeController,
          labelText: 'Rent',
          onChanged: (String newValue) {
            newValue = newValue.replaceAll(',', '');
            double? newIncome = double.tryParse(newValue);
            if (newIncome != null) {
              ref.read(brrrrProvider).updateRent(newIncome);
            } else {
              ref.read(brrrrProvider).updateRent(0.0);
            }
            ref.read(brrrrProvider).calculateAll();
          },
        ),
        MoneyTextField(
          controller: otherIncomeController,
          labelText: 'Other Income',
          onChanged: (String newValue) {
            newValue = newValue.replaceAll(',', '');
            double? newIncome = double.tryParse(newValue);
            if (newIncome != null) {
              ref.read(brrrrProvider).updateOtherIncome(newIncome);
            } else {
              ref.read(brrrrProvider).updateOtherIncome(0.0);
            }
            ref.read(brrrrProvider).calculateAll();
          },
        ),
      ],
    );
  }
}
