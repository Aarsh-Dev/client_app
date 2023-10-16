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
              height: 50,
              child: Image.asset(AssetPath.imgTestOffer,fit: BoxFit.cover,width: Get.width,),
            ),
           Padding(
             padding: EdgeInsets.symmetric(horizontal: 8.0),
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
                 TextFormField(
                   decoration: InputDecoration(
                     contentPadding: EdgeInsets.symmetric(vertical: 14.0),
                     enabledBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(5),
                     ),
                     focusedBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(5),
                     ),
                     errorBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(5),
                     ),
                   ),
                 ),
                 const SizedBox(
                   height: 5,
                 ),
                 Container(
                   width: Get.width,
                   padding: EdgeInsets.symmetric(vertical: 5.0),
                   decoration: BoxDecoration(
                       color: Colors.blue,
                       borderRadius: BorderRadius.circular(5.0)
                   ),
                   child: Center(
                     child: Text("Send me offer",style: AppTextStyle.textStyleBold10.copyWith(color: Colors.white),),
                   ),
                 ),
                 TextButton(onPressed: (){},
                     child: Text("No thanks, i dont want any exclusive offers",style: TextStyle( decoration: TextDecoration.underline,),))
               ],
             ),
           ),
          ],
        ),
      ),
    );
  }






}