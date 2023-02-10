import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:masterappp/config/config.dart';
import 'package:masterappp/routes/route_constants.dart';


class SplashController extends GetxController {
  @override
  void onInit() {
    openBox();
    super.onInit();
  }

  Future openBox() async {
    AgentSamaWeb.userResulBox =
        await Hive.openBox(AgentSamaWeb.userResultHiveBoxKey);
    AgentSamaWeb.identifiantBox =
        await Hive.openBox(AgentSamaWeb.identifiantHiveBoxKey);
    getUserInfo();
    return;
  }

  String userRlt = '';

  getUserInfo() async {
    if (AgentSamaWeb.userResulBox == null ||
        AgentSamaWeb.userResulBox!.isEmpty) {
      print('no data saved');
    } else {
      userRlt =
          await AgentSamaWeb.userResulBox!.get(AgentSamaWeb.userResultHiveKey);
      print(userRlt);
      print(await AgentSamaWeb.identifiantBox!
          .get(AgentSamaWeb.identifiantHiveKey));
    }
  }

  goToNextPage() {
    if (userRlt == '') {
      print('go to phone auth screen');
      Get.toNamed(phoneNumberAuthRoute);
    } else {
      print('no');
      // _getRoute();
      Get.offAndToNamed(loginScreenRoute);
    }
  }

  @override
  void onReady() {
    moveToNext();
    super.onReady();
  }

  Future<void> moveToNext() async {
    await Future.delayed(const Duration(seconds: 3), () {
      goToNextPage();
    });
  }
}
