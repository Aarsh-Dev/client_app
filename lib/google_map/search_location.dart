import 'package:client_app/constant/app_text_style.dart';
import 'package:client_app/controller/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchLocation extends StatefulWidget {
  const SearchLocation({Key? key}) : super(key: key);

  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  MapController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leadingWidth: 0,
          elevation: 0,
          // leadingWidth: 20.0,
          titleSpacing: 0,
          title: Container(
            color: Colors.white,
            child: TextField(
                controller: controller.searchTextEditingController,
                textAlignVertical: TextAlignVertical.center,
                maxLines: 1,
                onChanged: (value) {
                  if (controller.searchTextEditingController.text.isNotEmpty) {
                    controller.isShowCancelIcon.value = true;
                  } else {
                    controller.isShowCancelIcon.value = false;
                  }
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 5.0),
                    hintText: "Search",
                    focusedBorder:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    enabledBorder:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    prefixIcon: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                    suffixIcon: Obx(() => controller.isShowCancelIcon.value
                        ? IconButton(
                            onPressed: () {
                              controller.isSearch.value = false;
                            },
                            icon: const Icon(
                              Icons.cancel_outlined,
                              color: Colors.black,
                            ))
                        : const SizedBox.shrink())),
                style: AppTextStyle.textStyleRegular14),
          )),
      body: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        itemCount: 5 ,
        itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(
              backgroundColor: Color(0xffF1F3F4),
              child: Icon(Icons.location_on_outlined,color: Colors.black,)),
          title: Text("Jahangirpura",style: AppTextStyle.textStyleBold12,),
          subtitle: Text("Surat,Gujarat",style: AppTextStyle.textStyleRegular11,),
        );
      },),
    );
  }
}
