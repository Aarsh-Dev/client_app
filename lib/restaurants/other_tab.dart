import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_app/constant/app_colors.dart';
import 'package:client_app/constant/app_text_style.dart';
import 'package:client_app/constant/show_bottom_sheets.dart';
import 'package:client_app/constant/vars.dart';
import 'package:client_app/google_map/map_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtherTab extends StatefulWidget {
  const OtherTab({Key? key}) : super(key: key);

  @override
  State<OtherTab> createState() => _OtherTabState();
}

class _OtherTabState extends State<OtherTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widgetRestaurantsList(),
        ],
      ),
    );
  }

  Widget widgetRestaurantsList() {
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
                borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  imageUrl:
                  "https://a.cdn-hotels.com/gdcs/production51/d92/c8d8e2c5-91fe-4c7b-bbfe-6015930c88aa.jpg?impolicy=fcrop&w=1600&h=1066&q=medium",
                  fit: BoxFit.cover,
                  height: Get.height * 0.25,
                  width: Get.width,
                  placeholder: (context, url) {
                    return Opacity(
                        opacity: 0.20,
                        child: Image.network(
                            "https://uandiholidays.net/images/nelo1.png"));
                  },
                  errorWidget: (context, url, error) {
                    return Opacity(
                        opacity: 0.20,
                        child: Image.network(
                            "https://uandiholidays.net/images/nelo1.png"));
                  },
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Jimbaran seafood cafes",
                style: AppTextStyle.textStyleBold16
                    .copyWith(color: AppColor.themeColor),
              ),
              subtitle: widgetGeneratePromoButton(),
              trailing: IconButton(
                onPressed: () {
                  Get.to(MapPage());
                },
                icon: const Icon(
                  Icons.map_rounded,
                  color: AppColor.bgAppBar,
                ),
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return Container(
          width: Get.width,
          color: Colors.grey.withOpacity(0.1),
          height: 1,
          margin: const EdgeInsets.only(bottom: 16),
        );
      },
    );
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
