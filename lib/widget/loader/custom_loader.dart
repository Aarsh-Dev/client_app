import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CustomLoader extends StatelessWidget {
  final double? height;

  const CustomLoader({Key? key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.all(16),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.30),
        highlightColor: Colors.grey.withOpacity(0.10),
        child: ListView.separated(
          itemCount: 2,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: Get.width,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4)),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                    width: Get.width * 0.50,
                    height: 20,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4))),
                const SizedBox(
                  height: 16,
                ),
                Container(
                    width: Get.width * 0.20,
                    height: 20,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4))),
              ],
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
    );
    // return Center(child: CircularProgressIndicator(color: Colors.red),);
  }
}