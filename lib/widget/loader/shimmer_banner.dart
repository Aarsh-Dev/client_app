import 'package:client_app/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';


class ShimmerBanner extends StatelessWidget {
  const ShimmerBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.themeColor,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.30),
        highlightColor: Colors.grey.withOpacity(0.10),
        child:  Container(
          width:Get.width < 900
              ? Get.width * 0.99
              : Get.width,
          height: 170,
          color: Colors.white,
        ),
      ),
    );
  }
}
