import 'dart:convert';
import 'package:client_app/constant/app_colors.dart';
import 'package:client_app/constant/app_text_style.dart';
import 'package:client_app/controller/more_activity_controller.dart';
import 'package:client_app/home/home.dart';
import 'package:client_app/home/more_activities/tour_view.dart';
import 'package:client_app/home/more_activities/tours_list.dart';
import 'package:client_app/widget/custom_button.dart';
import 'package:client_app/widget/loader/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class MultipleToursBooking extends StatefulWidget {
  const MultipleToursBooking( {Key? key}) : super(key: key);

  @override
  State<MultipleToursBooking> createState() => _MultipleToursBookingState();
}

class _MultipleToursBookingState extends State<MultipleToursBooking> {

  MoreActivitiesController controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint(jsonEncode(controller.selectedTourList));
    controller.getTourServiceCharges();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async => false,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.themeColor,
            elevation: 0,
            centerTitle: false,
            leading: IconButton(
              onPressed: (){
                Get.offAll(const Home());
              },
              icon: const Icon(Icons.home,color: Colors.white,),
            ),
            title:  Text(
               "Tour Detail",
                style: AppTextStyle.appbarTextStyle
            ),
          ),
          body:Obx(() => controller.isTourSummaryLoading.value? const CustomLoader():AnimatedListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: controller.selectedTourList.length,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            slideConfiguration: SlideConfiguration(
                verticalOffset: 400, delay: const Duration(milliseconds: 50)),
            itemBuilder: (_, index) => Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 8, top: 8),
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  TourView(
                    price: getPrice(controller.selectedTourList[index]['Price'].toString().replaceAll("USD", "").trim(),controller.selectedTourList[index]),
                    // price: controller.selectedTourList[index]['Price']??'',
                    hotelName: controller.selectedTourList[index]['TourTitle']??'',
                    startRating: "",
                    image:controller.selectedTourList[index]['TourImg']??'',
                    onTap: (){

                    },
                  ),
                  4.height,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Includes : ",
                          style: AppTextStyle.textStyleRegular13),
                      Flexible(
                          child: Html(
                            data:
                            // controller.selectedTourList[index]['TourEntrance'].isEmpty?"-":
                            getIncludes(
                                controller.selectedTourList[index]['TourEntrance'].isEmpty ? "":
                                controller.selectedTourList[index]['TourEntrance'][0]['Entrance'].toString().replaceAll("Includes :", ""),
                                controller.selectedTourList[index]),style: {
                            "body": Style(
                              fontSize: FontSize(13.0),
                              margin: Margins.zero,

                            ),
                          },)),
                    ],
                  ),
                  10.height,
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child:  Text("Date : ${controller.selectedTourList[index]['TourInDate']??''}", style: AppTextStyle.textStyleRegular13),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child:  Text(/*getNoOfPax()*/"1", style: AppTextStyle.textStyleRegular13),
                  ),


                  Container(
                    color: const Color(0xffe5e5e5),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [

                        Expanded(
                            child: Text("Type",textAlign: TextAlign.center,
                                style: AppTextStyle.textStyleRegular12)),
                        Expanded(
                            child: Text("Pick Up",textAlign: TextAlign.center,
                                style: AppTextStyle.textStyleRegular12)),
                        Expanded(
                            child: Text("Basis",textAlign: TextAlign.center,
                                style: AppTextStyle.textStyleRegular12)),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black12, width: 1)),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(controller.selectedTourList[index]['TourTypeName'].toString().replaceAll("(", "").replaceAll(")", ""),textAlign: TextAlign.center,
                                style: AppTextStyle.textStyleRegular12)),
                        Expanded(
                            child: Text("Pick Up",textAlign: TextAlign.center,
                                style: AppTextStyle.textStyleRegular12)),
                        Expanded(
                            child: Text("${controller.selectedTourList[index]['TourDetails'][0]['TourType']??''}",textAlign: TextAlign.center,
                                style: AppTextStyle.textStyleRegular12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
          bottomNavigationBar:Obx(()=>controller.isTourSummaryLoading.value?const SizedBox.shrink():
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Price : ",
                                style: AppTextStyle.textStyleBold14,
                              ),
                              Text(
                                getTotalPrice(),
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          // Obx(() => Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //       "Total Price : ",
                          //       style: AppTextStyle.textStyleBold14,
                          //     ),
                          //     Text(
                          //       getTotalPrice(),
                          //       style: const TextStyle(
                          //           fontSize: 14, fontWeight: FontWeight.bold),
                          //     ),
                          //   ],
                          // ),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text("Transaction Charges", style: AppTextStyle.textStyleBold14,),
                                  IconButton(
                                      onPressed: () {
                                        showTransactionChargesPopup();
                                      },
                                      icon: const Icon(Icons.info_sharp))
                                ],
                              ),
                              // Text("USD 20", style: AppTextStyle.textStyleBold14,)
                              Obx(() => controller.serviceCharge.value=="0"?Text("USD 0",style: AppTextStyle.textStyleBold14,): Text("USD ${double.parse(controller.serviceCharge.value).toStringAsFixed(0)}", style: AppTextStyle.textStyleBold14,),)
                            ],
                          ),
                          // Obx(() => Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //       "Grand Total : ",
                          //       style: AppTextStyle.textStyleBold14,
                          //     ),
                          //     Text(
                          //       getGrandTotalPrice(),
                          //       // "USD ${controller.bookingToursGrandTotal.value.toString()}",
                          //       style: const TextStyle(
                          //           color: Colors.red,
                          //           fontSize: 14,
                          //           fontWeight: FontWeight.bold),
                          //     ),
                          //   ],
                          // ),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Grand Total : ",
                                style: AppTextStyle.textStyleBold14,
                              ),
                              Text(
                                getGrandTotalPrice(),
                                // "USD ${controller.bookingToursGrandTotal.value.toString()}",
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      )),
                  Row(
                    children: [
                      8.width,
                      Expanded(child:  CustomButton(
                        width: Get.width,
                        borderRadius: 4,
                        style: AppTextStyle.textStyleBold14.copyWith(color: Colors.white),
                        buttonText: "Add More Tour",
                        onTap: () {
                          controller.getToursSearch();
                          Get.to(const ToursList());
                        },
                        color: Colors.red,
                      ), ),
                      8.width,
                      Expanded(child:  CustomButton(
                        width: Get.width,
                        borderRadius: 4,
                        style: AppTextStyle.textStyleBold14.copyWith(color: Colors.white),
                        buttonText: "Confirm Booking",
                        onTap: () {
                          controller.tourAddToPlannerCart(tour: controller.selectedTourList, isMultiple: true);
                          // Get.to(const TourGuestDetails());
                        },
                        color: Colors.red,
                      ), ),
                      8.width,
                    ],
                  ),
                ],
              ),
            ),
          ),)
      ),
    );
  }

  showTransactionChargesPopup() {

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.black,
          content: SizedBox(
            width: Get.width,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Transaction Fees not applicable if you book entire package with us",
                      style: AppTextStyle.textStyleRegular12
                          .copyWith(color: Colors.white))
                ]
            ).paddingAll(8),
          ),
        );
      },
    );

  }


  confirmBooking(text, text1) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Text(text, style: AppTextStyle.textStyleRegular11),
          Flexible(child: Text(text1, style: AppTextStyle.textStyleRegular11)),
        ],
      ),
    );
  }

  // String getNoOfPax() {
  //   String adult="";
  //   String child="";
  //   String infant="";
  //   if(controller.transferController.adultsTextEditingController.text!="0"){
  //     adult="${controller.transferController.adultsTextEditingController.text}A";
  //   }
  //   if(controller.transferController.txtChildController.text!=""){
  //     child="${controller.transferController.txtChildController.text}C";
  //   }
  //   if(controller.transferController.txtInfantController.text!=""){
  //     infant="${controller.transferController.txtInfantController.text}I";
  //   }
  //   String returnText="";
  //   if(adult.isNotEmpty){
  //     returnText=adult;
  //     if(child.isNotEmpty){
  //       returnText="$returnText+$child";
  //     }
  //     if(infant.isNotEmpty){
  //       returnText="$returnText+$infant";
  //     }
  //   }
  //
  //   return "No Of Pax : $returnText";
  // }

  String getPrice(String tourPrice, singleTour) {
    int price=int.parse(tourPrice);


    if(singleTour['TourDetails'][0]['TourAddOn'].isNotEmpty){
      for(int k=0;k<singleTour['TourDetails'][0]['TourAddOn'].length;k++){
        price=price+int.parse(singleTour['TourDetails'][0]['TourAddOn'][k]['TotAdultPrc']??"0");
        price=price+int.parse(singleTour['TourDetails'][0]['TourAddOn'][k]['TotChildPrc']??"0");
      }
    }

    if(singleTour['TourDetails'][0]['TourUpgrade'].isNotEmpty){
      for(int k=0;k<singleTour['TourDetails'][0]['TourUpgrade'].length;k++){
        price=price+int.parse(singleTour['TourDetails'][0]['TourUpgrade'][k]['TotAdultPrc']??"0");
        price=price+int.parse(singleTour['TourDetails'][0]['TourUpgrade'][k]['TotChildPrc']??"0");
      }
    }

    return "$price";
  }

  String getIncludes(String defaultIncludes, singleTour) {
    List<String> includes=[];
    if(defaultIncludes != ""){
      includes.add(defaultIncludes);
    }


    if(singleTour['TourDetails'][0]['TourAddOn'].isNotEmpty){
      for(int k=0;k<singleTour['TourDetails'][0]['TourAddOn'].length;k++){
        includes.add(singleTour['TourDetails'][0]['TourAddOn'][k]['AddonName']);
      }
    }

    if(singleTour['TourDetails'][0]['TourUpgrade'].isNotEmpty){
      for(int k=0;k<singleTour['TourDetails'][0]['TourUpgrade'].length;k++){
        includes.add(singleTour['TourDetails'][0]['TourUpgrade'][k]['Update']);
      }
    }

    return includes.join(",");
  }

  String getTotalPrice() {
    int price=0;
    for(int i=0;i<controller.selectedTourList.length;i++){
      price=price+int.parse(controller.selectedTourList[i]['Price'].toString().replaceAll("USD", "").trim());
      if(controller.selectedTourList[i]['TourDetails'][0]['TourAddOn'].isNotEmpty){
        for(int k=0;k<controller.selectedTourList[i]['TourDetails'][0]['TourAddOn'].length;k++){
          price=price+int.parse(controller.selectedTourList[i]['TourDetails'][0]['TourAddOn'][k]['TotAdultPrc']??"0");
          price=price+int.parse(controller.selectedTourList[i]['TourDetails'][0]['TourAddOn'][k]['TotChildPrc']??"0");
          // price=price+int.parse(controller.selectedTourList[i]['TourDetails'][0]['TourAddOn'][k]['AdultPrc']??"0");
        }

      }

      if(controller.selectedTourList[i]['TourDetails'][0]['TourUpgrade'].isNotEmpty){
        for(int k=0;k<controller.selectedTourList[i]['TourDetails'][0]['TourUpgrade'].length;k++){
          price=price+int.parse(controller.selectedTourList[i]['TourDetails'][0]['TourUpgrade'][k]['TotAdultPrc']??"0");
          price=price+int.parse(controller.selectedTourList[i]['TourDetails'][0]['TourUpgrade'][k]['TotChildPrc']??"0");
          // price=price+int.parse(controller.selectedTourList[i]['TourDetails'][0]['TourUpgrade'][k]['AdultPrc']);
        }

      }

    }

    return "USD $price";
  }

  String getGrandTotalPrice() {
    int price=0;
    for(int i=0;i<controller.selectedTourList.length;i++){
      price=price+int.parse(controller.selectedTourList[i]['Price'].toString().replaceAll("USD", "").trim());
      if(controller.selectedTourList[i]['TourDetails'][0]['TourAddOn'].isNotEmpty){
        for(int k=0;k<controller.selectedTourList[i]['TourDetails'][0]['TourAddOn'].length;k++){
          price=price+int.parse(controller.selectedTourList[i]['TourDetails'][0]['TourAddOn'][k]['TotAdultPrc']??"0");
          price=price+int.parse(controller.selectedTourList[i]['TourDetails'][0]['TourAddOn'][k]['TotChildPrc']??"0");
          // price=price+int.parse(controller.selectedTourList[i]['TourDetails'][0]['TourAddOn'][k]['AdultPrc']??"0");
        }

      }

      if(controller.selectedTourList[i]['TourDetails'][0]['TourUpgrade'].isNotEmpty){
        for(int k=0;k<controller.selectedTourList[i]['TourDetails'][0]['TourUpgrade'].length;k++){
          price=price+int.parse(controller.selectedTourList[i]['TourDetails'][0]['TourUpgrade'][k]['TotAdultPrc']??"0");
          price=price+int.parse(controller.selectedTourList[i]['TourDetails'][0]['TourUpgrade'][k]['TotChildPrc']??"0");
          // price=price+int.parse(controller.selectedTourList[i]['TourDetails'][0]['TourUpgrade'][k]['AdultPrc']);
        }

      }

    }
    price=price+20;
    return "USD $price";
  }
}
