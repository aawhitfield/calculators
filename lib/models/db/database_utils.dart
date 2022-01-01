import 'package:calculators/models/calculator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DatabaseUtils {
  static void deletePlaceByID(int id) {
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

  static Future<void> saveDataToDatabase({required String uid, String? docID, required Map<String, dynamic> data}) async {

    await FirebaseFirestore.instance.collection('users').doc(uid)
      .collection('calculators')
      .doc((docID))
      .set(data, SetOptions(merge: true));



  }
}
