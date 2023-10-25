import 'package:client_app/constant/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpLineTab extends StatefulWidget {
  const HelpLineTab({Key? key}) : super(key: key);

  @override
  State<HelpLineTab> createState() => _HelpLineTabState();
}

class _HelpLineTabState extends State<HelpLineTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widgetMainTitle(),
          const SizedBox(
            height: 14,
          ),
          widgetHelLine(),
        ],
      )
    );
  }

  Widget widgetHelLine(){
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 16.0),
      decoration: const BoxDecoration(
        color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 14.0,
          ),
          widgetHelpType(
              topHeading:"U&I Holidays",
            children: [
              ListTile(
                  title: Text("Siva Dasan (Senior Sales Manager)",style: AppTextStyle.textStyleBold10,),
                  subtitle: Text("+91 86577 97425",style: AppTextStyle.textStyleRegular10,),
                  trailing: IconButton(
                    onPressed: (){
                      openDialPad(phoneNumber:"+91 86577 97425");
                    },
                    icon: const Icon(Icons.phone,color:Colors.green,),
                  )
              ),
              ListTile(
                  title: Text("Sachin Ramteke (Sales Manager)",style: AppTextStyle.textStyleBold10,),
                  subtitle: Text("+91 91520 94326",style: AppTextStyle.textStyleRegular10,),
                  trailing: IconButton(
                    onPressed: (){
                      openDialPad(phoneNumber:"+91 86577 97425");
                    },
                    icon: const Icon(Icons.phone,color: Colors.green,),
                  )
              ),
            ]
          ),
          const SizedBox(
            height: 14.0,
          ),
          widgetHelpType(topHeading:"Flights",
              children: [
                ListTile(
                    title: Text("Ngurah Rai Airport",style: AppTextStyle.textStyleBold10,),
                    subtitle: Text("+91 86577 97425",style: AppTextStyle.textStyleRegular10,),
                    trailing: IconButton(
                      onPressed: (){
                        openDialPad(phoneNumber:"+91 86577 97425");
                      },
                      icon: const Icon(Icons.phone,color: Colors.green,),
                    )
                ),
                ListTile(
                    title: Text("Bandara International Lombok Airport",style: AppTextStyle.textStyleBold10,),
                    subtitle: Text("+91 91520 94326",style: AppTextStyle.textStyleRegular10,),
                    trailing: IconButton(
                      onPressed: (){
                        openDialPad(phoneNumber:"+91 86577 97425");
                      },
                      icon: const Icon(Icons.phone,color: Colors.green,),
                    )
                ),
              ]
          ),
          const SizedBox(
            height: 14.0,
          ),
          widgetHelpType(topHeading:"Hospital",
              children: [
                ListTile(
                    title: Text("Bali Royal Hospital",style: AppTextStyle.textStyleBold10,),
                    subtitle: Text("+62 361 222588",style: AppTextStyle.textStyleRegular10,),
                    trailing: IconButton(
                      onPressed: (){
                        openDialPad(phoneNumber:"+91 86577 97425");
                      },
                      icon: const Icon(Icons.phone,color: Colors.green,),
                    )
                ),
                ListTile(
                    title: Text("Balimed Hospital)",style: AppTextStyle.textStyleBold10,),
                    subtitle: Text("+62 811-1484-748",style: AppTextStyle.textStyleRegular10,),
                    trailing: IconButton(
                      onPressed: (){
                        openDialPad(phoneNumber:"+91 86577 97425");
                      },
                      icon: const Icon(Icons.phone,color: Colors.green,),
                    )
                ),
              ]
          ),
          const SizedBox(
            height: 14.0,
          ),
          widgetHelpType(topHeading:"Counselate",
              children: [
                ListTile(
                    title: Text(" Embassy of the Republic of Indonesia",style: AppTextStyle.textStyleBold10,),
                    subtitle: Text("011 2611 8642",style: AppTextStyle.textStyleRegular10,),
                    trailing: IconButton(
                      onPressed: (){
                        openDialPad(phoneNumber:"+91 86577 97425");
                      },
                      icon: const Icon(Icons.phone,color: Colors.green,),
                    )
                ),
                ListTile(
                  title: Text("Swami Vivekananda Culture Centre (SVCC), Bali",style: AppTextStyle.textStyleBold10,),
                  subtitle: Text("(+62) 361 259502",style: AppTextStyle.textStyleRegular10,),
                  trailing: IconButton(
                    onPressed: (){
                      openDialPad(phoneNumber:"+91 86577 97425");
                    },
                    icon: const Icon(Icons.phone,color: Colors.green,),
                  ),
                ),
              ]
          ),
          const SizedBox(
            height: 14.0,
          ),
          widgetHelpType(topHeading:"Police",
              children: [
                ListTile(
                    title: Text("Police Station Radawa Bali",style: AppTextStyle.textStyleBold10,),
                    subtitle: Text("(0361) 227711, 227712, 227713",style: AppTextStyle.textStyleRegular10,),
                    trailing: IconButton(
                      onPressed: (){
                        openDialPad(phoneNumber:"+91 86577 97425");
                      },
                      icon: const Icon(Icons.phone,color: Colors.green,),
                    )
                ),
                ListTile(
                    title: Text("WEST DENPASAR POLICE STATION",style: AppTextStyle.textStyleBold10,),
                    subtitle: Text(" (0361) 464694",style: AppTextStyle.textStyleRegular10,),
                    trailing: IconButton(
                      onPressed: (){
                        openDialPad(phoneNumber:"+91 86577 97425");
                      },
                      icon: const Icon(Icons.phone,color: Colors.green,),
                    ),
                ),
              ]
          )
        ],
      ),
    );
  }


  Widget widgetMainTitle(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.phone,color: Colors.black,size: 22,),
        const SizedBox(
          width: 10.0,
        ),
        Text("Helpline",style: AppTextStyle.textStyleBold16.copyWith(color: Colors.black),),
      ],
    );
  }


  Widget widgetHelpType({topHeading,required List<Widget>children}){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 0.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: Colors.black26)
      ),
       child: ExpansionTile(
         iconColor: Colors.black,
         collapsedIconColor: Colors.black,
         title: Text("$topHeading",style: AppTextStyle.textStyleBold12.copyWith(color: Colors.black),),
         children: children,
       ),
    );
  }

    openDialPad({phoneNumber}) async {
      Uri url = Uri(scheme: "tel", path: phoneNumber);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        debugPrint("Can't open dial pad.");
      }
    }



}
