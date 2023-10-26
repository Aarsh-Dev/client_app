import 'package:client_app/constant/app_colors.dart';
import 'package:client_app/constant/assets_path.dart';
import 'package:client_app/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColor.bg,
          systemNavigationBarIconBrightness: Brightness.light
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Image.asset(AssetPath.appLogo),
      ),
    );
  }

  timer(){
    Future.delayed(const Duration(seconds: 3),() {
      Get.off(const Home());
    },);
  }


}
