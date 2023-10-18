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

  RxBool isCurrencyLoading = false.obs;

  List<String> inputList = [];


  RxList<String> currencyList = <String>['RUPEE',"USD"].obs;

  RxString selectedFromCurrency = "INR".obs;
  RxString selectedToCurrency = "USD".obs;


  List<Currency> currencies =[];
  List<Currency> filteredCurrencies =[];

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
          currencies.add(Currency(name: key, shortName: responseData['$key']));
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



}