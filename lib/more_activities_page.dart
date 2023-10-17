import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_app/constant/app_colors.dart';
import 'package:client_app/constant/app_text_style.dart';
import 'package:client_app/controller/tours_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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
        title: Text("More Activities"),
      ),
      body: Obx(()=>toursController.isToursLoading.value ? const CircularProgressIndicator():SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widgetTourList(),
          ],
        ),
      ),),
    );
  }


  Widget widgetTourList(){
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (context, index) {
      return  Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  height: Get.height * 0.25,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
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
                      Align(
                        alignment: Alignment.bottomRight,
                        child:Container(
                          padding:
                          const EdgeInsets
                              .all(4.0),
                          decoration:
                          BoxDecoration(
                            color:
                            Colors.black12,
                            // borderRadius: BorderRadius.only(bottomRight: Radius.circular(5.0)),
                            borderRadius:
                            BorderRadius
                                .circular(
                                0.0),
                          ),
                          child: SizedBox(
                            width: 30.0,
                            height: 30.0,
                            child: Checkbox(
                              activeColor:
                              Colors.blue,
                              side: MaterialStateBorderSide
                                  .resolveWith(
                                    (states) => const BorderSide(
                                    width: 1.0,
                                    color: Colors
                                        .white),
                              ),
                              value: false,
                              onChanged: (bool?value) {},
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height:8,
          ),
          Row(
            children: [
              Expanded(
                child: Text("Tour Title",
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
                  // showPriceAlertDialogBox(index);
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
              Flexible(
                  child: Html(
                    data: toursController.toursList[index]
                    ['EntranceExclude'],
                    style: {
                      "body": Style(
                        fontSize: FontSize(12),
                      )
                    },
                  ))
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
                  ? SizedBox(width: 0,)
                  : SizedBox(width: 16,),
              Expanded(
                  child: dropDownMenuWithBorder(index)),
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
                              if (toursController
                                  .toursList[index]
                              [
                              'TourDetails'][0]
                              [
                              'count'] <
                                  0) {
                                toursController.toursList[
                                index]
                                [
                                'TourDetails'][0]
                                [
                                'count'] = 0;
                              }
                              toursController.toursList[
                              index]
                              [
                              'TourDetails'][0]
                              [
                              'TourAddOn'][index1]
                              [
                              'is_selected_activities'] = false;
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
                      SizedBox(
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
          Obx(
                () => toursController.showOptionIndexList
                .contains(index)
                ? ListView.builder(
              shrinkWrap: true,
              physics:
              const NeverScrollableScrollPhysics(),
              itemCount: toursController
                  .toursList[index]['TourDetails']
              [0]['TourUpgrade']
                  .length,
              itemBuilder: (context, j) {
                toursController.optionalGroupValue
                    .value = toursController
                    .toursList[index]
                ['TourDetails'][0]
                ['TourUpgrade']
                    .length -
                    1;
                // if(toursController.toursList[index]['TourDetails'][0]['TourUpgrade'][j]['RecomID']=="1"){
                //   groupValue=j;
                // }
                return Row(
                  children: [
                    Obx(
                          () => Radio(
                          value: j,
                          groupValue: toursController
                              .toursList[
                          index]
                          ['TourDetails'][0]
                          ['g_value'],
                          activeColor: Colors.blue,
                          onChanged: (value) {
                            // groupValue(value: value);
                            toursController.toursList[
                            index]
                            ['TourDetails']
                            [0]['g_value'] = j;
                            updateTourOptionPrice(
                                index: index,
                                jIndex: j);
                          }),
                    ),
                    Expanded(
                        child: Text(
                          toursController.toursList[
                          index]
                          ['TourDetails'][0]
                          ['TourUpgrade'][j]
                          ['Update'],
                          style: AppTextStyle
                              .textStyleBold10,
                        )),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      toursController.toursList[
                      index]
                      ['TourDetails'][0]
                      ['TourUpgrade'][j]
                      ['Cost'],
                      style: AppTextStyle
                          .textStyleBold10,
                    ),
                    SizedBox(
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
    },);
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
    toursController.toursList[index]['TourDetails'][0]['TotAldtPrc'] = countAdultInclusionPrice(index: index);
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
      toursController.toursList[index]['TourDetails'][0]['TotAldtPrc'] =
          countAdultInclusionPrice(index: index);
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


  Widget dropDownMenuWithBorder(index) {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          constraints: const BoxConstraints(maxWidth: 120, maxHeight: 35)),
      isExpanded: true,
      hint: Center(
        child: Text(
          "Test",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 11),
        ),
      ),
      items: ['Date']
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
        toursController.toursList[index]['TourInDate'] = value;
      },
      onSaved: (value) {

        toursController.toursList[index]['TourInDate'] = value;
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
