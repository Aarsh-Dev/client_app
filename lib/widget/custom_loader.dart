import 'package:client_app/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      color: Colors.white,
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColor.themeColor,
        ),
      ),
    );
  }
}
