import 'package:client_app/constant/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpLineTab extends StatefulWidget {
  const HelpLineTab({Key? key}) : super(key: key);

  @override
  State<HelpLineTab> createState() => _HelpLineTabState();
}

class _HelpLineTabState extends State<HelpLineTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: widgetHelLine()
    );
  }

  Widget widgetHelLine(){
    return Container(
      height: Get.height,
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 16.0),
      decoration: const BoxDecoration(
        color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.phone,color: Colors.black,size: 22,),
              const SizedBox(
                width: 10.0,
              ),
              Text("Helpline",style: AppTextStyle.textStyleBold16.copyWith(color: Colors.black),),
            ],
          ),
          const SizedBox(
            height: 14.0,
          ),
          Row(
            children: [
              Expanded(child: widgetHelpType(text:"U&I Holidays")),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(child: widgetHelpType(text:"Flights")),
            ],
          ),
          const SizedBox(
            height: 14.0,
          ),
          Row(
            children: [
              Expanded(child: widgetHelpType(text:"Hospital")),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(child: widgetHelpType(text:"Counselate")),
            ],
          ),
          const SizedBox(
            height: 14.0,
          ),
          Row(
            children: [
              Expanded(child: widgetHelpType(text:"Police")),
              const SizedBox(
                width: 10.0,
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }


  Widget widgetHelpType({text}){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: Colors.black26)
      ),
       child: Row(
         children: [
           Expanded(child: Text("$text",style: AppTextStyle.textStyleBold10.copyWith(color: Colors.black),)),
           const Icon(Icons.arrow_right_sharp,color: Colors.black,size: 20,),
         ],
       ),
    );
  }


}
