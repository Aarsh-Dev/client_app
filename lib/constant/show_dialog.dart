import 'package:client_app/constant/app_text_style.dart';
import 'package:client_app/constant/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowDialogs {
  ShowDialogs._();

  static showExclusiveOfferDialog({context}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
              child: Image.asset(
                AssetPath.imgTestOffer,
                fit: BoxFit.fill,
                width: Get.width,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Exclusive Offer For You!",
                    style: AppTextStyle.textStyleBold14,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Get exciting offer delivered direct to your inbox",
                    style: AppTextStyle.textStyleRegular14
                        .copyWith(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.black26)),
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        hintText: "Enter your email",
                        hintStyle: TextStyle(fontSize: 14),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide.none),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(2.0)),
                    child: Center(
                      child: Text(
                        "Send me offer",
                        style: AppTextStyle.textStyleBold12
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          "No thanks, i dont want any exclusive offers",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.grey,fontSize: 12),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
