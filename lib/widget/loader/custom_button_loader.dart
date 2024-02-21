import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButtonLoader extends StatelessWidget {

  final double height;
  final double? width;
  final Color? color;
  const CustomButtonLoader({
    Key? key,
    this.height=50,
    this.width,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? Colors.red,
      child: SizedBox(
        height:height,
        width:width ?? Get.width,
        child: const Center(
            child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,))),
      ),
    );
  }
}
