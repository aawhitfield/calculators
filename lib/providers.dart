import 'package:calculators/models/expenses.dart';
import 'package:calculators/models/financing_option_construction_provider.dart';
import 'package:calculators/models/financing_type.dart';
import 'package:calculators/models/income.dart';
import 'package:calculators/models/options.dart';
import 'package:calculators/models/renovations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/address.dart';
import 'models/property.dart';

final addressProvider = ChangeNotifierProvider<Address>(
    (ref) => Address(street: '', line2: '', city: '', state: '', zip: ''));

final propertyProvider = ChangeNotifierProvider<Property>((ref) => Property(
      address: Address(street: '', line2: '', city: '', state: '', zip: ''),
      listPrice: 0,
    ));

final renovationsProvider = ChangeNotifierProvider<Renovation>(
  (ref) => Renovation(),
);

final incomeProvider = ChangeNotifierProvider<Income>(
  (ref) => Income(),
);

final financeProvider = ChangeNotifierProvider<FinanceOptionData>(
  (ref) => FinanceOptionData(),
);

final expensesProvider = ChangeNotifierProvider<Expenses>(
  (ref) => Expenses(),
);

final financeConstructionProvider =
    ChangeNotifierProvider<FinanceOptionConstructionProvider>(
  (ref) => FinanceOptionConstructionProvider(),
);


final optionsProvider =
ChangeNotifierProvider<Options>(
      (ref) => Options(),
);
