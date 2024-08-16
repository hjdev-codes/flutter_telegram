import 'package:flutter/material.dart';

class Providerdata extends ChangeNotifier {
  int seletectedCountry = 1;
  String verificationId = '';

  int resentToken = 0;
  selectedCountryNumber(int index) {
    // String seletectedCountryInString =
    //     countryCode.keys.elementAt(index).toString();

    // seletectedCountry = int.parse(seletectedCountryInString);

    // print(seletectedCountry);

    seletectedCountry = index;

    notifyListeners();
  }

  changeVerificationId(String newVerificationId, int newResendToken) {
    verificationId = newVerificationId;

    resentToken = newResendToken;

    notifyListeners();
  }
}
