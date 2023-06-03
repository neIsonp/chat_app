import 'package:firebase_chat/pages/chat/state.dart';
import 'package:get/get.dart';

import '../../common/routes/names.dart';
import '../../common/store/config.dart';

class ChatController extends GetxController {
  final state = ChatState();
  ChatController();

  changePage(int index) async {
    state.index.value = index;
  }

  handleSignIn() async {
    await ConfigStore.to.saveAlreadyOpen();
    Get.offAndToNamed(AppRoutes.SIGN_IN);
  }
}
