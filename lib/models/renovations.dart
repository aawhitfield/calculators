import 'package:flutter/material.dart';

const String tableRenovations = 'renovations';

class RenovationFields {
  static final List<String> values = [
    id, foundation, roof, airConditioner, painting, kitchen, windows, plumbing,
    flooring, bathrooms, appliances, electrical, yard, cleaning, baseboards, exterior,
    demo, elevators, build28, other, tenPercent, total
  ];

  static const String id = '_id';
  static const String foundation = 'foundation';
  static const String roof = 'roof';
  static const String airConditioner = 'airConditioner';
  static const String painting = 'painting';
  static const String kitchen = 'kitchen';
  static const String windows = 'windows';
  static const String plumbing = 'plumbing';
  static const String flooring = 'flooring';
  static const String bathrooms = 'bathrooms';
  static const String appliances = 'appliances';
  static const String electrical = 'electrical';
  static const String yard = 'yard';
  static const String cleaning = 'cleaning';
  static const String baseboards = 'baseboards';
  static const String exterior = 'exterior';
  static const String demo = 'demo';
  static const String elevators = 'elevators';
  static const String build28 = 'build28';
  static const String other = 'other';
  static const String tenPercent = 'tenPercent';
  static const String total = 'total';
}

class Renovation extends ChangeNotifier{
  int? id;
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
    this.id,
  });

  Map<String, Object?> toJson() => {
    RenovationFields.id: id,
    RenovationFields.foundation: foundation,
    RenovationFields.roof: roof,
    RenovationFields.airConditioner: airConditioner,
    RenovationFields.painting: paintingPatching,
    RenovationFields.kitchen: kitchen,
    RenovationFields.windows: windows,
    RenovationFields.plumbing: plumbing,
    RenovationFields.flooring: flooring,
    RenovationFields.bathrooms: bathrooms,
    RenovationFields.appliances: appliances,
    RenovationFields.electrical: electrical,
    RenovationFields.yard: yard,
    RenovationFields.cleaning: cleaning,
    RenovationFields.baseboards: baseboards,
    RenovationFields.exterior: exterior,
    RenovationFields.demo: demo,
    RenovationFields.elevators: elevators,
    RenovationFields.build28: build28Units,
    RenovationFields.other: other,
    RenovationFields.tenPercent: tenPercentExtra,
    RenovationFields.total: total,
  };

  Renovation copy({
    int? id,
    double? foundation,
    double? roof,
    double? airConditioner,
    double? paintingPatching,
    double? kitchen,
    double? windows,
    double? plumbing,
    double? flooring,
    double? bathrooms,
    double? appliances,
    double? electrical,
    double? yard,
    double? cleaning,
    double? baseboards,
    double? exterior,
    double? demo,
    double? elevators,
    double? build28Units,
    double? other,
    double? total,
    double? tenPercentExtra,
  }) => Renovation(
      id: id ?? this.id,
      foundation:  foundation ?? this.foundation,
      roof: roof ?? this.roof,
      airConditioner: airConditioner ?? this.airConditioner,
      paintingPatching: paintingPatching ?? this.paintingPatching,
      kitchen: kitchen ?? this.kitchen,
      windows:  windows ?? this.windows,
      plumbing: plumbing ?? this.plumbing,
      flooring: flooring ?? this.flooring,
      bathrooms: bathrooms ?? this.bathrooms,
      appliances: appliances ?? this.appliances,
      electrical: electrical ?? this.electrical,
      yard: yard ?? this.yard,
      cleaning: cleaning ?? this.cleaning,
      baseboards: baseboards ?? this.baseboards,
      exterior: exterior ?? this.exterior,
      demo: demo ?? this.demo,
      elevators: elevators ?? this.elevators,
      build28Units: build28Units ?? this.build28Units,
      other: other ?? this.other,
      tenPercentExtra: tenPercentExtra ?? this.tenPercentExtra,
      total: total ?? this.total,
  );

  static Renovation fromJson(Map<String, Object?> json) => Renovation(
    id: json[RenovationFields.id] as int?,
    foundation: json[RenovationFields.foundation] as double,
    roof: json[RenovationFields.roof] as double,
    airConditioner: json[RenovationFields.airConditioner] as double,
    paintingPatching: json[RenovationFields.painting] as double,
    kitchen: json[RenovationFields.kitchen] as double,
    windows: json[RenovationFields.windows] as double,
    plumbing: json[RenovationFields.plumbing] as double,
    flooring: json[RenovationFields.flooring] as double,
    bathrooms: json[RenovationFields.bathrooms] as double,
    appliances: json[RenovationFields.appliances] as double,
    electrical: json[RenovationFields.electrical] as double,
    yard: json[RenovationFields.yard] as double,
    cleaning: json[RenovationFields.cleaning] as double,
    baseboards: json[RenovationFields.baseboards] as double,
    exterior: json[RenovationFields.exterior] as double,
    demo: json[RenovationFields.demo] as double,
    elevators: json[RenovationFields.elevators] as double,
    build28Units: json[RenovationFields.build28] as double,
    other: json[RenovationFields.other] as double,
    tenPercentExtra: json[RenovationFields.tenPercent] as double,
    total: json[RenovationFields.total] as double,
  );
  
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

  void updateRenovation(Renovation newRenovation) {
    id = newRenovation.id;
    foundation = newRenovation.foundation;
    roof = newRenovation.roof;
    airConditioner = newRenovation.airConditioner;
    paintingPatching = newRenovation.paintingPatching;
    kitchen = newRenovation.kitchen;
    windows = newRenovation.windows;
    plumbing = newRenovation.plumbing;
    flooring = newRenovation.flooring;
    bathrooms = newRenovation.bathrooms;
    appliances = newRenovation.appliances;
    electrical = newRenovation.electrical;
    yard = newRenovation.yard;
    cleaning = newRenovation.cleaning;
    baseboards = newRenovation.baseboards;
    exterior = newRenovation.exterior;
    demo = newRenovation.demo;
    elevators = newRenovation.elevators;
    build28Units = newRenovation.build28Units;
    other = newRenovation.other;
    total = newRenovation.total;
    tenPercentExtra = newRenovation.tenPercentExtra;
    notifyListeners();
  }

  void reset() {
    foundation = roof = airConditioner = paintingPatching = kitchen = windows
      = plumbing = flooring = bathrooms = appliances = electrical = yard
      = cleaning = baseboards = exterior = demo = elevators = build28Units
      = other = total = tenPercentExtra = 0;
    id = null;
    notifyListeners();
  }
}