import 'package:firebase_chat/pages/contact/controller.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ApplicationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplicationController>(() => ApplicationController());
    Get.lazyPut<ContactController>(() => ContactController());
  }
}
