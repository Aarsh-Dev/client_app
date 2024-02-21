import 'dart:convert';
import 'dart:developer';
import 'package:client_app/constant/method.dart';
import 'package:client_app/constant/vars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MoreActivitiesController extends GetxController{



  RxBool isToursLoading = false.obs;
  RxBool isTourDetailsLoading = false.obs;
  RxBool isTourBookNow = false.obs;
  RxBool isTourSummaryLoading = false.obs;



  Rxn<int> optionalGroupValue = Rxn<int>();
  RxInt currentIndex = 0.obs;


  RxString bookingToursGrandTotal = "0.0".obs;
  RxString bookingToursTotalPrice = "0".obs;



  RxList<dynamic> toursList = <dynamic>[].obs;
  RxList showActivityIndexList = [].obs;
  RxList showOptionIndexList = [].obs;
  RxList selectRestaurantType = [].obs;
  RxList<dynamic> tourDetailsList = <dynamic>[].obs;
  RxList<dynamic> selectedTourList = <dynamic>[].obs;
  RxList<dynamic> toursSummaryList = <dynamic>[].obs;


  RxList tourType = ["Private", "SIC"].obs;
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




/*==========================> Tours Search Api <==============================*/
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


/*==========================> Tours Details Api <=============================*/
  Future<void> getTourViewDetails({tourTitleId}) async {
    tourDetailsList.clear();

    Map<String, String> headers = {'Content-Type': 'application/json'};
    final body = jsonEncode([
      {
        "TourTitleID": tourTitleId,
      }
    ]);

    log("${baseUrl}GetTourViewDetail");
    log("BODY => $body");

    try {
      isTourDetailsLoading.value = true;
      var response = await http.post(
        Uri.parse("${baseUrl}GetTourViewDetail"),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData['Data']['Success'] == "True") {
          Map data = responseData['Data'];
          List tourDetails = data['TourViewDetails'];
          tourDetailsList.value = tourDetails;

          isTourDetailsLoading.value = false;
        } else {
          debugPrint("Error=>${responseData['Data']['Message']}");
          isTourDetailsLoading.value = false;
        }
      } else {
        debugPrint("statusCode=>${response.statusCode}");
        isTourDetailsLoading.value = false;
      }
    } catch (e) {
      debugPrint("Error=>${e.toString()}");
      isTourDetailsLoading.value = false;
    }
  }


/*==========================> Tours Details Api <=============================*/
  Future<dynamic> tourAddToPlannerCart({tour, plannerId, isHalfDay, date,bool isMultiple=false}) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};

    tour.remove("is_selected");
    final body = jsonEncode([
      {
        "BookType":"TO",
        "TourType": "Full Day",
        "AreaID": "6",
        "PlannerID": "0",
        "CategoryID": "2",
        "UserID": "77",
        "Currency": "USD",
        "CountryID": "2",
        "CityID": "5",
        "StartDate": "28-Feb-2024",
        "EndDate": "28-Feb-2024",
        "NoofAdult": "2",
        "NoofChild": "0",
        "NoofInfant": "0",
        "Data": [tour],
      }
    ]);
    try {
      isTourBookNow.value = true;
      var response = await http.post(
        Uri.parse(
            "${baseUrl}OnlyTourAddToPlannerCart"),
        headers: headers,
        body: body,
      );

      log("API => ${baseUrl}OnlyTourAddToPlannerCart");
      log("BODY => $body");
      log("RESPONSE => ${response.body}");

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData["Data"]["Success"] == "True") {
          if (responseData['Data']['Message']
              .toString()
              .contains("Nyepi Day")) {
            showToast(responseData['Data']['Message']);
            isTourBookNow.value = false;
            return 0;
          }

          if(isMultiple){
            getTourSummary(isMultiple: true);

          }else{
            getTourSummary();
          }

        } else {
          showToast(responseData["Data"]["Message"]);
        }
        isTourBookNow.value = false;
      } else {
        if (plannerId == null) {
          Get.back();
        } else {
          return 0;
        }
        debugPrint("statusCode=>${response.statusCode}");
        isTourBookNow.value = false;
      }
    } catch (e) {
      debugPrint("Error=>$e");
      isTourBookNow.value = false;
    }
  }


/*==========================> Tours Summary Api <=============================*/
  Future<void> getTourSummary({bool isMultiple=false}) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final body = jsonEncode([
      {
        "UserID": "77",
      }
    ]);
    isTourSummaryLoading.value = true;
    var response = await http.post(
      Uri.parse("${baseUrl}GetTourSummery"),
      headers: headers,
      body: body,
    );
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      if (responseData['Data']['Success'] == "True") {
        Map data = responseData['Data'];
        List list = data['TourSummeryList'];
        toursSummaryList.clear();
        toursSummaryList.value = list;
        bookingToursGrandTotalPrice();
        // if(isMultiple){
        //   Get.to(const TourGuestDetails());
        // }else{
        //   Get.off(const ToursBooking());
        // }

        isTourSummaryLoading.value = false;
      } else {
        debugPrint("Error=>${responseData['Data']['Message']}");
        isTourSummaryLoading.value = false;
      }
    } else {
      debugPrint("statusCode=>${response.statusCode}");
      isTourSummaryLoading.value = false;
    }
  }


  /*==========================> Get Tours Price <=============================*/
  getToursPrice({isPlanner, tourType, tourTitleId, tourNameId, tourSubNameId, tourTypeName, index}) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};

    final body = jsonEncode([
      {
        "TourTitleId": tourTitleId,
        "TourNameId": tourNameId,
        "Tourtype": tourType, //Pass SIC/ Private
        "TourSubNameId": tourSubNameId,
        "CountryID": "2",
        "CategoryID": "2",
        "UserID": "77",
        "Currency": "USD",
        "CityID": "5",
        "StartDate": "28-Feb-2024",
        "EndDate": "28-Feb-2024",
        "NoofAdult": "2",
        "NoofChild": "0",
        "NoofInfant": "0",
        "Type": tourNameId.toString(),
        "AreaID": "6",
      }
    ]);

    log("${baseUrl}GetTourPrice");
    log("BODY => $body");

    var response = await http.post(
        Uri.parse("${baseUrl}GetTourPrice"),
        headers: headers,
        body: body);
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      if (responseData['Data']["Success"] == "True") {
        Map data = responseData['Data'];

        debugPrint("LENGTH=> ${data['TourList'].toString()}");

        if (data['TourList'][0]['TourDetails'][0]['TourUpgrade'].isNotEmpty) {
          bool isRecomIDZero = false;
          int i = 0;
          for (int q = 0;
          q < data['TourList'][0]['TourDetails'][0]['TourUpgrade'].length;
          q++) {
            if (data['TourList'][0]['TourDetails'][0]['TourUpgrade'][q]
            ['RecomID'] ==
                "1") {
              i = q;
              isRecomIDZero = true;
              break;
            }
          }

          int p = int.parse(data['TourList'][0]['TourDetails'][0]['Price']
              .toString()
              .replaceAll("USD", "")
              .trim());
          if (!isRecomIDZero) {
            int c = p +
                int.parse(data['TourList'][0]['TourDetails'][0]['TourUpgrade']
                [i]['Cost1']);
            data['TourList'][0]['TotalPrice'] = c.toString();
          } else {
            data['TourList'][0]['TotalPrice'] = p.toString();
          }

          // int i = data['TourList'][0]['TourDetails'][0]['TourUpgrade'].length - 1;

          data['TourList'][0]['TourDetails'][0]['count'] = 0;

          data['TourList'][0]['TourDetails'][0]['g_value'] = i;
          data['TourList'][0]['IncludePrice'] = double.parse(data['TourList'][0]
          ['TourDetails'][0]['TotAdultCost']
              .toString()) +
              int.parse(data['TourList'][0]['TourDetails'][0]['TourUpgrade'][i]
              ['Cost1']
                  .toString());

          // data['TourList'][0]['TourTypeName']=tourTypeName;
          return data['TourList'][0];
        } else if (data['TourList'][0]['TourDetails'][0]['TourAddOn']
            .isNotEmpty) {
          data['TourList'][0]['TotalActivityPrice'] =
          data['TourList'][0]['Price'];
          data['TourList'][0]['IncludePrice'] =
          data['TourList'][0]['TourDetails'][0]['TotAdultCost'];
          for (int j = 0;
          j < data['TourList'][0]['TourDetails'][0]['TourAddOn'].length;
          j++) {
            data['TourList'][0]['TourDetails'][0]['count'] = 0;
            data['TourList'][0]['TourDetails'][0]['TourAddOn'][j]
            ['is_selected_activities'] = false;
          }
          return data['TourList'][0];
        } else {
          data['TourList'][0]['IncludePrice'] =
          data['TourList'][0]['TourDetails'][0]['TotAdultCost'];
          if (dateList.isNotEmpty) {
            data['TourList'][0]['select_tour_date'] =
            dateList[0];
          }
          return data['TourList'][0];
        }
      } else {
        showToast(responseData['Data']["Message"]);
      }
    } else {
      debugPrint("StatusCode=>${response.statusCode.toString()}");
    }
  }


  /*========================> Get Service Charge <==========================*/
  RxString serviceCharge="0".obs;
  Future<void> getTourServiceCharges() async {


    Map<String, String> headers = {'Content-Type': 'application/json'};
    final body = jsonEncode([
      {
        "BookFor": "TO",
      }
    ]);
    try {

      var response = await http.post(
        Uri.parse("${baseUrl}GetTransactionCharge"),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData['Data']['Success'] == "True") {
          Map data = responseData['Data'];
          serviceCharge.value=data['TransactionCharge'][0]['ServiceCharge'];
        } else {
          debugPrint("Error=>${responseData['Data']['Message']}");

        }
      } else {
        debugPrint("statusCode=>${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error=>${e.toString()}");
    }
  }




  bookingToursGrandTotalPrice() {
    int totalPrice = 0;
    double transactionCharges = 0.0;
    for (int i = 0; i < toursSummaryList.length; i++) {
      totalPrice = totalPrice + int.parse(toursSummaryList[i]['Cost'] ?? '0');
    }

    bookingToursTotalPrice.value = totalPrice.toString();
    bookingToursGrandTotal.value = double.parse(
        (totalPrice + double.parse(toursSummaryList[0]['ServiceCharge']))
            .toString())
        .toStringAsFixed(0);

    debugPrint(bookingToursGrandTotal.toString());
  }




}