import 'package:flutter/foundation.dart';

class Options extends ChangeNotifier {
  bool isSellerFinanced;
  bool wantsToRefinance;

  Options({this.isSellerFinanced = false, this.wantsToRefinance = false});

  void updateIsSellerFinanced(bool newValue) {
    isSellerFinanced = newValue;
    notifyListeners();
  }

  void updateWantsToRefinance(bool newValue) {
    wantsToRefinance = newValue;
    notifyListeners();
  }
}