import 'package:calculators/models/calculator.dart';
import 'package:calculators/models/db/ff_selling_cost_db.dart';
import 'package:calculators/models/db/refinance_db.dart';
import 'package:calculators/models/fix_flip_selling_costs.dart';
import 'package:calculators/models/brrrr.dart';
import 'package:calculators/models/refinance.dart';
import 'package:calculators/providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DatabaseUtils {
  static void deletePlaceByID(int id) {
    RefinanceDatabase.instance.delete(id);
    SellingCostDatabase.instance.delete(id);
  }

  static Future<Calculator> loadDataByID(int id, WidgetRef ref) async {
    // BRRRR savedProperty = await PropertyDatabase.instance.readProperty(id);
    // Renovation savedRenovation =
    //     await RenovationsDatabase.instance.readRenovation(id);
    // Income savedIncome = await IncomeDatabase.instance.readIncome(id);
    // Expenses savedExpenses = await ExpensesDatabase.instance.readExpenses(id);
    // FinanceOptionData savedFinanceOptions = await FinanceDatabase.instance.readFinanceOption(id);
    // FinanceOptionConstructionProvider savedFinanceConstruction = await FinanceConstructionDatabase.instance.readFinanceOption(id);
    // Options savedOptions = await OptionsDatabase.instance.readOptions(id);
    // SellerFinanceOptionData savedSellerFinanceData = await SellerFinanceDatabase.instance.readFinanceOption(id);
    // RefinanceOptions savedRefinanceData = await RefinanceDatabase.instance.readFinanceOption(id);
    // FixFlipSellingCosts sellingCostsData = await SellingCostDatabase.instance.readFinanceOption(id);
    //
    // ref.read(brrrrProvider).updateProperty(savedProperty);
    // ref.read(renovationsProvider).updateRenovation(savedRenovation);
    // ref.read(incomeProvider).updateIncome(savedIncome);
    // ref.read(brrrrProvider).updateExpenses(savedExpenses);
    // ref.read(brrrrProvider).updateFinanceOptionData(savedFinanceOptions);
    // ref.read(financeConstructionProvider).updateFinanceOptionConstruction(savedFinanceConstruction);
    // ref.read(optionsProvider).updateOptions(savedOptions);
    // ref.read(sellerFinanceProvider).updateSellerFinanceOptionData(savedSellerFinanceData);
    // ref.read(refinanceProvider).updateRefinanceData(savedRefinanceData);
    // ref.read(ffSellingCostsProvider).updateFixFlipSellingCostsData(sellingCostsData);
    //
    return Calculator.brrrr;//savedProperty.calculator;
  }

  static Future<void> saveDataToDatabase(WidgetRef ref, {String uid = '', String? docID}) async {
    // create property
    BRRRR property = ref.read(brrrrProvider);
    RefinanceOptions refinanceData = ref.read(refinanceProvider);
    FixFlipSellingCosts sellingCostsData = ref.read(ffSellingCostsProvider);

    // property = await PropertyDatabase.instance.create(property);
    // renovation = await RenovationsDatabase.instance.create(renovation);
    // income = await IncomeDatabase.instance.create(income);
    // expenses = await ExpensesDatabase.instance.create(expenses);
    // financeOptionData = await FinanceDatabase.instance.create(financeOptionData);
    // financeConstructionData = await FinanceConstructionDatabase.instance.create(financeConstructionData);
    // optionsData = await OptionsDatabase.instance.create(optionsData);
    // sellerFinanceOptionData = await SellerFinanceDatabase.instance.create(sellerFinanceOptionData);
    // refinanceData = await RefinanceDatabase.instance.create(refinanceData);
    // sellingCostsData = await SellingCostDatabase.instance.create(sellingCostsData);

    Map<String, dynamic> data = {
      ...property.toJson(),
      ...refinanceData.toJson(),
      ...sellingCostsData.toJson(),
    };

    await FirebaseFirestore.instance.collection('users').doc(uid)
      .collection('calculators')
      .doc((docID))
      .set(data, SetOptions(merge: true));



  }
}
