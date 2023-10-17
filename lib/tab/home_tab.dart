import 'package:client_app/constant/app_colors.dart';
import 'package:client_app/constant/app_text_style.dart';
import 'package:client_app/constant/assets_path.dart';
import 'package:client_app/constant/method.dart';
import 'package:client_app/controller/tours_controller.dart';
import 'package:client_app/my_booking.dart';
import 'package:client_app/more_activities_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin{

  ToursController toursController = Get.find();


  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4,vsync: this);
    tabController.addListener(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // widgetTopItems(),
        widgetDemo(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widgetToday(),
                widgetBestOffer(),
              ],
            ),
          ),
        ),
      ],
    );
  }


  Widget widgetTopItems(){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              // Get.to(const MoreActivitiesPage());
          }
        ),
        topButton(imagePath: AssetPath.imgCutlery,imgWidth:20,title: "Restaurants",onTap: (){

        }),
        topButton(imagePath: AssetPath.dealImg,imgWidth : 20,title: "Deals",onTap: (){}),
        // topButton(imagePath: AssetPath.imgReview,imgWidth : 20,title: "Experience"),
      ],
    );
  }


  Widget widgetDemo(){
    return Container(
      height: 65,
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
      ),
      child: TabBar(
        controller: tabController,
        indicatorColor: Colors.transparent,
        labelStyle: const TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w600),
        labelColor: Colors.black,
        isScrollable: true,

        unselectedLabelStyle: const TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w600),
        onTap: (value){
          if(value == 0){
            Get.to(MyBooking());
          }else if(value == 1){
            toursController.getToursSearch();
            Get.to(MoreActivitiesPage());
          }
        },
        tabs: [
          Tab(
            text: "My Booking",
            icon: Image.asset(AssetPath.imgEdit,width: 20),
          ),
          Tab(
            text: "More Activities",
            icon: Image.asset(AssetPath.imgPlush,width: 20),
          ),
          Tab(
            text: "Restaurants",
            icon: Image.asset(AssetPath.imgCutlery,width: 20),
          ),
          Tab(
            text: "Deals",
            icon: Image.asset(AssetPath.dealImg,width: 20),
          ),
        ],
      ),
    );
  }

  Widget topButton({required String imagePath,required String title,double? imgWidth, required Function() onTap}){
    return InkWell(
      onTap:(){
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 0.0),
        constraints: BoxConstraints(
          // minWidth:60,
        ),
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

  Widget widgetTitle({text}){
    return Text("$text".toUpperCase(),style: AppTextStyle.textStyleBold14.copyWith(color: Colors.red,letterSpacing: 1));
  }

  Widget widgetToday(){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widgetTitle(text:"Your Today Program"),
          const SizedBox(
            height: 10.0,
          ),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: Colors.transparent)
            ),
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.zero,
            child: ExpansionTile(
              iconColor: Colors.red,
              collapsedIconColor: Colors.red,
              collapsedBackgroundColor: AppColor.themeColor,
              backgroundColor: AppColor.themeColor,
              title: Text(
                getDateInDDMMMYY(date:DateTime.now()),
                style: AppTextStyle.textStyleRegular12
                    .copyWith(color: Colors.white),
              ),
              children: [
                Container(
                  width: Get.width,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.arrow_forward,color: Colors.red,size: 16,),
                          Flexible(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: '09:00',style: AppTextStyle.textStyleBold10),
                                  TextSpan(
                                    text: ' - Pick Up From Bali Airport To Royal Hotel',
                                    style: AppTextStyle.textStyleRegular10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: [
                          const CircleAvatar(
                              backgroundColor: Color(0xffF1F3F4),
                              child: Icon(Icons.person,color: Color(0xffCAC5C5),)),
                          const SizedBox(
                            width: 8.0,
                          ),

                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget widgetBestOffer(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widgetTitle(text:"Offers"),
          const SizedBox(
            height: 10.0,
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            // padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
