// organizes all information for an address

import 'package:flutter/material.dart';

class Address extends ChangeNotifier{
  String street;
  String line2;
  String city;
  String state;
  String zip;
  int? sqft;

  Address({required this.street, required this.line2, required this.city,
      required this.state, required this.zip, this.sqft});

  void updateStreet(String newStreet) {
    street = newStreet;
    notifyListeners();
  }

  void updateLine2(String newLine2) {
    line2 = newLine2;
    notifyListeners();
  }

  void updateCity(String newCity) {
    city = newCity;
    notifyListeners();
  }

  void updateState(String newState) {
    state = newState;
    notifyListeners();
  }

  void updateZip(String newZip) {
    zip = newZip;
    notifyListeners();
  }

  void updateSqrt(int newSqft) {
    sqft = newSqft;
    notifyListeners();
  }
}