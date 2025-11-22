// presentation/views/main_app/main_binding.dart
import 'package:get/get.dart';
import 'package:healthy_heart_junior/presentation/controllers/auth/sign_in_controller.dart';
import 'package:healthy_heart_junior/presentation/controllers/auth/sign_up_controller.dart';
import 'package:healthy_heart_junior/presentation/controllers/doctors_controller.dart';
import 'package:healthy_heart_junior/presentation/controllers/ecg_controller.dart';
import 'package:healthy_heart_junior/presentation/controllers/expert_controller.dart';
import 'package:healthy_heart_junior/presentation/controllers/heart_rate_controller.dart';
import 'package:healthy_heart_junior/presentation/controllers/lab_controller.dart';
import 'package:healthy_heart_junior/presentation/controllers/main_controller.dart';
import 'package:healthy_heart_junior/presentation/controllers/theme_controller.dart';
import 'package:healthy_heart_junior/presentation/controllers/user_controller.dart';


class MainBinding implements Bindings {
  @override
  void dependencies() {
     Get.lazyPut<ThemeController>(() => ThemeController()); 
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<HeartRateController>(() => HeartRateController());
    Get.lazyPut<EcgController>(() => EcgController());
    Get.lazyPut<LabController>(() => LabController());
    Get.lazyPut<ExpertController>(() => ExpertController());
    Get.lazyPut<DoctorsController>(() => DoctorsController());
    Get.lazyPut<SignUpController>(() => SignUpController());
    Get.lazyPut<SignInController>(() => SignInController());
  }
}