import 'package:flutter/material.dart';

class Providerdata extends ChangeNotifier {
  int seletectedCountry = 0;

  selectedCountryNumber(int index) {
    seletectedCountry = index;

    notifyListeners();
  }
}
