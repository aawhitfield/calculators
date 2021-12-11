import 'package:flutter/foundation.dart';

const String tableOptions = 'options';

class OptionsFields {
  static final List<String> values = [
    id, isSellerFinanced, wantsToRefinance
  ];

  static const String id = '_id';
  static const String isSellerFinanced = 'isSellerFinanced';
  static const String wantsToRefinance = 'wantsToRefinance';
}


class Options extends ChangeNotifier {
  int? id;
  bool isSellerFinanced;
  bool wantsToRefinance;

  Options({this.isSellerFinanced = false, this.wantsToRefinance = false, this.id});

  Options copy({
    int? id,
    bool? isSellerFinanced,
    bool? wantsToRefinance,
  }) => Options(
      id: id ?? this.id,
      isSellerFinanced:  isSellerFinanced ?? this.isSellerFinanced,
      wantsToRefinance: wantsToRefinance ?? this.wantsToRefinance,
  );

  Map<String, Object?> toJson() => {
    OptionsFields.id: id,
    OptionsFields.isSellerFinanced: (isSellerFinanced) ? 1 : 0,
    OptionsFields.wantsToRefinance: (wantsToRefinance) ? 1 : 0,
  };

  static Options fromJson(Map<String, Object?> json) => Options(
    id: json[OptionsFields.id] as int?,
    isSellerFinanced: json[OptionsFields.isSellerFinanced] == 1,
    wantsToRefinance: json[OptionsFields.wantsToRefinance] == 1,
  );

  void updateOptions(Options newOptions) {
    id = newOptions.id;
    isSellerFinanced = newOptions.isSellerFinanced;
    wantsToRefinance = newOptions.wantsToRefinance;
    notifyListeners();
  }

  void updateIsSellerFinanced(bool newValue) {
    isSellerFinanced = newValue;
    notifyListeners();
  }

  void updateWantsToRefinance(bool newValue) {
    wantsToRefinance = newValue;
    notifyListeners();
  }

  void reset() {
    isSellerFinanced = wantsToRefinance = false;
    id = null;
    notifyListeners();
  }
}