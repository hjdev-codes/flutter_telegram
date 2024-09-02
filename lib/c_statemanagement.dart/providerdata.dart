import 'package:flutter/material.dart';

class Providerdata extends ChangeNotifier {
  int seletectedCountry = 1;
  String verificationId = '';
  bool DartThemeMode = false;
  int resentToken = 0;

  bool isUserNameNotAvaiable = false;

  changeUserNameValue(bool userName) {
    userName = isUserNameNotAvaiable;

    notifyListeners();
  }

  newThemecolor(bool newThemeMode) {
    DartThemeMode = newThemeMode;
    notifyListeners();
  }

  selectedCountryNumber(int index) {
    seletectedCountry = index;

    notifyListeners();
  }

  changeVerificationId(String newVerificationId, int newResendToken) {
    verificationId = newVerificationId;

    resentToken = newResendToken;

    notifyListeners();
  }
}
