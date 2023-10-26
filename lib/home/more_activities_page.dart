import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_app/constant/app_colors.dart';
import 'package:client_app/constant/app_text_style.dart';
import 'package:client_app/constant/method.dart';
import 'package:client_app/controller/tours_controller.dart';
import 'package:client_app/tour_detail.dart';
import 'package:client_app/widget/custom_loader.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoreActivitiesPage extends StatefulWidget {
  const MoreActivitiesPage({Key? key}) : super(key: key);

  @override
  State<MoreActivitiesPage> createState() => _MoreActivitiesPageState();
}

class _MoreActivitiesPageState extends State<MoreActivitiesPage> {


  ToursController toursController = Get.find();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text("More Activities"),
        backgroundColor: AppColor.themeColor,
      ),
      body: Obx(()=>toursController.isToursLoading.value ? const CustomLoader():widgetTourList(),),
    );
  }


  Widget widgetTourList(){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16.0,
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            itemCount: toursController.toursList.length,
            itemBuilder: (context, index) {
              return  Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * 0.25,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        InkWell(
                          onTap: (){
                            Get.to(TourDetail(model:toursController.toursList[index]));
                          },
                          child: ClipRRect(
                            borderRadius:
                            BorderRadius.circular(4),
                            child: CachedNetworkImage(
                              // imageUrl:"https://uandiholidays.net/Admin/UploadFiles/Tour/Image/banana-boat.png",
                              imageUrl: toursController
                                  .toursList[index]
                              ['TourImg'] ??
                                  "",
                              fit: BoxFit.cover,
                              height: Get.height * 0.25,
                              width: Get.width,
                              placeholder: (context, url) {
                                return Opacity(
                                    opacity: 0.20,
                                    child: Image.network(
                                        "https://uandiholidays.net/images/nelo1.png"));
                              },
                              errorWidget:
                                  (context, url, error) {
                                return Opacity(
                                    opacity: 0.20,
                                    child: Image.network(
                                        "https://uandiholidays.net/images/nelo1.png"));
                              },
                            ),
                          ),
                        ),
                        // Align(
                        //   alignment: Alignment.bottomRight,
                        //   child:Container(
                        //     padding:
                        //     const EdgeInsets
                        //         .all(4.0),
                        //     decoration:
                        //     BoxDecoration(
                        //       color:
                        //       Colors.black12,
                        //       // borderRadius: BorderRadius.only(bottomRight: Radius.circular(5.0)),
                        //       borderRadius:
                        //       BorderRadius
                        //           .circular(
                        //           0.0),
                        //     ),
                        //     child: SizedBox(
                        //       width: 30.0,
                        //       height: 30.0,
                        //       child: Checkbox(
                        //         activeColor:
                        //         Colors.blue,
                        //         side: MaterialStateBorderSide
                        //             .resolveWith(
                        //               (states) => const BorderSide(
                        //               width: 1.0,
                        //               color: Colors
                        //                   .white),
                        //         ),
                        //         value: false,
                        //         onChanged: (bool?value) {},
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height:8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text( toursController.toursList[index]
                        ['TourTitle'] ??
                            "",
                          maxLines: 5,
                          style: AppTextStyle.textStyleBold16
                              .copyWith(
                              color: AppColor.themeColor),
                        ),
                      ),
                      const SizedBox(
                        width:16,
                      ),
                      // toursController.toursList[index]
                      // ['TourCount'] ==
                      //     "2"
                      //     ? tourTypeDropDown(index: index)
                      //     : const SizedBox()
                    ],
                  ),
                  const SizedBox(
                    height:8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      toursController
                          .toursList[index]['TourDetails'][0]
                      ['TourUpgrade']
                          .isNotEmpty
                          ? Text(
                        "USD ${toursController.toursList[index]['TotalPrice']}",
                        style: AppTextStyle.textStyleBold20
                            .copyWith(
                            color: AppColor.themeColor),
                      )
                          : toursController
                          .toursList[index]['TourDetails']
                      [0]['TourAddOn']
                          .isNotEmpty
                          ? Text(
                        "USD ${toursController.toursList[index]['TotalActivityPrice']}",
                        style: AppTextStyle
                            .textStyleBold20
                            .copyWith(
                            color: AppColor
                                .themeColor),
                      )
                          : Text(
                        "USD ${toursController.toursList[index]['Price']}",
                        style: AppTextStyle
                            .textStyleBold20
                            .copyWith(
                            color: AppColor
                                .themeColor),
                      ),
                      const SizedBox(
                        height:8,
                      ),
                      InkWell(
                        onTap: () {
                          showPriceAlertDialogBox(index);
                        },
                        child: const Icon(
                          Icons.info,
                          size: 14,
                        ),
                      ),
                      const SizedBox(
                        width:16,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height:8,
                  ),

                  // toursController.toursTypeName.value == "All"
                  //     ? Text(
                  //         toursController.toursList[index]
                  //             ['TourTypeName'],
                  //         maxLines: 5,
                  //         style: AppTextStyle.textStyleBold10
                  //             .copyWith(color: Colors.red),
                  //       )
                  //     : const SizedBox.shrink(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Entrance ",
                        style: AppTextStyle.textStyleRegular13,
                      ).paddingOnly(top: 2),
                      Expanded(
                          child: Text("${convertHtmlToString(htmlValue: toursController.toursList[index]['EntranceExclude']??'')}".replaceAll("-", ":")))
                    ],
                  ),
                  const SizedBox(
                    height:8,
                  ),
                  Row(
                    children: [
                      // toursController
                      //             .toursList[index]['TourDetails']
                      //                 [0]['TourAddOn']
                      //             .isEmpty &&
                      //         toursController
                      //             .toursList[index]['TourDetails']
                      //                 [0]['TourUpgrade']
                      //             .isEmpty
                      //     ? Expanded(
                      //         child: toursController.toursList[index]['TourCount'] == "2"
                      //             ? tourTypeDropDown(index: index)
                      //             : const SizedBox())
                      //     :
                      toursController
                          .toursList[index]['TourDetails']
                      [0]['TourAddOn']
                          .isEmpty &&
                          toursController
                              .toursList[index]['TourDetails']
                          [0]['TourUpgrade']
                              .isEmpty
                          ? const SizedBox.shrink()
                          : Expanded(
                          child: Obx(() => toursController
                              .toursList[index]['TourDetails']
                          [0]['TourAddOn']
                              .isNotEmpty
                              ? Obx(
                                () => Material(
                              color: Colors.grey,
                              borderRadius:
                              BorderRadius.circular(
                                  4),
                              child: InkWell(
                                onTap: () {
                                  if (toursController
                                      .showActivityIndexList
                                      .contains(
                                      index)) {
                                    toursController
                                        .showActivityIndexList
                                        .remove(index);
                                  } else {
                                    toursController
                                        .showActivityIndexList
                                        .add(index);
                                  }
                                },
                                child: SizedBox(
                                  width: 120,
                                  height: 35,
                                  child: Center(
                                    child: toursController
                                        .showActivityIndexList
                                        .contains(
                                        index)
                                        ? Text(
                                      "Remove Activities",
                                      style: AppTextStyle
                                          .textStyleBold12
                                          .copyWith(
                                          color:
                                          Colors.white),
                                    )
                                        : Text(
                                      "Activities + ",
                                      style: AppTextStyle
                                          .textStyleBold12
                                          .copyWith(
                                          color:
                                          Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                              : toursController
                              .toursList[index]['TourDetails']
                          [0]['TourUpgrade']
                              .isNotEmpty
                              ? Material(
                            color: Colors.grey,
                            borderRadius:
                            BorderRadius
                                .circular(4),
                            child: InkWell(
                              onTap: () {
                                if (toursController
                                    .showOptionIndexList
                                    .contains(
                                    index)) {
                                  toursController
                                      .showOptionIndexList
                                      .remove(
                                      index);
                                } else {
                                  toursController
                                      .showOptionIndexList
                                      .add(index);
                                }
                              },
                              child: SizedBox(
                                width: 120,
                                height: 35,
                                child: Center(
                                  child: toursController
                                      .showOptionIndexList
                                      .contains(
                                      index)
                                      ? Text(
                                    "Remove Option",
                                    style: AppTextStyle
                                        .textStyleBold12
                                        .copyWith(
                                        color: Colors.white),
                                  )
                                      : Text(
                                    "Option +",
                                    style: AppTextStyle
                                        .textStyleBold12
                                        .copyWith(
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          )
                              : const SizedBox.shrink())),
                      toursController
                          .toursList[index]['TourDetails']
                      [0]['TourAddOn']
                          .isEmpty &&
                          toursController
                              .toursList[index]['TourDetails']
                          [0]['TourUpgrade']
                              .isEmpty
                          ? const SizedBox(width: 0,)
                          : const SizedBox(width: 16,),
                      Expanded(
                          child:widgetDateDropDown(index:index)),
                      toursController
                          .toursList[index]['TourDetails']
                      [0]['TourAddOn']
                          .isEmpty &&
                          toursController
                              .toursList[index]['TourDetails']
                          [0]['TourUpgrade']
                              .isEmpty
                          ? const Expanded(child: Text(''))
                          : const SizedBox.shrink()
                      // Expanded(
                      //     child: toursController
                      //                 .toursList[index]
                      //                     ['TourDetails'][0]
                      //                     ['TourAddOn']
                      //                 .isEmpty &&
                      //             toursController
                      //                 .toursList[index]
                      //                     ['TourDetails'][0]
                      //                     ['TourUpgrade']
                      //                 .isEmpty
                      //         ? const SizedBox.shrink()
                      //         : toursController.toursList[index]
                      //                     ['TourCount'] ==
                      //                 "2"
                      //             ? tourTypeDropDown(index: index)
                      //             : const SizedBox()),
                    ],
                  ),
                  Obx(
                        () => toursController.showActivityIndexList
                        .contains(index)
                        ? Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Addon",
                                style: AppTextStyle
                                    .textStyleBold12,
                              ),
                            ),
                            Expanded(
                              child: Text("Price",
                                  textAlign: TextAlign.end,
                                  style: AppTextStyle
                                      .textStyleBold12),
                            ),
                            const SizedBox(
                              width:24,
                            ),
                          ],
                        ).paddingOnly(
                            left: 16.0, top: 10.0),
                        ListView.builder(
                          shrinkWrap: true,
                          physics:
                          const NeverScrollableScrollPhysics(),
                          itemCount: toursController
                              .toursList[index]
                          ['TourDetails'][0]
                          ['TourAddOn']
                              .length,
                          itemBuilder: (context, index1) {
                            return Row(
                              children: [
                                Obx(() => Checkbox(
                                  activeColor:
                                  Colors.blue,
                                  value: toursController
                                      .toursList[index]
                                  [
                                  'TourDetails'][0]
                                  [
                                  'TourAddOn'][index1]
                                  [
                                  'is_selected_activities'] ??
                                      false,
                                  onChanged:
                                      (bool? value) {
                                    if (value == true &&
                                        toursController.toursList[index]
                                        [
                                        'TourDetails'][0]
                                        [
                                        'count'] >=
                                            4) {
                                      debugPrint(
                                          "Maximum 4 addon you can add");
                                      return;
                                    }

                                    updateTourActivityPrice(
                                        index: index,
                                        kIndex: index1,
                                        value: value!);
                                    if (value) {
                                      int count = toursController
                                          .toursList[
                                      index]
                                      [
                                      'TourDetails']
                                      [0]['count'];
                                      toursController.toursList[
                                      index]
                                      [
                                      'TourDetails'][0]
                                      [
                                      'count'] = count + 1;
                                      toursController.toursList[
                                      index]
                                      [
                                      'TourDetails'][0]
                                      [
                                      'TourAddOn'][index1]
                                      [
                                      'is_selected_activities'] = true;
                                    } else {
                                      int count = toursController
                                          .toursList[
                                      index]
                                      [
                                      'TourDetails']
                                      [0]['count'];
                                      toursController.toursList[
                                      index]
                                      [
                                      'TourDetails'][0]
                                      [
                                      'count'] = count - 1;
                                      if (toursController.toursList[index]['TourDetails'][0]['count'] < 0) {toursController.toursList[index]['TourDetails'][0]['count'] = 0;}toursController.toursList[index]['TourDetails'][0]['TourAddOn'][index1]['is_selected_activities'] = false;
                                    }
                                    setState(() {});
                                  },
                                )),
                                Expanded(
                                    child: Text(
                                      toursController.toursList[
                                      index][
                                      'TourDetails']
                                      [0]['TourAddOn']
                                      [index1]['AddonName'],
                                      style: AppTextStyle
                                          .textStyleBold10,
                                    )),
                                Text(
                                  toursController.toursList[
                                  index][
                                  'TourDetails']
                                  [0]['TourAddOn']
                                  [index1]['Cost'],
                                  style: AppTextStyle
                                      .textStyleBold10,
                                ),
                                const SizedBox(
                                  width: 24,
                                ),
                              ],
                            );
                          },
                        )
                      ],
                    )
                        : const SizedBox.shrink(),
                  ),
                  Obx(() => toursController.showOptionIndexList
                        .contains(index)
                        ? ListView.builder(
                      shrinkWrap: true,
                      physics:
                      const NeverScrollableScrollPhysics(),
                      itemCount: toursController.toursList[index]['TourDetails']
                      [0]['TourUpgrade'].length,
                      itemBuilder: (context, j) {
                        toursController.optionalGroupValue.value = toursController.toursList[index]['TourDetails'][0]['TourUpgrade'].length - 1;
                        // if(toursController.toursList[index]['TourDetails'][0]['TourUpgrade'][j]['RecomID']=="1"){
                        //   groupValue=j;
                        // }
                        return Row(
                          children: [
                            Obx(() => Radio(
                                  value: j,
                                  groupValue: toursController.toursList[index]['TourDetails'][0]['g_value'],
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    // groupValue(value: value);
                                    toursController.toursList[index]['TourDetails'][0]['g_value'] = j;
                                    updateTourOptionPrice(index: index, jIndex: j);
                                  }),
                            ),
                            Expanded(
                                child: Text(
                                  toursController.toursList[index]['TourDetails'][0]['TourUpgrade'][j]['Update'],
                                  style: AppTextStyle
                                      .textStyleBold10,
                                )),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              toursController.toursList[index]['TourDetails'][0]['TourUpgrade'][j]['Cost'],
                              style: AppTextStyle.textStyleBold10,
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                          ],
                        );
                      },
                    )
                        : const SizedBox.shrink(),
                  ),
                ],
              );
            }, separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 16.0,
            );
          },),
        ],
      ),
    );
  }

  Widget widgetDateDropDown({index}){
    return DropdownButtonFormField2(
      decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(color: Colors.black26)
          ),
          constraints: BoxConstraints(maxWidth: Get.width, maxHeight: 35)),
      isExpanded: true,
      hint: Text(
        toursController.toursList[index]['SelectDate'].isEmpty?'Select Date':
        toursController.toursList[index]['SelectDate'],
        style: toursController.toursList[index]['SelectDate'].isEmpty
            ? AppTextStyle.textStyleLight12
            : AppTextStyle.textStyleRegular12,
      ),
      items: toursController.dateList
          .map((value) => DropdownMenuItem<String>(
        value: value,
        child: Text(value,
          style: AppTextStyle.textStyleRegular12,
        ),
      ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select city.';
        }
        return null;
      },
      onChanged: (newValue) {
        toursController.toursList[index]['SelectDate'] = newValue;
      },
      menuItemStyleData: const MenuItemStyleData(
        height: 35,
      ),
      buttonStyleData: ButtonStyleData(
        height: 50,
        width: Get.width,
        padding: const EdgeInsets.only(left: 16),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 20,
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 500,
        useSafeArea: true,
        scrollbarTheme: ScrollbarThemeData(
          thumbVisibility: MaterialStateProperty.all<bool>(true),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  showPriceAlertDialogBox(index) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.black,
          content: SizedBox(
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "* Inclusive Taxes",
                  style:
                  AppTextStyle.textStyleLight10.copyWith(color: Colors.red),
                )
              ],
            ).paddingAll(8),
          ),
        );
      },
    );
  }

  updateTourOptionPrice({required int index, int? jIndex}) {
    for (int k = 0;
    k <
        toursController
            .toursList[index]['TourDetails'][0]['TourUpgrade'].length;
    k++) {
      if (k == jIndex) {
        toursController.toursList[index]['TourDetails'][0]['TourUpgrade'][k]
        ['RecomID'] = "1";
        int price = int.parse(toursController.toursList[index]['Price']);
        int addPrice = int.parse(toursController.toursList[index]['TourDetails']
        [0]['TourUpgrade'][k]['Cost1']);
        int totalPrice = price + addPrice;
        toursController.toursList[index]['TotalPrice'] = totalPrice;
        toursController.toursList[index]['TourDetails'][0]['TourUpgrade'][k]
        ['g_value'] = k;
        toursController.toursList[index]['IncludePrice'] = double.parse(
            toursController.toursList[index]['TourDetails'][0]
            ['TotAdultCost']
                .toString()) +
            (addPrice);
      } else {
        toursController.toursList[index]['TourDetails'][0]['TourUpgrade'][k]
        ['RecomID'] = "0";
      }
    }
    // toursController.toursList[index]['TourDetails'][0]['TotAldtPrc'] = countAdultInclusionPrice(index: index);
    setState(() {});
  }

  updateTourActivityPrice({required int index, int? kIndex, required bool value}) {
    if (toursController.toursList[index]['TourDetails'][0]['TourAddOn'][kIndex]
    ['is_selected_activities'] = true) {
      int price = int.parse(
          toursController.toursList[index]['TotalActivityPrice'].toString());
      int addPrice = int.parse(toursController.toursList[index]['TourDetails']
      [0]['TourAddOn'][kIndex]['Cost1']);
      if (value) {
        toursController.toursList[index]['TotalActivityPrice'] =
            price + addPrice;

        toursController.toursList[index]['IncludePrice'] = double.parse(
            toursController.toursList[index]['IncludePrice'].toString()) +
            (addPrice);
      } else {
        toursController.toursList[index]['TotalActivityPrice'] =
            price - addPrice;
        toursController.toursList[index]['IncludePrice'] = double.parse(
            toursController.toursList[index]['IncludePrice'].toString()) -
            (addPrice);
      }
      // toursController.toursList[index]['TourDetails'][0]['TotAldtPrc'] =
      //     countAdultInclusionPrice(index: index);
      // if (transferController.txtChildController.text.isNotEmpty &&
      //     transferController.txtChildController.text != "0") {
      //   toursController.toursList[index]['TourDetails'][0]['TotChldPrc'] =
      //       countChildInclusionPrice(index: index);
      // }
      debugPrint(
          "Total Adult Price: ${toursController.toursList[index]['TourDetails'][0]['TotAldtPrc'].toString()}");
      debugPrint(
          "Total Child Price: ${toursController.toursList[index]['TourDetails'][0]['TotChldPrc'].toString()}");
    }
    setState(() {});
  }

  String countAdultInclusionPrice({index}) {
    double adtPrice = double.parse(toursController.toursList[index]
    ['TourDetails'][0]['TotAdultCost'] ??
        0);
    double addAdultPrc = 0;
    double total = 0;

    if (toursController
        .toursList[index]['TourDetails'][0]['TourAddOn'].isNotEmpty) {
      for (int a = 0;
      a <
          toursController
              .toursList[index]['TourDetails'][0]['TourAddOn'].length;
      a++) {
        if (toursController.toursList[index]['TourDetails'][0]['TourAddOn'][a]
        ['is_selected_activities'] ==
            true) {
          addAdultPrc = addAdultPrc +
              double.parse(toursController.toursList[index]['TourDetails'][0]
              ['TourAddOn'][a]['TotAdultPrc'] ??
                  "0");
        }
      }
    } else {
      if (toursController
          .toursList[index]['TourDetails'][0]['TourUpgrade'].isNotEmpty) {
        for (int k = 0;
        k <
            toursController
                .toursList[index]['TourDetails'][0]['TourUpgrade'].length;
        k++) {
          if (k ==
              toursController.toursList[index]['TourDetails'][0]['g_value']) {
            addAdultPrc = addAdultPrc +
                double.parse(toursController.toursList[index]['TourDetails'][0]
                ['TourUpgrade'][k]['TotAdultPrc'] ??
                    "0");
          }
        }
      }
    }

    total = adtPrice + addAdultPrc;
    return total.toStringAsFixed(2);
  }


  openDatePiker({index}) async {
     DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      toursController.toursList[index]['SelectDate'] = getDateInDDMMMYY(date:pickedDate);
      setState(() {});
    } else {
      debugPrint("Date is not selected");
    }
  }

}
