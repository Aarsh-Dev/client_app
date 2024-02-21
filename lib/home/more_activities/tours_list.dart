import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_app/constant/app_colors.dart';
import 'package:client_app/constant/app_text_style.dart';
import 'package:client_app/constant/method.dart';
import 'package:client_app/controller/more_activity_controller.dart';
import 'package:client_app/home/more_activities/tour_detail.dart';
import 'package:client_app/widget/loader/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class ToursList extends StatefulWidget {
  const ToursList({Key? key}) : super(key: key);

  @override
  State<ToursList> createState() => _ToursListState();
}

class _ToursListState extends State<ToursList> {


  MoreActivitiesController toursController = Get.find();



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar:AppBar(
          backgroundColor: AppColor.themeColor,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          centerTitle: false,
          actions: [
            IconButton(
                onPressed: () {
                },
                icon: const Icon(Icons.search))
          ],
          title: Text(
              "More Activities",
              style: AppTextStyle.appbarTextStyle
          ),
        ),
        body: Obx(() => toursController.isToursLoading.value
              ? const CustomLoader()
              : toursController.toursList.isEmpty
              ? const Center(child: Text("Not Found!", style: TextStyle(color: Colors.red),
            ),)
              : widgetTourList(),
        ),
      ),
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
          AnimatedListView(
            padding: const EdgeInsets.symmetric(
                horizontal: 0, vertical: 8),
            itemCount: toursController.toursList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            slideConfiguration: SlideConfiguration(
                verticalOffset: 400,
                delay: const Duration(milliseconds: 50)),
            itemBuilder: (_, index) => InkWell(
              borderRadius: BorderRadius.circular(4.0),
              onTap: () async {
                toursController.getTourViewDetails(tourTitleId: toursController.toursList[index]['TourTitleID']);

                var result = await Get.to(TourDetail(
                  index: index,
                  model:toursController.toursList[index],
                ));

                if (result != null) {
                  if (result == 1) {
                    Get.back(result: 1);
                  }
                }

              },
              child: Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.symmetric(
                    vertical: 0, horizontal: 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Column(
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
                                          child:  Container(
                                            color: Colors.grey,
                                          )

                                      );

                                    },
                                    errorWidget:
                                        (context, url, error) {
                                      return Opacity(
                                          opacity: 0.20,
                                          child:  Container(
                                            color: Colors.grey,
                                          )

                                      );

                                    },
                                  ),
                                ),
                                // Align(
                                //   alignment: Alignment.bottomRight,
                                //   child:
                                //       widget.isAddToPlannerVisible !=
                                //               null
                                //           ? Container(
                                //               padding:
                                //                   const EdgeInsets
                                //                       .all(4.0),
                                //               decoration:
                                //                   BoxDecoration(
                                //                 color:
                                //                     Colors.black12,
                                //                 // borderRadius: BorderRadius.only(bottomRight: Radius.circular(5.0)),
                                //                 borderRadius:
                                //                     BorderRadius
                                //                         .circular(
                                //                             5.0),
                                //               ),
                                //               child: SizedBox(
                                //                 width: 30.0,
                                //                 height: 30.0,
                                //                 child: Checkbox(
                                //                   activeColor:
                                //                       Colors.blue,
                                //                   side: MaterialStateBorderSide
                                //                       .resolveWith(
                                //                     (states) => const BorderSide(
                                //                         width: 1.0,
                                //                         color: Colors
                                //                             .white),
                                //                   ),
                                //                   value: toursController
                                //                                   .toursList[
                                //                               index]
                                //                           [
                                //                           'is_selected'] ??
                                //                       false,
                                //                   onChanged: (bool?
                                //                       value) {
                                //                     if (value!) {
                                //                       if (toursController
                                //                               .toursTypeName
                                //                               .value ==
                                //                           "Half Day") {
                                //                         if (toursController
                                //                                 .selectPlannerIndex
                                //                                 .length <
                                //                             2) {
                                //                           toursController.toursList[index]
                                //                                   [
                                //                                   'is_selected'] =
                                //                               true;
                                //                           toursController
                                //                               .selectPlannerIndex
                                //                               .add(
                                //                                   index);
                                //                         } else {
                                //                           showToast(
                                //                               "You can select maximum 2 tour for half day");
                                //                         }
                                //                       } else {
                                //                         if (toursController
                                //                             .selectPlannerIndex
                                //                             .isEmpty) {
                                //                           toursController.toursList[index]
                                //                                   [
                                //                                   'is_selected'] =
                                //                               true;
                                //                           toursController
                                //                               .selectPlannerIndex
                                //                               .add(
                                //                                   index);
                                //                         } else {
                                //                           showToast(
                                //                               "You can select maximum 1 tour for full day");
                                //                         }
                                //                       }
                                //                     } else {
                                //                       toursController
                                //                                   .toursList[
                                //                               index]
                                //                           [
                                //                           'is_selected'] = null;
                                //                       toursController
                                //                           .selectPlannerIndex
                                //                           .remove(
                                //                               index);
                                //                     }
                                //                     setState(() {});
                                //                   },
                                //                 ),
                                //               ),
                                //             )
                                //           : Container(
                                //               padding:
                                //                   const EdgeInsets
                                //                       .all(4.0),
                                //               decoration:
                                //                   BoxDecoration(
                                //                 color:
                                //                     Colors.black12,
                                //                 // borderRadius: BorderRadius.only(bottomRight: Radius.circular(5.0)),
                                //                 borderRadius:
                                //                     BorderRadius
                                //                         .circular(
                                //                             0.0),
                                //               ),
                                //               child: SizedBox(
                                //                 width: 30.0,
                                //                 height: 30.0,
                                //                 child: Checkbox(
                                //                   activeColor:
                                //                       Colors.blue,
                                //                   side: MaterialStateBorderSide
                                //                       .resolveWith(
                                //                     (states) => const BorderSide(
                                //                         width: 1.0,
                                //                         color: Colors
                                //                             .white),
                                //                   ),
                                //                   value: toursController
                                //                                   .toursList[
                                //                               index]
                                //                           [
                                //                           'is_selected'] ??
                                //                       false,
                                //                   onChanged: (bool?
                                //                       value) {
                                //                     if (value!) {
                                //                       toursController
                                //                                   .toursList[
                                //                               index]
                                //                           [
                                //                           'is_selected'] = true;
                                //                       toursController
                                //                           .selectTourId
                                //                           .add(
                                //                               index);
                                //                     } else {
                                //                       toursController
                                //                                   .toursList[
                                //                               index]
                                //                           [
                                //                           'is_selected'] = null;
                                //                       toursController
                                //                           .selectTourId
                                //                           .remove(
                                //                               index);
                                //                     }
                                //                     setState(() {});
                                //                   },
                                //                 ),
                                //               ),
                                //             ),
                                // )
                              ],
                            ),
                          ),
                        ),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Text(
                        //       "USD ${toursController.toursList[index]['Price']}",
                        //       style: AppTextStyle
                        //           .textStyleBold16
                        //           .copyWith(
                        //           color: AppColor
                        //               .themeColor),
                        //     ),
                        //     InkWell(
                        //       onTap: () {
                        //         showPriceAlertDialogBox(
                        //             index);
                        //       },
                        //       child: const Icon(
                        //         Icons.info,
                        //         size: 14,
                        //       ),
                        //     )
                        //   ],
                        // )
                      ],
                    ),
                    8.height,
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            toursController.toursList[index]
                            ['TourTitle'] ??
                                "",
                            maxLines: 5,
                            style: AppTextStyle.textStyleBold16
                                .copyWith(
                                color: AppColor.themeColor),
                          ),
                        ),
                        // 16.width,
                        // toursController.toursList[index]
                        //             ['TourCount'] ==
                        //         "2"
                        //     ? tourTypeDropDown(index: index)
                        //     : const SizedBox()
                      ],
                    ),
                    8.height,
                    Text.rich(TextSpan(
                        children: [
                          // TextSpan(

                          //   text: "Status : ",style: AppTextStyle.textStyleRegular11
                          // ),
                          // TextSpan(
                          //     text: "On Request",style: AppTextStyle.textStyleRegular12.copyWith(color:Colors.black54)
                          // ),
                          TextSpan(
                              text: "${toursController.toursList[index]['Availability']??''}",style: AppTextStyle.textStyleRegular12.copyWith(color: toursController.toursList[index]['Availability'] == "Available" ? Colors.red :Colors.black54)
                          ),
                        ]
                    )),
                    8.height,
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
                        8.width,
                        InkWell(
                          onTap: () {
                            showPriceAlertDialogBox(index);
                          },
                          child: const Icon(
                            Icons.info,
                            size: 14,
                          ),
                        ),
                        16.width,
                      ],
                    ),
                    8.height,
                    /*   Row(
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
                                              margin: Margins.all(0),
                                              fontSize: FontSize(12),
                                            )
                                          },
                                        ))
                                      ],
                                    ),*/

                    // Row(
                    //   children: [
                    //     toursController
                    //             .toursList[index]['TourDetails'][0]
                    //                 ['TourUpgrade']
                    //             .isNotEmpty
                    //         ? Text(
                    //             "USD ${toursController.toursList[index]['TotalPrice']}",
                    //             style: AppTextStyle.textStyleBold20
                    //                 .copyWith(
                    //                     color: AppColor.themeColor),
                    //           )
                    //         : toursController
                    //                 .toursList[index]['TourDetails']
                    //                     [0]['TourAddOn']
                    //                 .isNotEmpty
                    //             ? Text(
                    //                 "USD ${toursController.toursList[index]['TotalActivityPrice']}",
                    //                 style: AppTextStyle
                    //                     .textStyleBold20
                    //                     .copyWith(
                    //                         color: AppColor
                    //                             .themeColor),
                    //               )
                    //             : Text(
                    //                 "USD ${toursController.toursList[index]['Price']}",
                    //                 style: AppTextStyle
                    //                     .textStyleBold20
                    //                     .copyWith(
                    //                         color: AppColor
                    //                             .themeColor),
                    //               ),
                    //     8.width,
                    //     InkWell(
                    //       onTap: () {
                    //         showPriceAlertDialogBox(index);
                    //       },
                    //       child: const Icon(
                    //         Icons.info,
                    //         size: 14,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // 8.height,
                    // Row(
                    //   children: [
                    //     Expanded(
                    //         child: widget.isAddToPlannerVisible !=
                    //                 null
                    //             ? plannerDropDownButton()
                    //             : dropDownMenuWithBorder(index)),
                    //     16.width,
                    //     // Expanded(
                    //     //     child: Row(
                    //     //   mainAxisAlignment: MainAxisAlignment.end,
                    //     //   children: [
                    //     //     toursController
                    //     //             .toursList[index]['TourDetails']
                    //     //                 [0]['TourUpgrade']
                    //     //             .isNotEmpty
                    //     //         ? Text(
                    //     //             "USD ${toursController.toursList[index]['TotalPrice']}",
                    //     //             style: AppTextStyle
                    //     //                 .textStyleBold20
                    //     //                 .copyWith(
                    //     //                     color: AppColor
                    //     //                         .themeColor),
                    //     //           )
                    //     //         : toursController
                    //     //                 .toursList[index]
                    //     //                     ['TourDetails'][0]
                    //     //                     ['TourAddOn']
                    //     //                 .isNotEmpty
                    //     //             ? Text(
                    //     //                 "USD ${toursController.toursList[index]['TotalActivityPrice']}",
                    //     //                 style: AppTextStyle
                    //     //                     .textStyleBold20
                    //     //                     .copyWith(
                    //     //                         color: AppColor
                    //     //                             .themeColor),
                    //     //               )
                    //     //             : Text(
                    //     //                 "USD ${toursController.toursList[index]['Price']}",
                    //     //                 style: AppTextStyle
                    //     //                     .textStyleBold20
                    //     //                     .copyWith(
                    //     //                         color: AppColor
                    //     //                             .themeColor),
                    //     //               ),
                    //     //     8.width,
                    //     //     InkWell(
                    //     //       onTap: () {
                    //     //         showPriceAlertDialogBox(index);
                    //     //       },
                    //     //       child: const Icon(
                    //     //         Icons.info,
                    //     //         size: 14,
                    //     //       ),
                    //     //     ),
                    //     //     16.width,
                    //     //   ],
                    //     // )),
                    //
                    //     // Expanded(
                    //     //     child: Material(
                    //     //   color: Colors.grey,
                    //     //   borderRadius: BorderRadius.circular(4),
                    //     //   child: InkWell(
                    //     //     onTap: () {
                    //     //       showAlertDialogBox(index);
                    //     //     },
                    //     //     child: SizedBox(
                    //     //       width: 120,
                    //     //       height: 35,
                    //     //       child: Center(
                    //     //         child: Text(
                    //     //           "Entrance",
                    //     //           style: AppTextStyle
                    //     //               .textStyleBold12
                    //     //               .copyWith(
                    //     //                   color: Colors.white),
                    //     //         ),
                    //     //       ),
                    //     //     ),
                    //     //   ),
                    //     // )),
                    //   ],
                    // ),
                    /* 8.height,
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
                                        toursController.toursList[index]['TourDetails'][0]['TourAddOn'].isEmpty &&
                                                toursController.toursList[index]['TourDetails'][0]['TourUpgrade'].isEmpty
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
                                                    : toursController.toursList[index]['TourDetails'][0]['TourUpgrade'].isNotEmpty
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
                                            ? 0.width
                                            : 16.width,
                                        Expanded(
                                            child: widget.isAddToPlannerVisible !=
                                                    null
                                                ? plannerDropDownButton()
                                                : dropDownMenuWithBorder(index)),
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
                                    ),*/
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
                              24.width,
                            ],
                          ).paddingOnly(
                              left: 16.0, top: 10.0),
                          ListView.builder(
                            shrinkWrap: true,
                            physics:
                            const NeverScrollableScrollPhysics(),
                            itemCount: toursController.toursList[index]['TourDetails'][0]['TourAddOn'].length,
                            itemBuilder: (context, index1) {
                              return Row(
                                children: [
                                  Obx(() => Checkbox(
                                    activeColor: Colors.blue,
                                    value: toursController.toursList[index]['TourDetails'][0]['TourAddOn'][index1]['is_selected_activities'] ?? false,
                                    onChanged: (bool? value) {
                                      if (value == true && toursController.toursList[index]['TourDetails'][0]['count'] >= 4) {
                                        showToast("Maximum 4 addon you can add");
                                        return;
                                      }

                                      updateTourActivityPrice(index: index, kIndex: index1, value: value!);
                                      if (value) {
                                        int count = toursController.toursList[index]['TourDetails'][0]['count'];
                                        toursController.toursList[index]['TourDetails'][0]['count'] = count + 1;
                                        toursController.toursList[index]['TourDetails'][0]['TourAddOn'][index1]['is_selected_activities'] = true;
                                      } else {
                                        int count = toursController.toursList[index]['TourDetails'][0]['count'];
                                        toursController.toursList[index]['TourDetails'][0]['count'] = count - 1;
                                        if (toursController.toursList[index]['TourDetails'][0]['count'] < 0) {
                                          toursController.toursList[index]['TourDetails'][0]['count'] = 0;
                                        }
                                        toursController.toursList[index]['TourDetails'][0]['TourAddOn'][index1]['is_selected_activities'] = false;
                                      }
                                      setState(() {});
                                    },
                                  )),
                                  Expanded(
                                      child: Text(
                                        toursController.toursList[index]['TourDetails'][0]['TourAddOn'][index1]['AddonName'],
                                        style: AppTextStyle.textStyleBold10,
                                      )),
                                  Text(
                                    toursController.toursList[index]['TourDetails'][0]['TourAddOn'][index1]['Cost'],
                                    style: AppTextStyle.textStyleBold10,
                                  ),
                                  24.width,
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
                              16.width,
                              Text(
                                toursController.toursList[
                                index]
                                ['TourDetails'][0]
                                ['TourUpgrade'][j]
                                ['Cost'],
                                style: AppTextStyle
                                    .textStyleBold10,
                              ),
                              24.width
                            ],
                          );
                        },
                      )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
