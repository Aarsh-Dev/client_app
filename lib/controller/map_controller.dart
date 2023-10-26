import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MapController extends GetxController{



  TextEditingController searchTextEditingController = TextEditingController();



  RxBool isSearch = false.obs;
  RxBool isShowCancelIcon = false.obs;



}