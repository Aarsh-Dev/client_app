import 'package:client_app/controller/currency_controller.dart';
import 'package:client_app/controller/home_controller.dart';
import 'package:client_app/controller/map_controller.dart';
import 'package:client_app/controller/restaurants_controller.dart';
import 'package:client_app/controller/more_activity_controller.dart';
import 'package:get/get.dart';

class BindingController extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies

  Get.lazyPut<HomeController>(() => HomeController(),fenix: true);
  Get.lazyPut<MoreActivitiesController>(() => MoreActivitiesController(),fenix: true);
  Get.lazyPut<CurrencyController>(() => CurrencyController(),fenix: true);
  Get.lazyPut<RestaurantsController>(() => RestaurantsController(),fenix: true);
  Get.lazyPut<MapController>(() => MapController(),fenix: true);
  }



}