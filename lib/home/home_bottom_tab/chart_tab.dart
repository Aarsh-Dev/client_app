import 'package:client_app/constant/app_text_style.dart';
import 'package:flutter/material.dart';

class ChartTab extends StatefulWidget {
  const ChartTab({Key? key}) : super(key: key);

  @override
  State<ChartTab> createState() => _ChartTabState();
}

class _ChartTabState extends State<ChartTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

        ],
      ),
    );
  }


  Widget widgetBestOffer(){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: const BoxDecoration(
        color: Color(0xffE3E6E8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text("Best Offer",style: AppTextStyle.textStyleBold14.copyWith(color: Colors.red),),
          ),
          const SizedBox(
            height: 10.0,
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),

                ),
              );
            }, separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10.0,
            );
          },)
        ],
      ),
    );
  }


}
