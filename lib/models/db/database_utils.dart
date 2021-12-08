import 'package:calculators/models/calculator.dart';
import 'package:calculators/models/db/property_db.dart';
import 'package:calculators/models/db/renovations_db.dart';
import 'package:calculators/models/property.dart';
import 'package:calculators/models/renovations.dart';
import 'package:calculators/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DatabaseUtils {

  static void deletePlaceByID(int id) {
    PropertyDatabase.instance.delete(id);
    RenovationsDatabase.instance.delete(id);
  }

  static Future<Calculator> loadDataByID(int id, WidgetRef ref) async {
    Property savedProperty =
        await PropertyDatabase.instance
        .readProperty(id);
    Renovation savedRenovation =
        await RenovationsDatabase.instance.readRenovation(id);
    ref
        .read(propertyProvider)
        .updateProperty(savedProperty);
    ref.read(renovationsProvider)
        .updateRenovation(savedRenovation);

    return savedProperty.calculator;
  }
}