import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RestaurantsController extends GetxController{


  RxBool isLoading = true.obs;


  TextEditingController textEditingController = TextEditingController();





  RxList<dynamic> lunchMealTypeList = <dynamic>[].obs;


  RxBool isPromoLoading = false.obs;






  Future<void> getMealsType() async {
    isLoading.value = true;
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(
        [
      {
        "UserID": "1",
        "Currency": "IDR",
        "CategoryID": "2",
        "CountryID": "2",
        "CityID": "5",
        "StartDate": "27-Jun-2023",
        "EndDate": "28-Jun-2023",
      "NoofAdult": "2",
      "NoofChild": "0",
      "NoofInfant": "0",
        "Type": "L",
      }
    ]
    );
    try {
      var response = await http.post(
        Uri.parse("https://api.uandiholidays.net/api/Values/GetMealType"),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData["Data"]["Success"] == "True") {
          Map data = responseData["Data"];
          List list = data["MealTypelist"];
          lunchMealTypeList.value = list;
          debugPrint("length=>${lunchMealTypeList.length}");
          isLoading.value = false;
        } else {
          debugPrint(responseData["Data"]["Message"]);
          debugPrint(responseData["Data"]["Message"]);
          isLoading.value = false;
        }
      } else {
        debugPrint("statusCode${response.statusCode}");
        isLoading.value = false;
      }
    } catch (e) {
      debugPrint("Error=>$e");
      isLoading.value = false;
    }
  }





}