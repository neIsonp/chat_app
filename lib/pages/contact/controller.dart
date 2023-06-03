import 'package:firebase_chat/pages/contact/state.dart';
import 'package:get/get.dart';
import '../../common/routes/names.dart';
import '../../common/store/config.dart';

class ContactController extends GetxController {
  final state = ContactState();
  ContactController();

  changePage(int index) async {
    state.index.value = index;
  }

  handleSignIn() async {
    await ConfigStore.to.saveAlreadyOpen();
    Get.offAndToNamed(AppRoutes.SIGN_IN);
  }
}
