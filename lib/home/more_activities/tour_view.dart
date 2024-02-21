import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_app/constant/app_colors.dart';
import 'package:client_app/constant/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class TourView extends StatefulWidget {
  final String image;
  final String hotelName;
  final String startRating;
  final String price;
  final Function onTap;


  const TourView({Key? key, required this.image,required this.hotelName,required this.startRating,required this.price, required this.onTap})
      : super(key: key);

  @override
  State<TourView> createState() => _TourViewState();
}

class _TourViewState extends State<TourView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        widget.onTap();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.height * 0.25,
            width: Get.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: CachedNetworkImage(
                imageUrl: widget.image.replaceAll(" ", "%20"),
                fit: BoxFit.fill,
                placeholder: (context, url) {
                  return Opacity(
                      opacity: 0.20,
                      child: Container(
                        color: Colors.grey,
                      )

                  );
                },
                errorWidget: (context, url, error) {
                  return Opacity(
                      opacity: 0.20,
                      child:  Container(
                        color: Colors.grey,
                      )

                  );
                },
              ),
            ),
          ),
          8.height,
          Text(
            widget.hotelName.trimLeft(),
            maxLines: 2,
            textAlign: TextAlign.start,
            style:
            AppTextStyle.textStyleBold15.copyWith(color: AppColor.themeColor),
          ),
          4.height,
          widget.startRating.isEmpty?const SizedBox.shrink():widget.startRating == "6"
              ? Text(
            "Villas",
            style: AppTextStyle.textStyleRegular12
                .copyWith(color: Colors.amber),
          )
              : RatingBar.builder(
            initialRating: double.parse(widget.startRating),
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: int.parse(widget.startRating ?? "5"),
            itemSize: 14.0,
            itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
              size: 10.0,
            ),
            onRatingUpdate: (rating) {},
          ),
          4.height,
          widget.price.isEmpty?const SizedBox.shrink():Text(
            "USD ${widget.price}",
            style:
            AppTextStyle.textStyleBold16.copyWith(color: AppColor.themeColor),
          ),

        ],
      ),
    );
  }
}
