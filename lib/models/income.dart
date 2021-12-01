import 'package:flutter/foundation.dart';

class Income extends ChangeNotifier {
  double rent;
  double other;
  double total;

  Income({this.rent = 0, this.other = 0, this.total = 0});

  void updateRent(double newValue) {
    rent = newValue;
    notifyListeners();
  }

  void updateOther(double newValue) {
    other = newValue;
    notifyListeners();
  }

  void calculateTotal() {
    total = rent + other;
    notifyListeners();
  }

  void reset() {
    rent = other = total = 0;
    notifyListeners();
  }
}