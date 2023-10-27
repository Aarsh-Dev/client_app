import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_app/constant/app_colors.dart';
import 'package:client_app/constant/app_text_style.dart';
import 'package:client_app/constant/show_bottom_sheets.dart';
import 'package:client_app/constant/vars.dart';
import 'package:client_app/google_map/map_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoppingTab extends StatefulWidget {
  const ShoppingTab({Key? key}) : super(key: key);

  @override
  State<ShoppingTab> createState() => _ShoppingTabState();
}

class _ShoppingTabState extends State<ShoppingTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
      child:widgetShoppingList(),
    );
  }

  Widget widgetShoppingList(){
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.height * 0.25,
            child: ClipRRect(
              borderRadius:
              BorderRadius.circular(4),
              child: CachedNetworkImage(
                imageUrl:"https://assets.traveltriangle.com/blog/wp-content/uploads/2017/03/Sur-Wear.jpg",
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
            title:  Text("Beachwear: For Surfing Enthusiasts",
              style: AppTextStyle.textStyleBold16
                  .copyWith(
                  color: AppColor.themeColor),),
            subtitle:  widgetGeneratePromoButton(),
            trailing: IconButton(
              onPressed: (){
                Get.to(MapPage());
              },
              icon: const Icon(Icons.map_rounded,color:AppColor.bgAppBar,),
            ),
            contentPadding: EdgeInsets.zero,
          ),
        ],
      );
    },separatorBuilder: (context, index) {
      return Container(width: Get.width,color: Colors.grey.withOpacity(0.1),height: 1,margin: const EdgeInsets.only(bottom: 16),);
    });
  }

  Widget widgetGeneratePromoButton(){
    return Material(
      type: MaterialType.canvas,
      child: InkWell(
        onTap: (){
          ShowBottomSheets.generatePromoBottomSheet(context:context,isLoading:isPromoLoading);
          isPromoLoading.value = true;
          Future.delayed(const Duration(seconds: 1),() {
            isPromoLoading.value = false;
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


}
