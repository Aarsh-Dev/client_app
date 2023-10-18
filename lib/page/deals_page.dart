import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_app/constant/app_colors.dart';
import 'package:client_app/constant/app_text_style.dart';
import 'package:client_app/constant/assets_path.dart';
import 'package:client_app/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DealsPage extends StatefulWidget {
  const DealsPage({Key? key}) : super(key: key);

  @override
  State<DealsPage> createState() => _DealsPageState();
}

class _DealsPageState extends State<DealsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Deals"),
        backgroundColor: AppColor.themeColor,
      ),
      body: SingleChildScrollView(
        child:widgetItems(),
      )
    );
  }

  Widget widgetItems(){
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 14.0),
            decoration: const BoxDecoration(
                color: Colors.white
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: CachedNetworkImage(
                        imageUrl:"https://pyt-images.imgix.net/images/campaignitinerary/nusapenida.jpeg?auto=format&fit=crop&crop=edges&w=345&h=168&q=100&dpr=2",
                        fit: BoxFit.cover,
                        height: Get.height * 0.09,
                        width: Get.width * 0.30,
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
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Eat Pray Love: Bali Package with Nusa Penida",style: AppTextStyle.textStyleBold14.copyWith(color: AppColor.themeColor),),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text("5 Nights",style: AppTextStyle.textStyleRegular11.copyWith(color: Colors.grey),),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Buffet Offer",style: AppTextStyle.textStyleRegular13,),
                          const SizedBox(
                            height: 6.0,
                          ),
                          Text.rich(
                              TextSpan(
                                  text: "\₹38499",style: AppTextStyle.textStyleBold12,
                                  children: const [
                                    TextSpan(
                                        text: ""
                                    ),
                                  ]
                              ))
                        ],
                      ),
                    ),
                    CustomButton(
                        buttonText:"View".toUpperCase(),
                        height: 30,
                        color: Colors.red,
                        style: AppTextStyle.textStyleBold10.copyWith(color: Colors.white),
                        onTap: (){

                        })
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 14.0),
            decoration: const BoxDecoration(
                color: Color(0xffF7F7F7),
                border:Border(
                    bottom: BorderSide(color: Colors.black26)
                )
            ),
            child: Row(
              children: [
                Expanded(child: Text("14 Bought",style: AppTextStyle.textStyleRegular11,)),
                Text("Add to favourites",style: AppTextStyle.textStyleRegular11),
                const SizedBox(
                  width: 5.0,
                ),
                Image.asset(AssetPath.imgUnselectLike,color: Colors.red,width: 14,height: 14,),
              ],
            ),
          ),
        ],
      );
    },);
  }

}
