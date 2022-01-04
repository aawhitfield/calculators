import 'package:calculators/models/calculator.dart';
import 'package:calculators/models/fix_flip_selling_costs.dart';
import 'package:calculators/models/quick_max_offer.dart';
import 'package:calculators/models/saved_calculator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/brrrr.dart';

final brrrrProvider = ChangeNotifierProvider<BRRRR>((ref) => BRRRR(
      address: '',//Address(street: '', line2: '', city: '', state: '', zip: ''),
      listPrice: 0,
    ));

final calculatorProvider = ChangeNotifierProvider<CurrentCalculator>(
    (ref) => CurrentCalculator(),
);

final ffSellingCostsProvider = ChangeNotifierProvider<FixFlipSellingCosts>(
    (ref) => FixFlipSellingCosts(),
);

final savedCalculatorProvider = ChangeNotifierProvider<SavedCalculator>(
    (ref) => SavedCalculator(address: '', calculatorType: 'BRRRR', uid: ''),
);

final quickMaxProvider = ChangeNotifierProvider<QuickMaxOffer>(
    (ref) => QuickMaxOffer(),
);

void resetAllData(WidgetRef ref) {
  ref.read(brrrrProvider).reset();
  ref.read(quickMaxProvider).reset();
  ref.read(ffSellingCostsProvider).reset();
}
