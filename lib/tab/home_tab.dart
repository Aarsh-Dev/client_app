import 'package:client_app/constant/app_text_style.dart';
import 'package:client_app/constant/assets_path.dart';
import 'package:client_app/controller/tours_controller.dart';
import 'package:client_app/my_booking.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../more_activities_page.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  ToursController toursController = Get.find();


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widgetTopItems(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widgetBestOffer(),
                widgetTrendingRightNow(),
              ],
            ),
          ),
        ),
      ],
    );
  }


  Widget widgetTopItems(){
    return  Row(
      children: [
        topButton(
            imagePath: AssetPath.imgEdit,
            imgWidth: 18,
            title: "My Booking",
            onTap: (){
          Get.to(const MyBooking());
        }),
        topButton(
            imagePath: AssetPath.imgPlush,
            imgWidth: 20,
            title: "More Activities",
          onTap: (){
              toursController.getToursSearch();
              Get.to(const MoreActivitiesPage());
          }
        ),
        topButton(imagePath: AssetPath.imgCutlery,imgWidth:20,title: "Restaurants",onTap: (){

        }),
        topButton(imagePath: AssetPath.dealImg,imgWidth : 20,title: "Deals",onTap: (){}),
        // topButton(imagePath: AssetPath.imgReview,imgWidth : 20,title: "Experience"),
      ],
    );
  }

  topButton({required String imagePath,required String title,double? imgWidth, required Function() onTap}){
    return InkWell(
      onTap:(){
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Icon(icon,color: iconColor ?? Colors.black,size: 22),
            Image.asset(imagePath,width: imgWidth ?? 24),
            const SizedBox(
              height: 4,
            ),
            Text(title,textAlign: TextAlign.center,style: AppTextStyle.textStyleBold10,),
          ],
        ),
      ),
    );
  }

  Widget widgetBestOffer(){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text("Best Offer",style: AppTextStyle.textStyleBold14.copyWith(color: Colors.red),),
          ),
          const SizedBox(
            height: 10.0,
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Container(
                height: Get.height * 0.155,
                width: Get.width,
                decoration: BoxDecoration(
                  // color: Colors.blue,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image.asset(AssetPath.imgTestVilla,fit: BoxFit.cover,width:Get.width)),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image.asset(AssetPath.imgBehind,color: Colors.black38,fit: BoxFit.cover,width:Get.width)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Text("XOXO Tripe Offers",style: AppTextStyle.textStyleBold11.copyWith(color: Colors.white),)),
                          Text("Get up to 200 of with\ncode + pay",style: AppTextStyle.textStyleRegular10.copyWith(color: Colors.white),),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text("Get 200 via  Paytm for\nCash Back",style: AppTextStyle.textStyleRegular10.copyWith(color: Colors.white),),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }, separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10.0,
            );
          },)
        ],
      ),
    );
  }

  Widget widgetTrendingRightNow(){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14.0,horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text("Trending Right Now",style: AppTextStyle.textStyleBold14.copyWith(color: Colors.red),),
          ),
        ],
      ),
    );
  }


}
