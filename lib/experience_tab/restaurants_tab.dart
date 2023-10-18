import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_app/constant/app_colors.dart';
import 'package:client_app/constant/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantsTab extends StatefulWidget {
  const RestaurantsTab({Key? key}) : super(key: key);

  @override
  State<RestaurantsTab> createState() => _RestaurantsTabState();
}

class _RestaurantsTabState extends State<RestaurantsTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: widgetRestaurantsList(),
    );
  }


  Widget widgetRestaurantsList(){
    return ListView.builder(
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
              icon: const Icon(Icons.map_rounded,color: Colors.blue,),
            ),
            contentPadding: EdgeInsets.zero,
          ),
        ],
      );
    },);
  }

}
