import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_app/constant/app_colors.dart';
import 'package:client_app/constant/app_text_style.dart';
import 'package:client_app/constant/show_bottom_sheets.dart';
import 'package:client_app/controller/restaurants_controller.dart';
import 'package:client_app/map/map_page.dart';
import 'package:client_app/widget/custom_loader.dart';
import 'package:dotted_border/dotted_border.dart';
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
          lunchMealTypeDropDown(controller.textEditingController,"Restaurant Type"),
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
            subtitle: widgetGeneratePromoButton(),
            trailing: IconButton(
              onPressed: (){
                Get.to(MapPage());
              },
              icon: const Icon(Icons.map_rounded,color: AppColor.bgAppBar,),
            ),
            contentPadding: EdgeInsets.zero,
          ),
        ],
      );
    },separatorBuilder: (context, index) {
      return Container(width: Get.width,color: Colors.grey.withOpacity(0.1),height: 1,margin: const EdgeInsets.only(bottom: 16),);
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


  Widget widgetGeneratePromoButton(){
    return Material(
      type: MaterialType.canvas,
      child: InkWell(
        onTap: (){
          ShowBottomSheets.generatePromoBottomSheet(context:context,isLoading:controller.isPromoLoading);
          controller.isPromoLoading.value = true;
          Future.delayed(const Duration(seconds: 1),() {
            controller.isPromoLoading.value = false;
          },);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical:6.0,horizontal: 0),
          decoration: const BoxDecoration(),
          child: Text("Generate Promo code",style:AppTextStyle.textStyleBold10.copyWith(color: Colors.orange),),
        ),
      ),
    );
  }


  openBottomSheet(){
     showModalBottomSheet(context: context, builder: (context) {
      return Container(
        height: Get.height *0.25,
        width: Get.width,
        child: Obx(()=>controller.isPromoLoading.value ? const CustomLoader():Column(
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
