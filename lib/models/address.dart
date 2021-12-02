// organizes all information for an address

import 'package:flutter/material.dart';

class Address extends ChangeNotifier{
  String street;
  String line2;
  String city;
  String state;
  String zip;
  String fullAddress;


  Address({required this.street, required this.line2, required this.city,
      required this.state, required this.zip, this.fullAddress = ''});

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

  void updateAddress(String newAddress) {
    fullAddress = newAddress;
    notifyListeners();
  }

  void reset() {
    street = line2 = city = state = zip = fullAddress = '';
    notifyListeners();
  }
}