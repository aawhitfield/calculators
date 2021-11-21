// organizes all information for a property

import 'package:calculators/models/address.dart';
import 'package:flutter/material.dart';

class Property extends ChangeNotifier{
  Address address;
  double listPrice;
  int? sqft;

  Property({required this.address, required this.listPrice, this.sqft});

  void updateAddress(Address newAddress) {
    address = newAddress;
    notifyListeners();
  }

  void updateListPrice(double newListPrice) {
    listPrice = newListPrice;
    notifyListeners();
  }

  void updateSqft(int newSqft) {
    sqft = newSqft;
    notifyListeners();
  }
}