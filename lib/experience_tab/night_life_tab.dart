import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_app/constant/app_colors.dart';
import 'package:client_app/constant/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NightLifeTab extends StatefulWidget {
  const NightLifeTab({Key? key}) : super(key: key);

  @override
  State<NightLifeTab> createState() => _NightLifeTabState();
}

class _NightLifeTabState extends State<NightLifeTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child:widgetNightsLifeList(),
    );
  }

  Widget widgetNightsLifeList(){
    return ListView.builder(
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
                imageUrl:"https://assets.traveltriangle.com/blog/wp-content/uploads/2015/08/Vertical-Point-in-Bali-.jpg",
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
            title:  Text("Rooftop Bars",
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
    },);
  }

}
