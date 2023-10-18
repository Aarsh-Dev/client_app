import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_app/constant/app_colors.dart';
import 'package:client_app/constant/app_text_style.dart';
import 'package:client_app/controller/restaurants_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantsTab extends StatefulWidget {
  const RestaurantsTab({Key? key}) : super(key: key);

  @override
  State<RestaurantsTab> createState() => _RestaurantsTabState();
}

class _RestaurantsTabState extends State<RestaurantsTab> {

  RestaurantsController controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getMealsType();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10.0,
          ),
          lunchMealTypeDropDown(controller.textEditingController,"Meal"),
          const SizedBox(
            height: 10.0,
          ),
          widgetRestaurantsList(),
        ],
      ),
    );
  }


  Widget widgetRestaurantsList(){
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder:(context, index) {
      return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.height * 0.25,
            child: ClipRRect(
              borderRadius:
              BorderRadius.circular(4),
              child: CachedNetworkImage(
                imageUrl:"https://a.cdn-hotels.com/gdcs/production51/d92/c8d8e2c5-91fe-4c7b-bbfe-6015930c88aa.jpg?impolicy=fcrop&w=1600&h=1066&q=medium",
                fit: BoxFit.cover,
                height: Get.height * 0.25,
                width: Get.width,
                placeholder: (context, url) {
                  return Opacity(
                      opacity: 0.20,
                      child: Image.network(
                          "https://uandiholidays.net/images/nelo1.png"));
                },
                errorWidget:
                    (context, url, error) {
                  return Opacity(
                      opacity: 0.20,
                      child: Image.network(
                          "https://uandiholidays.net/images/nelo1.png"));
                },
              ),
            ),
          ),
          ListTile(
            title:  Text("Jimbaran seafood cafes",
              style: AppTextStyle.textStyleBold16
                  .copyWith(
                  color: AppColor.themeColor),),
            subtitle:  Text("Generate Promo code",style:AppTextStyle.textStyleBold10.copyWith(color: Colors.orange),),
            trailing: IconButton(
              onPressed: (){},
              icon: const Icon(Icons.map_rounded,color: AppColor.bgAppBar,),
            ),
            contentPadding: EdgeInsets.zero,
          ),
        ],
      );
    },separatorBuilder: (context, index) {
      return Container(width: Get.width,color: Colors.grey.withOpacity(0.1),height: 1,margin: EdgeInsets.only(bottom: 16),);
    },);
  }

  //Todo Lunch Meal Type
  Widget lunchMealTypeDropDown(TextEditingController mealTypeController, String hint) {
    return Obx(() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColor.hintColor, width: 1)),
        child: DropdownButton<dynamic>(
          hint: Text(
            mealTypeController.text.isEmpty ? hint : mealTypeController.text,
            style: mealTypeController.text.isEmpty
                ? AppTextStyle.textStyleRegular12
                .copyWith(color: AppColor.hintColor)
                : AppTextStyle.textStyleRegular12,
          ),
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          underline: const SizedBox.shrink(),
          onChanged: (value) {
            mealTypeController.text = value['MealType'].toString();
            setState(() {

            });
          },
          isExpanded: true,
          borderRadius: BorderRadius.circular(10),
          items: controller.lunchMealTypeList
              .map<DropdownMenuItem<dynamic>>((dynamic value) {
            return DropdownMenuItem<dynamic>(
              value: value,
              child: Text(
                value['MealType'].toString(),
                style: AppTextStyle.textStyleRegular12,
              ),
            );
          }).toList(),
        )));
  }

}
