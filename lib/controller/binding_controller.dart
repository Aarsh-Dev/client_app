import 'package:client_app/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class BindingController extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies

  Get.lazyPut<HomeController>(() => HomeController(),fenix: true);





  }



}