import 'package:calculators/models/calculator.dart';
import 'package:calculators/models/financing_option_construction_provider.dart';
import 'package:calculators/models/fix_flip_selling_costs.dart';
import 'package:calculators/models/seller_financing_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/brrrr.dart';
import 'models/refinance.dart';

final brrrrProvider = ChangeNotifierProvider<BRRRR>((ref) => BRRRR(
      address: '',//Address(street: '', line2: '', city: '', state: '', zip: ''),
      listPrice: 0,
    ));

final sellerFinanceProvider = ChangeNotifierProvider<SellerFinanceOptionData>(
      (ref) => SellerFinanceOptionData(),
);

final refinanceProvider = ChangeNotifierProvider<RefinanceOptions>(
      (ref) => RefinanceOptions(),
);

final financeConstructionProvider =
    ChangeNotifierProvider<FinanceOptionConstructionProvider>(
  (ref) => FinanceOptionConstructionProvider(),
);


final calculatorProvider = ChangeNotifierProvider<CurrentCalculator>(
    (ref) => CurrentCalculator(),
);

final ffSellingCostsProvider = ChangeNotifierProvider<FixFlipSellingCosts>(
    (ref) => FixFlipSellingCosts(),
);

void resetAllData(WidgetRef ref) {
  ref.read(brrrrProvider).reset();
  ref.read(financeConstructionProvider).reset();
  ref.read(brrrrProvider).reset();
  ref.read(refinanceProvider).reset();
  ref.read(sellerFinanceProvider).reset();
  ref.read(ffSellingCostsProvider).reset();
}
