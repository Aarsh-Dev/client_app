import 'package:client_app/constant/app_colors.dart';
import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColor.themeColor,
      ),
    );
  }
}
