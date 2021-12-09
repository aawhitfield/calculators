import 'package:calculators/models/calculator.dart';
import 'package:calculators/models/db/income_db.dart';
import 'package:calculators/models/db/property_db.dart';
import 'package:calculators/models/db/renovations_db.dart';
import 'package:calculators/models/income.dart';
import 'package:calculators/models/property.dart';
import 'package:calculators/models/renovations.dart';
import 'package:calculators/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DatabaseUtils {
  static void deletePlaceByID(int id) {
    PropertyDatabase.instance.delete(id);
    RenovationsDatabase.instance.delete(id);
    IncomeDatabase.instance.delete(id);
  }

  static Future<Calculator> loadDataByID(int id, WidgetRef ref) async {
    Property savedProperty = await PropertyDatabase.instance.readProperty(id);
    Renovation savedRenovation =
        await RenovationsDatabase.instance.readRenovation(id);
    Income savedIncome = await IncomeDatabase.instance.readIncome(id);

    ref.read(propertyProvider).updateProperty(savedProperty);
    ref.read(renovationsProvider).updateRenovation(savedRenovation);
    ref.read(incomeProvider).updateIncome(savedIncome);

    return savedProperty.calculator;
  }

  static Future<void> saveDataToDatabase(WidgetRef ref) async {
    // create property
    Property property = ref.read(propertyProvider);
    Renovation renovation = ref.read(renovationsProvider);
    Income income = ref.read(incomeProvider);

    property = await PropertyDatabase.instance.create(property);
    renovation = await RenovationsDatabase.instance.create(renovation);
    income = await IncomeDatabase.instance.create(income);

  }
}
