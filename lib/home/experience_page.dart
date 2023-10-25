import 'package:client_app/constant/app_colors.dart';
import 'package:client_app/constant/app_text_style.dart';
import 'package:client_app/constant/assets_path.dart';
import 'package:client_app/experience/currency_converter_tab.dart';
import 'package:client_app/experience/night_life_tab.dart';
import 'package:client_app/experience/restaurants_tab.dart';
import 'package:client_app/experience/shopping_tab.dart';
import 'package:flutter/material.dart';

class ExperiencePage extends StatefulWidget {
  const ExperiencePage({Key? key}) : super(key: key);

  @override
  State<ExperiencePage> createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage>  with SingleTickerProviderStateMixin{


  late TabController tabController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Experience"),
        backgroundColor: AppColor.themeColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widgetTopBar(),
          Expanded(
            child: TabBarView(
              controller: tabController,
                children:const [
                   RestaurantsTab(),
                   NightLifeTab(),
                   ShoppingTab(),
                   CurrencyTab(),
                ]),
          ),
        ],
      ),
    );
  }


  Widget widgetTopBar(){
    return Container(
      height: 50,
      margin: const EdgeInsets.only(top: 8.0),
      decoration: const BoxDecoration(
      ),
      child: TabBar(
        controller: tabController,
        indicatorColor: Colors.transparent,
        labelStyle:AppTextStyle.textStyleBold10.copyWith(color: Colors.black),
        labelColor: Colors.black,
        isScrollable: true,
        unselectedLabelStyle: AppTextStyle.textStyleBold10.copyWith(color: Colors.black),
        unselectedLabelColor:Colors.black,
        // labelPadding: EdgeInsets.symmetric(horizontal: 14.0),
        tabs: [
          Tab(
            text: "Restaurants",
            icon: Image.asset(AssetPath.imgCutlery,width: 20),
          ),
          Tab(
            text: "Night Life",
            icon: Image.asset(AssetPath.imgNightLife,width: 20),
          ),
          Tab(
            text: "Shopping",
            icon: Image.asset(AssetPath.imgShopping,width: 20),
          ),
          Tab(
            text: "Currency Converter",
            icon: Image.asset(AssetPath.imgCurrency,width: 20),
          ),
        ],
      ),
    );
  }



}
