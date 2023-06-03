import 'package:get/get.dart';

import '../../common/routes/names.dart';
import '../../common/store/config.dart';
import 'state.dart';

class ApplicationController extends GetxController {
  final state = ApplicationState();
  ApplicationController();

  changePage(int index) async {
    state.index.value = index;
  }

  handleSignIn() async {
    await ConfigStore.to.saveAlreadyOpen();
    Get.offAndToNamed(AppRoutes.SIGN_IN);
  }
}
