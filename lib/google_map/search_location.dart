import 'dart:convert';
import 'dart:math';
import 'package:client_app/constant/app_colors.dart';
import 'package:client_app/constant/app_text_style.dart';
import 'package:client_app/constant/vars.dart';
import 'package:client_app/controller/map_controller.dart';
import 'package:client_app/model/model_suggetion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:location_geocoder/location_geocoder.dart';

class SearchLocation extends StatefulWidget {
  final LocationData currentLocation;
  const SearchLocation({Key? key,required this.currentLocation}) : super(key: key);

  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {

  MapController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
          // backgroundColor:AppColor.themeColor,
          leadingWidth: 0,
          flexibleSpace: Container(
            color: Colors.white,
          ),
          elevation: 0,
          // leadingWidth: 20.0,
          titleSpacing: 0,
          title: Container(
            color: Colors.white,
            child: TextField(
                controller: controller.searchTextEditingController,
                textAlignVertical: TextAlignVertical.center,
                maxLines: 1,
                cursorColor: Colors.black,
                onChanged: (value) {
                  // fetchSuggestions(value,"hospital");
                  // fetchSuggestions(value,"bank");
                  fetchSuggestions(value);
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
                              controller.searchTextEditingController.clear();
                              controller.isSearch.value = false;
                            },
                            icon: const Icon(
                              Icons.cancel_outlined,
                              color: Colors.black,
                            ))
                        : const SizedBox.shrink())),
                style: AppTextStyle.textStyleRegular14),
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          controller.isSourceDestination.value ? const SizedBox(
            height: 30.0,
          ):const SizedBox.shrink(),
          controller.isSourceDestination.value ?
          InkWell(
            onTap: () async {
              final LocatitonGeocoder geocoder = LocatitonGeocoder(apiKey);
              var address = await geocoder.findAddressesFromCoordinates(Coordinates(widget.currentLocation.latitude,widget.currentLocation.longitude));
               Get.back(result:ModelSuggestion("",address[1].addressLine??"", address[1].featureName??"", address[1].addressLine??"",LatLng(address[1].coordinates.latitude!,address[1].coordinates.longitude!)));
            },
            child: Material(
              type: MaterialType.canvas,
              child: Container(
                width: Get.width,
                margin: const EdgeInsets.symmetric(horizontal: 12.0),
                padding: const EdgeInsets.symmetric(vertical:14.0),
                decoration: BoxDecoration(
                  color: AppColor.themeColor,
                  borderRadius: BorderRadius.circular(5.0)
                ),
                child: Center(child: Text("Get Your Current Location",style: AppTextStyle.textStyleBold12.copyWith(color: Colors.white),)),
              ),
            ),
          ): const SizedBox.shrink(),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 14.0,horizontal: 12.0),
              itemCount: suggestionList.length ,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Get.back(result:suggestionList[index]);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.location_on_outlined,color: Colors.black,),
                            Text(calculateDistance(widget.currentLocation.latitude,widget.currentLocation.longitude,suggestionList[index].latLng.latitude,suggestionList[index].latLng.longitude),textAlign: TextAlign.center,style: AppTextStyle.textStyleRegular10,)
                          ],
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Text(suggestionList[index].name,style: AppTextStyle.textStyleBold12,),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text(suggestionList[index].fullAddress,style: AppTextStyle.textStyleRegular11,),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }, separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 14.0,
              );
            },),
          ),
        ],
      ),
    );
  }

  String calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return "${(12742 * asin(sqrt(a))).toStringAsFixed(2)}\nkm";
  }

  RxList<ModelSuggestion> suggestionList = <ModelSuggestion>[].obs;


  fetchSuggestions(String input) async {
    // final request =
    //     'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&location=${currentLocation!.latitude},${currentLocation!.longitude}&types=shop&radius=500&language=en&key=$apiKey';
    final request =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$input&key=$apiKey';
    final response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        List data = result['results'];
        suggestionList.clear();

        for (int i = 0; i < data.length; i++) {
          suggestionList.add(ModelSuggestion(
              data[i]['place_id'],
              data[i]['formatted_address'],
              data[i]['name'],
              data[i]['formatted_address'],
              LatLng(data[i]['geometry']['location']['lat'],
                  data[i]['geometry']['location']['lng'])));
        }

        // compose suggestions in a list
        // suggestionList = result['predictions']
        //     .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
        //     .toList();
        setState(() {});
        debugPrint("");
        // return result['predictions']
        //     .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
        //     .toList();
      }
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

}

class Suggestion {
  final String placeId;
  final String address;
  final String name;
  final String fullAddress;
  final LatLng latLng;

  Suggestion(this.placeId, this.address, this.name,this.fullAddress,this.latLng);
}
