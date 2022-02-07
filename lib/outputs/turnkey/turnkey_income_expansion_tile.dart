import 'package:calculators/globals.dart';
import 'package:calculators/models/turnkey_rental_type.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TurnkeyIncomeExpansionTile extends ConsumerStatefulWidget {
  const TurnkeyIncomeExpansionTile({
    Key? key,
  }) : super(key: key);

  @override
  _IncomeExpansionTileState createState() => _IncomeExpansionTileState();
}

class _IncomeExpansionTileState extends ConsumerState<TurnkeyIncomeExpansionTile> {
  TextEditingController rentIncomeController = TextEditingController();
  TextEditingController otherIncomeController = TextEditingController();

  late double rentIncome;
  late double otherIncome;

  @override
  void initState() {
    rentIncome = ref.read(turnkeyProvider).rent;
    if (rentIncome != 0) {
      rentIncomeController.text = kCurrencyFormat.format(rentIncome);
    }
    otherIncome = ref.read(turnkeyProvider).otherIncome;
    if (otherIncome != 0) {
      otherIncomeController.text = kCurrencyFormat.format(otherIncome);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TurnkeyRental provider = ref.watch(turnkeyProvider);
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
              ref.read(turnkeyProvider).updateRent(newIncome);
            } else {
              ref.read(turnkeyProvider).updateRent(0.0);
            }
            ref.read(turnkeyProvider).calculateAll();
          },
        ),
        MoneyTextField(
          controller: otherIncomeController,
          labelText: 'Other Income',
          onChanged: (String newValue) {
            newValue = newValue.replaceAll(',', '');
            double? newIncome = double.tryParse(newValue);
            if (newIncome != null) {
              ref.read(turnkeyProvider).updateOtherIncome(newIncome);
            } else {
              ref.read(turnkeyProvider).updateOtherIncome(0.0);
            }
            ref.read(turnkeyProvider).calculateAll();
          },
        ),
      ],
    );
  }
}
