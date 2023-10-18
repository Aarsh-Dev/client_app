import 'dart:convert';

import 'package:client_app/model/currency.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CurrencyController extends GetxController{





  RxString selectedFrom = 'RUPEE'.obs;
  RxString selectedTo = 'USD'.obs;
  RxString amount = '1'.obs;
  RxDouble selectedPrice = 0.00.obs;
  RxString inputValues = "0".obs;
  RxString updatingCurrencyType = "To".obs;

  RxBool isCurrencyLoading = false.obs;

  List<String> inputList = [];


  RxList<String> currencyList = <String>['RUPEE',"USD"].obs;

  RxString selectedFromCurrency = "INR".obs;
  RxString selectedToCurrency = "USD".obs;


  RxList<Currency> currencies =<Currency>[].obs;
  RxList<Currency> filteredCurrencies =<Currency>[].obs;

   getCurrencies() async {
     isCurrencyLoading.value = true;
    try {
      var response = await http.get(Uri.https("openexchangerates.org", '/api/currencies.json', {
        'prettyprint': 'false',
        'show_alternative': 'false',
        'show_inactive': 'false'
      }));
      if (response.statusCode == 200) {

        var responseData = jsonDecode(response.body);

        Iterable<String> keys = responseData.keys;

        for (final key in keys) {
          currencies.add(Currency(name: responseData['$key'], shortName:key ));
        }

        debugPrint("Length=>${currencies.length}");

        isCurrencyLoading.value = false;
      } else {
        debugPrint("Something went wrong");
        isCurrencyLoading.value = false;
      }
    } catch(e){
      debugPrint(e.toString());
      isCurrencyLoading.value = false;
    }
  }

  updateSelectedCurrency(String currency) {
    if (updatingCurrencyType.value == "To") {
      selectedToCurrency.value = currency;
    } else {
      selectedFromCurrency.value = currency;
    }
  }

  updateFilteredCurrencies(String searchQuery) {
    filteredCurrencies.clear();
    filteredCurrencies.addAll(currencies);
    if (searchQuery.isNotEmpty) {
      filteredCurrencies.removeWhere((currency) =>
      !currency.name.toLowerCase().contains(searchQuery.toLowerCase()) &&
          !currency.shortName
              .toLowerCase()
              .startsWith(searchQuery.toLowerCase()));
    }else{
      filteredCurrencies.clear();
    }
  }

  swapFromAndTo() {
    final temp = selectedFromCurrency.value;
    selectedFromCurrency.value = selectedToCurrency.value;
    selectedToCurrency.value = temp;
  }


}