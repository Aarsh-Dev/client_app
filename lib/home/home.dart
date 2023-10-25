import 'package:client_app/constant/app_colors.dart';
import 'package:client_app/constant/app_text_style.dart';
import 'package:client_app/constant/show_dialog.dart';
import 'package:client_app/controller/home_controller.dart';
import 'package:client_app/home/home_bottom_tab/chart_tab.dart';
import 'package:client_app/home/home_bottom_tab/helpline_tab.dart';
import 'package:client_app/home/home_bottom_tab/home_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>  {



 HomeController controller = Get.find();

 List<Widget> listOfTab = [
  const HomeTab(),
  const HelpLineTab(),
  const ChartTab(),
 ];

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ShowDialogs.showExclusiveOfferDialog(context:context);
    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.themeColor,
        automaticallyImplyLeading: false,
        title: const Text("Agent Logo"),
      ),
      body: Obx(()=>listOfTab.elementAt(controller.position.value),),
      bottomNavigationBar: Obx(()=>BottomNavigationBar(
        unselectedItemColor: AppColor.themeColor,
        selectedItemColor: Colors.red,
        selectedLabelStyle: AppTextStyle.textStyleRegular12,
        unselectedLabelStyle:AppTextStyle.textStyleRegular12,
        // unselectedLabelStyle: TextStyle(letterSpacing:0.5),
        currentIndex: controller.position.value,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color:controller.position.value == 0 ?AppColor.bgAppBar:AppColor.themeColor,),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_center,color:controller.position.value == 1 ?AppColor.bgAppBar:AppColor.themeColor,),
            label: "Helpline",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat,color:controller.position.value == 2 ?AppColor.bgAppBar:AppColor.themeColor,),
            label: "Chat U & I",
          ),
        ],
        onTap: (val){
          controller.position.value = val;
        },
      ),),
    );
  }





}
