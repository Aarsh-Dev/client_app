import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_app/constant/app_colors.dart';
import 'package:client_app/constant/app_text_style.dart';
import 'package:client_app/constant/method.dart';
import 'package:client_app/controller/tours_controller.dart';
import 'package:client_app/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TourDetail extends StatefulWidget {
  final dynamic model;
  const TourDetail({Key? key,this.model}) : super(key: key);

  @override
  State<TourDetail> createState() => _TourDetailState();
}

class _TourDetailState extends State<TourDetail> {

  ToursController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xffF0F0F0),
      appBar: AppBar(
        backgroundColor: AppColor.themeColor,
        elevation: 0,
        centerTitle: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.model['TourTitle']??'',
              style: AppTextStyle.textStyleRegular16
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {

              },
              icon: const Icon(
                Icons.abc,
                color: AppColor.themeColor,
              ))
        ],
      ),
      body: DefaultTabController(
        length: controller.tabList.length,
        initialIndex: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: Get.height * 0.30,
              child: CachedNetworkImage(
                // imageUrl:"https://uandiholidays.net/Admin/UploadFiles/Tour/Image/banana-boat.png",
                imageUrl: widget.model
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
            Container(
              color: AppColor.themeColor,
              width: Get.width,
              child: TabBar(
                  isScrollable: true,
                  indicatorColor: AppColor.whiteColor,
                  onTap: (index) {
                    controller.currentIndex.value = index;
                    // setState(() {});
                  },
                  tabs: controller.tabList),
            ),
            Expanded(
                child: TabBarView(
                    children:[
                      widgetDescription(),
                      widgetItinerary(),
                      widgetDoAndDont(),
                    ]))
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: 55,
        elevation: 10,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 16.0,
            ),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.model['TourDetails'][0]
                    ['TourUpgrade']
                        .isNotEmpty?
                    Text(
                      "USD${widget.model['TotalPrice']??''}",
                      style: AppTextStyle.textStyleBold16,
                    ): widget.model['TourDetails'][0]
                    ['TourAddOn']
                        .isNotEmpty?
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
                    )
                  ],
                )),
            CustomButton(
              buttonText: 'Select Tour',
              color: Colors.red,
              height: 40,
              width: Get.width * 0.40,
              borderRadius: 4,
              paddingHorizontal: 10.0,
              onTap: () {

              },
            ),
            const SizedBox(
              width: 16.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget widgetDescription(){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: Text("${convertHtmlToString(htmlValue:widget.model['Desc']??'')}"))
        ],
      ),
    );
  }

  Widget widgetItinerary(){
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
      Text("Itinerary")
      ],
    );
  }

  Widget widgetDoAndDont(){
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("DoAndDont")
      ],
    );
  }

}
