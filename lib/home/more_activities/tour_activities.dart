import 'dart:convert';
import 'dart:developer' as d;
import 'package:client_app/constant/app_colors.dart';
import 'package:client_app/constant/app_text_style.dart';
import 'package:client_app/constant/method.dart';
import 'package:client_app/controller/more_activity_controller.dart';
import 'package:client_app/home/more_activities/multiple_tours_booking.dart';
import 'package:client_app/widget/custom_button.dart';
import 'package:client_app/widget/loader/custom_button_loader.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nb_utils/nb_utils.dart';

class TourActivities extends StatefulWidget {
  dynamic model;
  final dynamic backupModel;
  final bool? isAddToPlannerVisible;
  final String? tourPlannerDate;

  TourActivities(
      {Key? key,
        this.model,
        this.isAddToPlannerVisible,
        this.tourPlannerDate,
        this.backupModel})
      : super(key: key);

  @override
  State<TourActivities> createState() => _TourActivitiesState();
}

class _TourActivitiesState extends State<TourActivities> {
  MoreActivitiesController controller = Get.find();

  // final data = Map.from(widget.backupModel);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.model['TourDetails'][0]['count'] = 0;
        if (widget.model['TourDetails'][0]['TourAddOn'].isNotEmpty) {
          for (int i = 0; i < widget.model['TourDetails'][0]['TourAddOn'].length; i++) {
            widget.model['TourDetails'][0]['TourAddOn'][i]['is_selected_activities'] = false;
          }
          widget.model['TotalActivityPrice'] = widget.model['Price'];
        } else if (widget.model['TourDetails'][0]['TourUpgrade'].isNotEmpty) {
          int i = widget.model['TourDetails'][0]['TourUpgrade'].length - 1;
          widget.model['TourDetails'][0]['g_value'] = i;
          widget.model['TotalPrice'] = (int.parse(widget.model['Price'].toString()) + int.parse(widget.model['TourDetails'][0]['TourUpgrade'][i]['Cost'].toString().replaceAll("USD", "").trim())).toString();
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color(0xffF0F0F0),
        appBar: AppBar(
          backgroundColor: AppColor.themeColor,
          elevation: 0,
          centerTitle: false,
          leading: IconButton(
            onPressed: () {
              widget.model['TourDetails'][0]['count'] = 0;
              if (widget.model['TourDetails'][0]['TourAddOn'].isNotEmpty) {
                for (int i = 0; i < widget.model['TourDetails'][0]['TourAddOn'].length; i++) {
                  widget.model['TourDetails'][0]['TourAddOn'][i]['is_selected_activities'] = false;
                }
                widget.model['TotalActivityPrice'] = widget.model['Price'];
              } else if (widget.model['TourDetails'][0]['TourUpgrade'].isNotEmpty) {
                int i = widget.model['TourDetails'][0]['TourUpgrade'].length - 1;
                widget.model['TourDetails'][0]['g_value'] = i;
                widget.model['TotalPrice'] = (int.parse(widget.model['Price'].toString()) + int.parse(widget.model['TourDetails'][0]['TourUpgrade'][i]['Cost'].toString().replaceAll("USD", "").trim())).toString();
              }
              Get.back(result: widget.model);
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
          ),
          title: widget.model['TourDetails'][0]['TourAddOn'].isNotEmpty
              ? Text(
            "More Activities",
            style: AppTextStyle.appbarTextStyle,
          )
              : Text(
            "More Option",
            style: AppTextStyle.appbarTextStyle,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.end,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.model['TourCount'] == "2") ...[
                          Text(
                            "Tour Type",
                            style: AppTextStyle.textStyleRegular12,
                          ),
                          6.height,
                          Row(
                            children: [
                              Expanded(child: tourTypeDropDown()),
                            ],
                          )
                        ] else ...[
                          Text(
                            "Tour Type",
                            style: AppTextStyle.textStyleRegular12,
                          ),
                          6.height,
                          Row(
                            children: [
                              Expanded(child: staticTourTypeBox()),
                            ],
                          )
                        ],
                      ],
                    ),
                  ),
                  16.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Tour Date",
                          style: AppTextStyle.textStyleRegular12,
                        ),
                        6.height,
                        Row(
                          children: [
                            Expanded(
                                child: dropDownMenuWithBorder()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (widget.model['TourDetails'][0]['TourAddOn'].isNotEmpty) ...[
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.model['TourDetails'][0]['TourAddOn'].length,
                  itemBuilder: (context, index1) {
                    return Row(
                      children: [
                        Checkbox(
                          activeColor: AppColor.themeColor,
                          value: widget.model['TourDetails'][0]['TourAddOn']
                          [index1]['is_selected_activities'] ??
                              false,
                          onChanged: (bool? value) {
                            if (value == true &&
                                widget.model['TourDetails'][0]['count'] >= 4) {
                              showToast("Maximum 4 addon you can add");
                              return;
                            }

                            updateTourActivityPrice(
                                kIndex: index1, value: value!);
                            if (value) {
                              int count =
                              widget.model['TourDetails'][0]['count'];
                              widget.model['TourDetails'][0]['count'] =
                                  count + 1;
                              widget.model['TourDetails'][0]['TourAddOn']
                              [index1]['is_selected_activities'] = true;
                            } else {
                              int count =
                              widget.model['TourDetails'][0]['count'];
                              widget.model['TourDetails'][0]['count'] =
                                  count - 1;
                              if (widget.model['TourDetails'][0]['count'] < 0) {
                                widget.model['TourDetails'][0]['count'] = 0;
                              }
                              widget.model['TourDetails'][0]['TourAddOn']
                              [index1]['is_selected_activities'] = false;
                            }
                            setState(() {});
                          },
                        ),
                        Expanded(
                            child: Text(
                              widget.model['TourDetails'][0]['TourAddOn'][index1]
                              ['AddonName'],
                              style: AppTextStyle.textStyleBold10,
                            )),
                        Text(
                          widget.model['TourDetails'][0]['TourAddOn'][index1]
                          ['Cost'],
                          style: AppTextStyle.textStyleBold10,
                        ),
                        24.width,
                      ],
                    );
                  },
                ),
              ),
            ] else if (widget
                .model['TourDetails'][0]['TourUpgrade'].isNotEmpty) ...[
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount:
                  widget.model['TourDetails'][0]['TourUpgrade'].length,
                  itemBuilder: (context, j) {
                    // toursController.optionalGroupValue.value =  widget.model['TourDetails'][0]['TourUpgrade'].length - 1;
                    return Row(
                      children: [
                        Radio(
                            value: j,
                            groupValue: widget.model['TourDetails'][0]
                            ['g_value'],
                            activeColor: AppColor.themeColor,
                            onChanged: (value) {
                              // groupValue(value: value);
                              widget.model['TourDetails'][0]['g_value'] = j;
                              updateTourOptionPrice(jIndex: j);
                            }),
                        Expanded(
                            child: Text(
                              widget.model['TourDetails'][0]['TourUpgrade'][j]
                              ['Update'],
                              style: AppTextStyle.textStyleBold10,
                            )),
                        16.width,
                        Text(
                          widget.model['TourDetails'][0]['TourUpgrade'][j]
                          ['Cost'],
                          style: AppTextStyle.textStyleBold10,
                        ),
                        24.width
                      ],
                    );
                  },
                ),
              )
            ],
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          // height: Get.height * 0.105,
          elevation: 10,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.model['TourDetails'][0]['TourUpgrade'].isNotEmpty
                      ? Text(
                    "USD${widget.model['TotalPrice'] ?? ''}",
                    style: AppTextStyle.textStyleBold16,
                  )
                      : widget.model['TourDetails'][0]['TourAddOn'].isNotEmpty
                      ? Text(
                    "USD${widget.model['TotalActivityPrice'] ?? ''}",
                    style: AppTextStyle.textStyleBold16,
                  )
                      : Text(
                    "USD${widget.model['Price'] ?? ''}",
                    style: AppTextStyle.textStyleBold16,
                  ),
                  // Text(
                  //   "onwards",
                  //   style: AppTextStyle.textStyleRegular12,
                  // ),
                ],
              ),
              16.width,
              Obx(() => controller.isTourBookNow.value
                    ? CustomButtonLoader(
                  height: 40,
                  width: widget.isAddToPlannerVisible == null
                      ? Get.width * 0.40
                      : Get.width * 0.50,
                )
                    : CustomButton(
                  buttonText: widget.isAddToPlannerVisible == null
                      ? 'Book Now'
                      : 'Add To Planner',
                  color: Colors.red,
                  height: 40,
                  width: widget.isAddToPlannerVisible == null
                      ? Get.width * 0.40
                      : Get.width * 0.50,
                  borderRadius: 4,
                  paddingHorizontal: 10.0,
                  onTap: () async {
                    int halfDayCount = 0;

                    d.log("First Model =>${jsonEncode(widget.model)}");


                    if (controller.selectedTourList.isNotEmpty) {
                      for (int i = 0; i < controller.selectedTourList.length; i++) {
                        if (controller.selectedTourList[i]['TourInDate'] ==
                            widget.model['TourInDate']) {
                          if (widget.model['TourTypeId'] == "2" &&
                              controller.selectedTourList[i]
                              ['TourTypeId'] ==
                                  "2") {
                            showToast(
                                "Please select different tour for different date");
                            return;
                          } else if (widget.model['TourTypeId'] == "1" &&
                              controller.selectedTourList[i]
                              ['TourTypeId'] ==
                                  "1") {
                            halfDayCount = halfDayCount + 1;
                          } else if (widget.model['TourTypeId'] == "1" &&
                              controller.selectedTourList[i]
                              ['TourTypeId'] ==
                                  "2") {
                            showToast(
                                "Please select different tour for different date");
                            return;
                          } else if (widget.model['TourTypeId'] == "2" &&
                              controller.selectedTourList[i]
                              ['TourTypeId'] ==
                                  "1") {
                            showToast(
                                "Please select different tour for different date");
                            return;
                          }
                        }
                      }
                    }

                    // if(controller.toursSummaryList.isNotEmpty){
                    //   for(int i =0; i< controller.toursSummaryList.length; i++){
                    //     if(controller.toursSummaryList[i]['TourDate'] == widget.model['TourInDate'] ){
                    //         if(tourType == "Full Day" && controller.toursSummaryList[i]['TourType'] == "Full Day"){
                    //           showToast("Please select different tour for different date");
                    //           return;
                    //         }else if(tourType == "Half Day" && controller.toursSummaryList[i]['TourType'] == "Half Day"){
                    //           halfDayCount = halfDayCount + 1;
                    //         }else if(tourType == "Half Day" && controller.toursSummaryList[i]['TourType'] == "Full Day"){
                    //           showToast("Please select different tour for different date");
                    //           return;
                    //         }else if(tourType == "Full Day" && controller.toursSummaryList[i]['TourType'] == "Half Day"){
                    //           showToast("Please select different tour for different date");
                    //           return;
                    //         }
                    //     }
                    //   }
                    // }

                    if (halfDayCount >= 2) {
                      debugPrint("3 Tour Half Day Same Date");
                      showToast(
                          "Please select different tour for different date");
                      return;
                    }

                    // ==========> Remove Html value <===========
                    widget.model['VwDet'] = "";
                    widget.model['Desc'] = "";
                    widget.model['EntranceExclude'] = "";
                    widget.model['TourDetails'][0]['VwDet'] = "";

                    widget.model['TourDetails'][0]['TotChldPrc'] =
                        widget.model['TourDetails'][0]['TotChldPrc'] ??
                            "0";
                    widget.model['TourDetails'][0]['TotChldPrc_U'] =
                        widget.model['TourDetails'][0]['TotChldPrc_U'] ??
                            "0";
                    widget.model['TourDetails'][0]['TotInfPrc'] =
                        widget.model['TourDetails'][0]['TotInfPrc'] ??
                            "0";
                    widget.model['TourDetails'][0]['TotInfPrc_U'] =
                        widget.model['TourDetails'][0]['TotInfPrc_U'] ??
                            "0";

                    widget.model['TourTitle'] = widget.model['TourTitle']
                        .toString()
                        .replaceAll("&", "and");
                    widget.model['TourDetails'][0]['TourTitle'] = widget
                        .model['TourDetails'][0]['TourTitle']
                        .toString()
                        .replaceAll("&", "and");

                    List<dynamic> tourAddOn = [];
                    List<dynamic> tourUpgrade = [];

                    // ==========> Add Activities <===========
                    if (widget.model['TourDetails'][0]['TourAddOn'].isNotEmpty) {
                      for (int j = 0;
                      j <
                          widget.model['TourDetails'][0]['TourAddOn']
                              .length;
                      j++) {
                        if (widget.model['TourDetails'][0]['TourAddOn'][j]
                        ['is_selected_activities'] ==
                            true) {
                          tourAddOn.add(widget.model['TourDetails'][0]
                          ['TourAddOn'][j]);
                        }
                      }
                      widget.model['TourDetails'][0]['TourAddOn'] =
                          tourAddOn;
                    } else {
                      // ==========> Add Another Option <===========

                      if (widget.model['TourDetails'][0]['TourUpgrade'].isNotEmpty) {
                        for (int j = 0; j < widget.model['TourDetails'][0]['TourUpgrade'].length; j++) {
                          if (widget.model['TourDetails'][0]['g_value'] == j) {
                            tourUpgrade.add(widget.model['TourDetails'][0]['TourUpgrade'][j]);
                          }
                        }
                        widget.model['TourDetails'][0]['TourUpgrade'] = tourUpgrade;
                      }
                    }

                    // ==========> Add To Planner <===========

                    if (widget.isAddToPlannerVisible == null) {
                      controller.selectedTourList.add(widget.model);
                      Get.off(const MultipleToursBooking());
                      // controller.singleTourAddToPlanner(tour: widget.model);
                    } else {
                      // var result =
                      // await controller.singleTourAddToPlanner(
                      //     tour: widget.model,
                      //     plannerId: hotelController.plannerList[hotelController.plannerIndex.value]['Id'],
                      //     isHalfDay: controller.toursTypeName.value == "Half Day" ? true : false,
                      //     date: widget.tourPlannerDate);
                      //
                      // if (result == 1) {
                      //   Get.back(result: 1);
                      // } else {
                      //
                      //
                      //   var result = await controller.getToursSearch();
                      //
                      //   for (int i = 0; i < controller.toursList.length; i++) {
                      //     if (controller.toursList[i]['TourTitleID'] == widget.model['TourTitleID']) {
                      //       widget.model = controller.toursList[i];
                      //       d.log("Second Model =>${jsonEncode(widget.model)}");
                      //       break;
                      //     }
                      //   }
                      //   setState(() {});
                      // }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  updateTourActivityPrice({required int? kIndex, required bool value}) {
    if (widget.model['TourDetails'][0]['TourAddOn'][kIndex]
    ['is_selected_activities'] = true) {
      int price = int.parse(widget.model['TotalActivityPrice'].toString());
      int addPrice = int.parse(
          widget.model['TourDetails'][0]['TourAddOn'][kIndex]['Cost1']);
      if (value) {
        widget.model['TotalActivityPrice'] = price + addPrice;

        widget.model['IncludePrice'] =
            double.parse(widget.model['IncludePrice'].toString()) + (addPrice);
      } else {
        widget.model['TotalActivityPrice'] = price - addPrice;
        widget.model['IncludePrice'] =
            double.parse(widget.model['IncludePrice'].toString()) - (addPrice);
      }
      widget.model['TourDetails'][0]['TotAldtPrc'] = countAdultInclusionPrice();
      // if (transferController.txtChildController.text.isNotEmpty && transferController.txtChildController.text != "0") {
      //   widget.model['TourDetails'][0]['TotChldPrc'] = countChildInclusionPrice();
      // }
      debugPrint(
          "Total Adult Price: ${widget.model['TourDetails'][0]['TotAldtPrc'].toString()}");
      debugPrint(
          "Total Child Price: ${widget.model['TourDetails'][0]['TotChldPrc'].toString()}");
    }
    setState(() {});
  }

  updateTourOptionPrice({required int? jIndex}) {
    for (int k = 0;
    k < widget.model['TourDetails'][0]['TourUpgrade'].length;
    k++) {
      if (k == jIndex) {
        widget.model['TourDetails'][0]['TourUpgrade'][k]['RecomID'] = "1";
        int price = int.parse(widget.model['Price']);
        int addPrice = int.parse(
            widget.model['TourDetails'][0]['TourUpgrade'][k]['Cost1']);
        int totalPrice = price + addPrice;
        widget.model['TotalPrice'] = totalPrice;
        widget.model['TourDetails'][0]['TourUpgrade'][k]['g_value'] = k;
        widget.model['IncludePrice'] = double.parse(
            widget.model['TourDetails'][0]['TotAdultCost'].toString()) +
            (addPrice);
      } else {
        widget.model['TourDetails'][0]['TourUpgrade'][k]['RecomID'] = "0";
      }
    }
    widget.model['TourDetails'][0]['TotAldtPrc'] = countAdultInclusionPrice();
    // if (transferController.txtChildController.text.isNotEmpty && transferController.txtChildController.text != "0") {
    //   widget.model['TourDetails'][0]['TotChldPrc'] = countChildInclusionPrice();
    // }
    setState(() {});
  }

  String countAdultInclusionPrice() {
    double adtPrice =
    double.parse(widget.model['TourDetails'][0]['TotAdultCost'] ?? 0);
    double addAdultPrc = 0;
    double total = 0;

    if (widget.model['TourDetails'][0]['TourAddOn'].isNotEmpty) {
      for (int a = 0;
      a < widget.model['TourDetails'][0]['TourAddOn'].length;
      a++) {
        if (widget.model['TourDetails'][0]['TourAddOn'][a]
        ['is_selected_activities'] ==
            true) {
          addAdultPrc = addAdultPrc +
              double.parse(widget.model['TourDetails'][0]['TourAddOn'][a]
              ['TotAdultPrc'] ??
                  "0");
        }
      }
    } else {
      if (widget.model['TourDetails'][0]['TourUpgrade'].isNotEmpty) {
        for (int k = 0;
        k < widget.model['TourDetails'][0]['TourUpgrade'].length;
        k++) {
          if (k == widget.model['TourDetails'][0]['g_value']) {
            addAdultPrc = addAdultPrc +
                double.parse(widget.model['TourDetails'][0]['TourUpgrade'][k]
                ['TotAdultPrc'] ??
                    "0");
          }
        }
      }
    }

    total = adtPrice + addAdultPrc;
    return total.toStringAsFixed(2);
  }

  String countChildInclusionPrice() {
    double childPrice =
    double.parse(widget.model['TourDetails'][0]['TotChildCost'] ?? 0);
    double addChildPrc = 0;
    double total = 0;

    if (widget.model['TourDetails'][0]['TourAddOn'].isNotEmpty) {
      for (int a = 0;
      a < widget.model['TourDetails'][0]['TourAddOn'].length;
      a++) {
        if (widget.model['TourDetails'][0]['TourAddOn'][a]
        ['is_selected_activities'] ==
            true) {
          addChildPrc = addChildPrc +
              double.parse(widget.model['TourDetails'][0]['TourAddOn'][a]
              ['TotChildPrc'] ??
                  "0");
        }
      }
    } else {
      if (widget.model['TourDetails'][0]['TourUpgrade'].isNotEmpty) {
        for (int k = 0;
        k < widget.model['TourDetails'][0]['TourUpgrade'].length;
        k++) {
          if (k == widget.model['TourDetails'][0]['g_value']) {
            addChildPrc = addChildPrc +
                double.parse(widget.model['TourDetails'][0]['TourUpgrade'][k]
                ['TotChildPrc'] ??
                    "0");
          }
        }
      }
    }

    total = childPrice + addChildPrc;
    return total.toStringAsFixed(2);
  }

  Widget tourTypeDropDown() {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          constraints: const BoxConstraints(maxWidth: 120, maxHeight: 40)),
      isExpanded: true,
      hint: Center(
        child: Text(
          controller.tourType[0],
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 11),
        ),
      ),
      items: controller.tourType
          .map((item) => DropdownMenuItem<String>(
        value: item ?? controller.tourType[0],
        child: Center(
          child: Text(
            item,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ))
          .toList(),
      validator: (value) {
        /*      if (value == null) {
          return 'Please select Date.';
        }*/
        return null;
      },
      onChanged: (value) async {
        // noOfSelectedAddon=0;
        // if (controller.toursList[index]['is_selected'] != null) {
        //   controller.selectPlannerIndex.remove(index);
        // }
        // controller.toursList[index]['count'] = 0;
        selectedValue = value.toString();
        var result = await controller.getToursPrice(
            isPlanner: widget.isAddToPlannerVisible,
            tourType: value,
            tourNameId: widget.model['TourTypeId'],
            tourSubNameId: widget.model['TourSubNameId'],
            tourTypeName: widget.model['TourTypeName'],
            tourTitleId: widget.model['TourTitleID']);

        if (result != null) {
          widget.model = result;
        }

        setState(() {});

        // if(result != null){
        //   debugPrint("RESULT = > ${result.toString()}");
        //   if(result['TourDetails'][0]['TourUpgrade'].isNotEmpty){
        //     widget.model['TotalPrice'] = result['TotalPrice'];
        //   }else if(result['TourDetails'][0]['TourAddOn'].isNotEmpty){
        //     widget.model['TotalActivityPrice'] = result['TotalActivityPrice'];
        //   }else{
        //     widget.model['Price'] = result['Price'];
        //   }
        // }
      },
      onSaved: (value) {
        selectedValue = value.toString();
      },
      buttonStyleData: const ButtonStyleData(
        height: 40,
        width: 150,
        padding: EdgeInsets.zero,
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 20,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  Widget staticTourTypeBox() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 120, maxHeight: 40),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(4.0)),
      child: const Center(
        child: Text("Private"),
      ),
    );
  }

  String? selectedValue;

  // Widget plannerDropDownButton() {
  //   return Container(
  //     height: 35,
  //     width: Get.width,
  //     padding: const EdgeInsets.symmetric(horizontal: 2.0),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(5.0),
  //       border: Border.all(color: Colors.grey),
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Flexible(
  //           child: Text(
  //             hotelController.plannerList[hotelController.plannerIndex.value]
  //             ['pDate'] ??
  //                 '',
  //             style: AppTextStyle.textStyleRegular11,
  //           ),
  //         ),
  //         const Icon(
  //           Icons.arrow_drop_down,
  //           color: Colors.black45,
  //           size: 18.0,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget dropDownMenuWithBorder() {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          constraints: const BoxConstraints(maxWidth: 120, maxHeight: 40)),
      isExpanded: true,
      hint: Center(
        child: Text(
          controller.dateList[0],
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 11),
        ),
      ),
      items: controller.dateList
          .map((item) => DropdownMenuItem<String>(
        value: item,
        child: Center(
          child: Text(
            item,
            style: AppTextStyle.textStyleRegular11,
          ),
        ),
      ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select Date.';
        }
        return null;
      },
      onChanged: (value) {
        widget.model['TourInDate'] = value;
      },
      onSaved: (value) {
        selectedValue = value.toString();
        widget.model['TourInDate'] = value;
      },
      buttonStyleData: const ButtonStyleData(
        height: 40,
        width: 150,
        padding: EdgeInsets.zero,
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 20,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}