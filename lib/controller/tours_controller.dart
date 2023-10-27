import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ToursController extends GetxController{






  Rxn<int> optionalGroupValue = Rxn<int>();
  RxInt currentIndex = 0.obs;


  RxBool isToursLoading = false.obs;

  RxList<dynamic> toursList = <dynamic>[].obs;
  RxList showActivityIndexList = [].obs;
  RxList showOptionIndexList = [].obs;
  RxList selectRestaurantType = [].obs;



  RxList<Tab> tabList = <Tab>[
    const Tab(child: Text("Description")),
     const Tab(child: Text("Itinerary"),),
    const Tab(child: Text("Do’s & Dont’s"),),
  ].obs;



  RxList<String> dateList = <String>[
    '12-Nov-2023',
    '13-Nov-2023',
    '14-Nov-2023',
    '15-Nov-2023',
    '16-Nov-2023',
  ].obs;





  Future<void> getToursSearch() async {
    toursList.clear();

    Map<String, String> headers = {'Content-Type': 'application/json'};
    final body = jsonEncode([
      {
        "UserID": "1",
        "Currency": "IDR",
        "CategoryID": "2",
        "CountryID": "2",
        "CityID": "5",
        "TourTitleID": "0",
        "StartDate": "27-Jun-2023",
        "EndDate": "28-Jun-2023",
        "NoofAdult": "2",
        "NoofChild": "1",
        "NoofInfant": "0",
        "Type": "0",
        "AreaID": "6"
      }
    ]);

    try {
      isToursLoading.value = true;
      var response = await http.post(
        Uri.parse("https://api.uandiholidays.net/api/Values/TourSearch"),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData["Data"]["Success"] == "True") {
          Map data = responseData["Data"];
          toursList.value = data["TourList"];
          for (int index = 0; index < toursList.length; index++) {
            toursList[index]['SelectDate'] = "";
            if (toursList[index]['TourDetails'][0]['TourUpgrade'].isNotEmpty) {
              int i = toursList[index]['TourDetails'][0]['TourUpgrade'].length - 1;
              int p=int.parse(toursList[index]['TourDetails'][0]['Price'].toString().replaceAll("USD", "").trim());
              toursList[index]['TotalPrice'] =p.toString();
              toursList[index]['TourDetails'][0]['count']=0;
              toursList[index]['TourDetails'][0]['g_value'] = i;
              toursList[index]['IncludePrice'] = double.parse(toursList[index]
              ['TourDetails'][0]['TotAdultCost']
                  .toString()) +
                  int.parse(toursList[index]['TourDetails'][0]['TourUpgrade'][i]
                  ['Cost1']
                      .toString());
            } else if (toursList[index]['TourDetails'][0]['TourAddOn']
                .isNotEmpty) {
              toursList[index]['TourDetails'][0]['count'] =0;
              toursList[index]['TotalActivityPrice'] =
                  toursList[index]['TourDetails'][0]['Price'].toString().replaceAll("USD", "").trim();
              toursList[index]['IncludePrice'] =
              toursList[index]['TourDetails'][0]['TotAdultCost'];
              for (int j = 0;
              j < toursList[index]['TourDetails'][0]['TourAddOn'].length;
              j++) {
                toursList[index]['TourDetails'][0]['TourAddOn'][j]['count']=0;
                toursList[index]['TourDetails'][0]['TourAddOn'][j]
                ['is_selected_activities'] = false;
              }
            } else {
              // if (transferController.dateList.isNotEmpty) {
              //   toursList[index]['select_tour_date'] =
              //   transferController.dateList[0];
              // }
            }
          }

          isToursLoading.value = false;
          // if( isPlanner != null && hotelController.plannerIndex.value == 0){
          //   showArrivalDayAlert();
          // }
        } else {
          debugPrint("Error=>${responseData["Data"]["Message"]}");
          isToursLoading.value = false;
        }
      } else {
        debugPrint("statusCode=>${response.statusCode}");
        isToursLoading.value = false;
      }
    } catch (e) {
      debugPrint("Error=>$e");
      isToursLoading.value = false;
    }
  }




}