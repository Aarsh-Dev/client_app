import 'package:client_app/constant/app_text_style.dart';
import 'package:client_app/constant/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowDialogs{

  ShowDialogs._();



  static showExclusiveOfferDialog({context}){
    return   showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60,
              child: Image.asset(AssetPath.imgTestOffer,fit: BoxFit.cover,width: Get.width,),
            ),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 8.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text("Exclusive Offer For You!",style: AppTextStyle.textStyleBold14,),
                 const SizedBox(
                   height: 5,
                 ),
                 Text("Get exciting offer delivered direct to your inbox",style: AppTextStyle.textStyleRegular14.copyWith(color: Colors.grey),),
                 const SizedBox(
                   height: 5,
                 ),
                 const SizedBox(
                   height: 5,
                 ),
                 Container(
                   height: 40,
                   width: Get.width,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(5.0),
                     border: Border.all(color: Colors.black26)
                   ),
                   child: TextFormField(
                     decoration: InputDecoration(
                       contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
                       hintText: "Enter your email",
                       hintStyle: TextStyle(fontSize: 14),
                       enabledBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(5),
                         borderSide: BorderSide.none
                       ),
                       focusedBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(5),
                           borderSide: BorderSide.none
                       ),
                       errorBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(5),
                           borderSide: BorderSide.none
                       ),
                     ),
                   ),
                 ),
                 const SizedBox(
                   height: 5,
                 ),
                 Container(
                   width: Get.width,
                   padding: const EdgeInsets.symmetric(vertical: 6.0),
                   decoration: BoxDecoration(
                       color: Colors.blue,
                       borderRadius: BorderRadius.circular(5.0)
                   ),
                   child: Center(
                     child: Text("Send me offer",style: AppTextStyle.textStyleBold11.copyWith(color: Colors.white),),
                   ),
                 ),
                 TextButton(onPressed: (){
                   Get.back();
                 },
                     child: const Text("No thanks, i dont want any exclusive offers",style: TextStyle( decoration: TextDecoration.underline,color: Colors.grey),))
               ],
             ),
           ),
          ],
        ),
      ),
    );
  }






}