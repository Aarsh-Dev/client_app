import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:client_app/constant/app_colors.dart';
import 'package:client_app/constant/app_text_style.dart';
import 'package:client_app/controller/more_activity_controller.dart';
import 'package:client_app/home/more_activities/tour_activities.dart';
import 'package:client_app/widget/custom_button.dart';
import 'package:client_app/widget/loader/custom_loader.dart';
import 'package:client_app/widget/loader/shimmer_banner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:scroll_to_animate_tab/scroll_to_animate_tab.dart';

class TourDetail extends StatefulWidget {
  dynamic model;
  final int? index;
  final String? tourPlannerDate;
  final bool? isAddToPlannerVisible;

  TourDetail(
      {Key? key,
      this.index,
      this.model,
      this.tourPlannerDate,
      this.isAddToPlannerVisible})
      : super(key: key);

  @override
  State<TourDetail> createState() => _TourDetailState();
}

class _TourDetailState extends State<TourDetail>
    with SingleTickerProviderStateMixin {
  MoreActivitiesController controller = Get.find();
  CarouselController carouselController = CarouselController();
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: const Color(0xffF0F0F0),
        appBar: AppBar(
          backgroundColor: AppColor.themeColor,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          centerTitle: true,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.model['TourTitle'] ?? '',
                style: AppTextStyle.textStyleRegular16
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.abc,
                  color: AppColor.themeColor,
                ))
          ],
        ),
        body: Obx(
          () => controller.isTourDetailsLoading.value
              ? const CustomLoader()
              : controller.tourDetailsList.isNotEmpty
                  ? Column(
                      children: [
                        CarouselSlider(
                          carouselController: carouselController,
                          options: CarouselOptions(
                              height: Get.height * 0.30,
                              autoPlay: true,
                              viewportFraction: 1,
                              onPageChanged: (val, _) {}),
                          items: List.generate(
                            controller.tourDetailsList[0]['TourViewDetailsImage'].length,
                            (index) {
                              return ClipRRect(
                                  child: CachedNetworkImage(
                                imageUrl: controller.tourDetailsList[0]['TourViewDetailsImage'][index]['ImageUrl'] ?? '',
                                placeholder: (context, url) => const ShimmerBanner(),
                                errorWidget: (context, url, error) => const ShimmerBanner(),
                                width: Get.width,
                                height: Get.height * 0.30,
                                fit: BoxFit.cover,
                              ));
                            },
                          ),
                        ),
                        Expanded(
                          child: ScrollToAnimateTab(
                            bodyAnimationCurve: Curves.easeIn,
                            tabAnimationCurve: Curves.easeIn,
                            activeTabDecoration: TabDecoration(
                              textStyle: AppTextStyle.textStyleRegular14
                                  .copyWith(color: Colors.red),
                              // decoration: BoxDecoration(
                              //     border: Border(bottom: BorderSide(color: Colors.white)),
                              //     borderRadius: const BorderRadius.all(Radius.circular(5)))
                            ),
                            inActiveTabDecoration: TabDecoration(
                              textStyle: AppTextStyle.textStyleRegular14
                                  .copyWith(color: Colors.white),
                              // decoration: BoxDecoration(
                              //     border: Border.all(color: Colors.black12),
                              //     borderRadius: const BorderRadius.all(Radius.circular(5)))
                            ),
                            backgroundColor: AppColor.themeColor,
                            tabs: [
                              ScrollableList(
                                  label: "Overview",
                                  bodyLabelDecoration: Text("Overview", style: AppTextStyle.textStyleBold14.copyWith(color: Colors.black),),
                                  body: ListView.builder(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: controller.tourDetailsList.length,
                                      itemBuilder: (_, index) {
                                        return Text(controller.tourDetailsList[index]['Description'] ?? '');
                                      })),
                              ScrollableList(
                                  label: "Inclusion",
                                  bodyLabelDecoration: Text("Inclusion", style: AppTextStyle.textStyleBold14.copyWith(color: Colors.black),),
                                  body: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                                      itemCount: controller.tourDetailsList.length,
                                      itemBuilder: (_, index) {
                                        return Text(controller.tourDetailsList[index]['Inclusion'] ?? '');
                                      })),
                              ScrollableList(
                                  label: "Itinerary",
                                  bodyLabelDecoration: Text("Itinerary", style: AppTextStyle.textStyleBold14.copyWith(color: Colors.black),),
                                  body: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                                      itemCount: controller.tourDetailsList.length,
                                      itemBuilder: (_, index) {
                                        return Text(controller.tourDetailsList[index]['Itinerary'] ?? '');
                                      })),
                              ScrollableList(
                                  label: "Tour Info",
                                  bodyLabelDecoration: Text(
                                    "Tour Info",
                                    style: AppTextStyle.textStyleBold14
                                        .copyWith(color: Colors.black),
                                  ),
                                  body: ListView.builder(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: controller.tourDetailsList.length,
                                      itemBuilder: (_, index) {
                                        return Text(controller.tourDetailsList[index]['TourInfo'] ?? '');
                                      })),
                            ],
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
        ),
        bottomNavigationBar: Obx(
          () => controller.isTourDetailsLoading.value
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.grey.shade200,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                widget.model['TourDetails'][0]['TourUpgrade'].isNotEmpty
                                    ? Text(
                                        "USD ${widget.model['TotalPrice'] ?? ''}",
                                        style: AppTextStyle.textStyleBold16,
                                      )
                                    : widget.model['TourDetails'][0]['TourAddOn'].isNotEmpty
                                        ? Text(
                                            "USD ${widget.model['TotalActivityPrice'] ?? ''}",
                                            style: AppTextStyle.textStyleBold16,
                                          )
                                        : Text(
                                            "USD${widget.model['Price'] ?? ''}",
                                            style: AppTextStyle.textStyleBold16,
                                          ),
                                widget.model['TourEntrance'].isNotEmpty
                                    ? InkWell(
                                        onTap: () {
                                          String entrance = "";
                                          for (int i = 0; i < widget.model['TourEntrance'].length; i++) {
                                            entrance = "${entrance + widget.model['TourEntrance'][i]['Entrance']}\n";
                                          }
                                          showAlertDialogBox(value: entrance);
                                        },
                                        child: Container(
                                            margin: const EdgeInsets.only(top: 4),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 0, vertical: 4),
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
                                            child: Row(
                                              children: [
                                                Text("Entrance Included", style: AppTextStyle.textStyleBold12,),
                                                4.width,
                                                InkWell(
                                                  onTap: () {
                                                    String entrance = "";
                                                    for (int i = 0; i < widget.model['TourEntrance'].length; i++) {
                                                      entrance = "${entrance + widget.model['TourEntrance'][i]['Entrance']}\n";
                                                    }
                                                    showAlertDialogBox(value: entrance);
                                                  },
                                                  child: const Icon(
                                                    Icons.add_circle,
                                                    color: Colors.red,
                                                  ),
                                                )
                                              ],
                                            )))
                                    : SizedBox.shrink()
                              ],
                            ),
                          ],
                        ),
                      ),
                      CustomButton(
                        buttonText: 'Add On',
                        color: Colors.red,
                        height: 40,
                        width: Get.width * 0.40,
                        borderRadius: 4,
                        paddingHorizontal: 10.0,
                        onTap: () async {
                          var result = await Get.to(TourActivities(
                            model: widget.model,
                            isAddToPlannerVisible: widget.isAddToPlannerVisible,
                            tourPlannerDate: widget.tourPlannerDate,
                          ))?.then((value) {
                            widget.model = value ?? {};
                          });

                          if (result != null) {
                            if (result == 1) {
                              Get.back(result: 1);
                            }
                          }
                        },
                      ),

                      /*    Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(widget.model ['TourCount'] == "2")...[
                    Text("Tour Type",style: AppTextStyle.textStyleRegular12,),
                    Row(
                      children: [
                        Expanded(
                            child: tourTypeDropDown(index:widget.index)),
                      ],
                    )
                  ]
                  else...[
                    Row(
                      children: [
                        Expanded(
                          child:  Text("Tour Type: Private",style: AppTextStyle.textStyleRegular12,),),
                      ],
                    ),
                    8.height,
                  ],
                  6.height,
                  Text("Select Tour Date",style: AppTextStyle.textStyleRegular12,),
                  6.height,
                  Row(
                    children: [
                      Expanded(child:
                      widget.isAddToPlannerVisible != null ?
                      plannerDropDownButton()
                          :dropDownMenuWithBorder()
                      ),
                    ],
                  ),
                ],
              ),
            ),
            16.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.model['TourDetails'][0]['TourUpgrade'].isNotEmpty?
                  Text(
                    "USD${widget.model['TotalPrice']??''}",
                    style: AppTextStyle.textStyleBold16,
                  ): widget.model['TourDetails'][0]
                  ['TourAddOn'].isNotEmpty?
                  Text(
                    "USD${widget.model['TotalActivityPrice']??''}",
                    style: AppTextStyle.textStyleBold16,
                  ):
                  Text(
                    "USD${widget.model['Price']??''}",
                    style: AppTextStyle.textStyleBold16,
                  ),
                  Text(
                    "onwards",
                    style: AppTextStyle.textStyleRegular12,
                  ),
                  14.height,
                  CustomButton(
                    buttonText: 'Next',
                    color: Colors.red,
                    height: 40,
                    width: Get.width * 0.40,
                    borderRadius: 4,
                    paddingHorizontal: 10.0,
                    onTap: () async {
                      var result = await Get.to(TourActivities(
                           model:widget.model,
                           isAddToPlannerVisible: widget.isAddToPlannerVisible,
                           tourPlannerDate: widget.tourPlannerDate,
                       ));

                      if (result != null) {
                        if (result == 1) {
                          Get.back(result: 1);
                        }
                      }
                    },
                  ),

                ],
              ),
            ),*/
                    ],
                  ),
                ),
        ));
  }


  showAlertDialogBox({value}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.black,
          content: Container(
            padding: const EdgeInsets.all(12.0),
            width: Get.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: AppTextStyle.textStyleRegular12
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
