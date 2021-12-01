import 'package:flutter/material.dart';

class Renovation extends ChangeNotifier{
  double foundation;
  double roof;
  double airConditioner;
  double paintingPatching;
  double kitchen;
  double windows;
  double plumbing;
  double flooring;
  double bathrooms;
  double appliances;
  double electrical;
  double yard;
  double cleaning;
  double baseboards;
  double exterior;
  double demo;
  double elevators;
  double build28Units;
  double other;
  double total;
  double tenPercentExtra;

  Renovation({this.foundation = 0, this.roof = 0, this.airConditioner = 0,
    this.paintingPatching = 0, this.kitchen = 0, this.windows = 0,
    this. plumbing = 0, this.flooring = 0, this.bathrooms = 0,
    this.appliances = 0, this.electrical = 0, this.yard = 0, this.cleaning = 0,
    this.baseboards = 0, this.exterior = 0, this.demo = 0, this.elevators = 0,
    this.build28Units = 0, this.other = 0, this.total = 0, this.tenPercentExtra = 0,
  });

  void updateTotal(double newTotal) {
    total = newTotal;
    notifyListeners();
  }

  double calculateTotal() {
    total = foundation + roof + airConditioner + paintingPatching + kitchen
        + windows + plumbing + flooring + bathrooms + appliances + electrical
        + yard + cleaning + baseboards + exterior + demo + elevators + build28Units
        + other + tenPercentExtra;
    notifyListeners();
    return total;
  }

  double calculateTenPercentExtra() {
    double subtotal = foundation + roof + airConditioner + paintingPatching + kitchen
        + windows + plumbing + flooring + bathrooms + appliances + electrical
        + yard + cleaning + baseboards + exterior + demo + elevators + build28Units
        + other;
    tenPercentExtra = subtotal * 0.1;
    notifyListeners();
    return tenPercentExtra;
  }

  void updateFoundation(double newFoundation) {
    foundation = newFoundation;
    calculateTenPercentExtra();
    calculateTotal();
    notifyListeners();
  }

  void updateRoof(double newRoof) {
    roof = newRoof;
    calculateTenPercentExtra();
    calculateTotal();
    notifyListeners();
  }

  void updateAirConditioner(double newAirConditioner) {
    airConditioner = newAirConditioner;
    calculateTenPercentExtra();
    calculateTotal();
    notifyListeners();
  }

  void updatePaintingPatching (double newPainting) {
    paintingPatching = newPainting;
    calculateTenPercentExtra();
    calculateTotal();
    notifyListeners();
  }

  void updateKitchen(double newKitchen) {
    kitchen = newKitchen;
    calculateTenPercentExtra();
    calculateTotal();
    notifyListeners();
  }

  void updateWindows (double newWindows) {
    windows = newWindows;
    calculateTenPercentExtra();
    calculateTotal();
    notifyListeners();
  }

  void updatePlumbing(double newPlumbing) {
    plumbing = newPlumbing;
    calculateTenPercentExtra();
    calculateTotal();
    notifyListeners();
  }

  void updateFlooring(double newFlooring) {
    flooring = newFlooring;
    calculateTenPercentExtra();
    calculateTotal();
    notifyListeners();
  }

  void updateBathrooms(double newBathrooms) {
    bathrooms = newBathrooms;
    calculateTenPercentExtra();
    calculateTotal();
    notifyListeners();
  }

  void updateAppliances(double newAppliances) {
    appliances = newAppliances;
    calculateTenPercentExtra();
    calculateTotal();
    notifyListeners();
  }

  void updateElectrical(double newElectrical) {
    electrical = newElectrical;
    calculateTenPercentExtra();
    calculateTotal();
    notifyListeners();
  }

  void updateYard(double newYard) {
    yard = newYard;
    calculateTenPercentExtra();
    calculateTotal();
    notifyListeners();
  }

  void updateCleaning(double newCleaning) {
    cleaning = newCleaning;
    calculateTenPercentExtra();
    calculateTotal();
    notifyListeners();
  }

  void updateBaseboards(double newBaseboards) {
    baseboards = newBaseboards;
    calculateTenPercentExtra();
    calculateTotal();
    notifyListeners();
  }

  void updateExterior(double newExterior) {
    exterior = newExterior;
    calculateTenPercentExtra();
    calculateTotal();
    notifyListeners();
  }

  void updateDemo(double newDemo) {
    demo = newDemo;
    calculateTenPercentExtra();
    calculateTotal();
    notifyListeners();
  }

  void updateElevators(double newElevators) {
    elevators = newElevators;
    calculateTenPercentExtra();
    calculateTotal();
    notifyListeners();
  }

  void updateBuildUnits(double newBuildUnits) {
    build28Units = newBuildUnits;
    calculateTenPercentExtra();
    calculateTotal();
    notifyListeners();
  }

  void updateOther(double newOther) {
    other = newOther;
    calculateTenPercentExtra();
    calculateTotal();
    notifyListeners();
  }

  void reset() {
    foundation = roof = airConditioner = paintingPatching = kitchen = windows
      = plumbing = flooring = bathrooms = appliances = electrical = yard
      = cleaning = baseboards = exterior = demo = elevators = build28Units
      = other = total = tenPercentExtra = 0;
    notifyListeners();
  }
}