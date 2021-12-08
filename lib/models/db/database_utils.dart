import 'package:calculators/models/db/property_db.dart';

class DatabaseUtils {

  static void deletePlaceByID(int id) {
    PropertyDatabase.instance.delete(id);
  }
}