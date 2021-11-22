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

  Renovation({this.foundation = 0, this.roof = 0, this.airConditioner = 0,
    this.paintingPatching = 0, this.kitchen = 0, this.windows = 0,
    this. plumbing = 0, this.flooring = 0, this.bathrooms = 0,
    this.appliances = 0, this.electrical = 0, this.yard = 0, this.cleaning = 0,
    this.baseboards = 0, this.exterior = 0, this.demo = 0, this.elevators = 0,
    this.build28Units = 0, this.other = 0, this.total = 0,
  });

  void updateTotal(double newTotal) {
    total = newTotal;
    notifyListeners();
  }

  double calculateTotal() {
    total = foundation + roof + airConditioner + paintingPatching + kitchen
        + windows + plumbing + flooring + bathrooms + appliances + electrical
        + yard + cleaning + baseboards + exterior + demo + elevators + build28Units
        + other;
    notifyListeners();
    return total;
  }

  void updateFoundation(double newFoundation) {
    foundation = newFoundation;
    notifyListeners();
  }

  void updateRoof(double newRoof) {
    roof = newRoof;
    notifyListeners();
  }

  void updateAirConditioner(double newAirConditioner) {
    airConditioner = newAirConditioner;
    notifyListeners();
  }

  void updatePaintingPatching (double newPainting) {
    paintingPatching = newPainting;
    notifyListeners();
  }

  void updateKitchen(double newKitchen) {
    kitchen = newKitchen;
    notifyListeners();
  }

  void updateWindows (double newWindows) {
    windows = newWindows;
    notifyListeners();
  }

  void updatePlumbing(double newPlumbing) {
    plumbing = newPlumbing;
    notifyListeners();
  }

  void updateFlooring(double newFlooring) {
    flooring = newFlooring;
    notifyListeners();
  }

  void updateBathrooms(double newBathrooms) {
    bathrooms = newBathrooms;
    notifyListeners();
  }

  void updateAppliances(double newAppliances) {
    appliances = newAppliances;
    notifyListeners();
  }

  void updateElectrical(double newElectrical) {
    electrical = newElectrical;
    notifyListeners();
  }

  void updateYard(double newYard) {
    yard = newYard;
    notifyListeners();
  }

  void updateCleaning(double newCleaning) {
    cleaning = newCleaning;
    notifyListeners();
  }

  void updateBaseboards(double newBaseboards) {
    baseboards = newBaseboards;
    notifyListeners();
  }

  void updateExterior(double newExterior) {
    exterior = newExterior;
    notifyListeners();
  }

  void updateDemo(double newDemo) {
    demo = newDemo;
    notifyListeners();
  }

  void updateElevators(double newElevators) {
    elevators = newElevators;
    notifyListeners();
  }

  void updateBuildUnits(double newBuildUnits) {
    build28Units = newBuildUnits;
    notifyListeners();
  }

  void updateOther(double newOther) {
    other = newOther;
    notifyListeners();
  }

}