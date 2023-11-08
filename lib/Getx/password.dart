import 'package:get/get.dart';

class PasswordController extends GetxController {
  RxBool show = false.obs;
  RxList list = [].obs;

  visible() {
    list.add(show);
  }

  hide() {
    list.remove(show);
  }
}
