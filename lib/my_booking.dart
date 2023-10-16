import 'package:client_app/constant/app_colors.dart';
import 'package:client_app/constant/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBooking extends StatefulWidget {
  const MyBooking({Key? key}) : super(key: key);

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.edit,
              color: Colors.orange,
              size: 20,
            ),
            const SizedBox(
              width: 4.0,
            ),
            Text(
              "My Booking",
              style:
                  AppTextStyle.textStyleBold14.copyWith(color: Colors.orange),
            ),
          ],
        ),
        actions: const [
          CircleAvatar(
              backgroundColor: Colors.lightBlueAccent,
              radius: 15,
              child: Icon(
                Icons.search,
                color: Colors.white,
                size: 20,
              )),
          SizedBox(
            width: 16.0,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16.0,
            ),
            widgetMyBookingList(),
          ],
        ),
      ),
    );
  }

  Widget widgetMyBookingList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Colors.transparent)
          ),
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.zero,
          child: ExpansionTile(
            iconColor: Colors.red,
            collapsedIconColor: Colors.red,
            collapsedBackgroundColor: AppColor.themeColor,
            backgroundColor: AppColor.themeColor,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Day 02: Arrival To Bali",
                  style: AppTextStyle.textStyleRegular12
                      .copyWith(color: Colors.white),
                ),
                Text(
                  "12 May 2017",
                  style: AppTextStyle.textStyleRegular12
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
            children: [
              Container(
                width: Get.width,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8.0,
                    ),
                     Row(
                       children: [
                         const Icon(Icons.arrow_forward,color: Colors.red,size: 16,),
                         Text.rich(
                           TextSpan(
                             children: [
                               TextSpan(text: '09:00',style: AppTextStyle.textStyleBold10),
                               TextSpan(
                                 text: ' - Pick Up From Bali Airport To Royal Hotel',
                                   style: AppTextStyle.textStyleRegular10,
                               ),
                             ],
                           ),
                         ),
                       ],
                     ),
                    const Divider(),
                    Row(
                      children: [
                        const CircleAvatar(child: Icon(Icons.person)),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Driver Details",style: AppTextStyle.textStyleBold12,),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: 'Name : ',style: AppTextStyle.textStyleBold10),
                                    TextSpan(
                                      text: 'Manoj Shah',
                                      style: AppTextStyle.textStyleRegular10,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: 'Mobile No : ',style: AppTextStyle.textStyleBold10),
                                    TextSpan(
                                      text: '1234567890',
                                      style: AppTextStyle.textStyleRegular10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: 'Car No : ',style: AppTextStyle.textStyleBold10),
                                  TextSpan(
                                    text: 'MH 0987',
                                    style: AppTextStyle.textStyleRegular10,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: 'Type : ',style: AppTextStyle.textStyleBold10),
                                  TextSpan(
                                    text: 'PVT',
                                    style: AppTextStyle.textStyleRegular10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(),
                  Row(
                    children: [
                      const Icon(Icons.add,color: Colors.red,size: 18,),
                      Text("Additional Info",style: AppTextStyle.textStyleBold12,)
                    ],
                  ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: Text("Feedback".toUpperCase(),style: AppTextStyle.textStyleBold13,),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 16.0,
        );
      },
    );
  }
}
