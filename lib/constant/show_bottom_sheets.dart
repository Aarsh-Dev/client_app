import 'package:client_app/constant/app_colors.dart';
import 'package:client_app/constant/app_text_style.dart';
import 'package:client_app/widget/custom_loader.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowBottomSheets{


  ShowBottomSheets._();



  static generatePromoBottomSheet({context,RxBool? isLoading}){
    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        height: Get.height *0.25,
        width: Get.width,
        child: Obx(()=>isLoading!.value ? const CustomLoader():Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DottedBorder(
                color: Colors.black,
                borderPadding: EdgeInsets.zero,
                // strokeCap: StrokeCap.round,
                // borderType: BorderType.,
                strokeWidth: 1,
                child: Container(
                  color: AppColor.themeColor,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                  child: Text("A14rH",style: AppTextStyle.textStyleBold14.copyWith(color: Colors.white,letterSpacing: 2),),
                ))
          ],
        )),
      );
    },);
  }




}