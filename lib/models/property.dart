// organizes all information for a property

import 'package:calculators/models/address.dart';
import 'package:flutter/material.dart';

class Property extends ChangeNotifier{
  Address address;
  double listPrice;

  Property({required this.address, required this.listPrice});

  void updateAddress(Address newAddress) {
    address = newAddress;
    notifyListeners();
  }

  void updateListPrice(double newListPrice) {
    listPrice = newListPrice;
    notifyListeners();
  }
}