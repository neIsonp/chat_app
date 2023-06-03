import 'package:firebase_chat/common/entities/user.dart';
import 'package:firebase_chat/common/store/store.dart';
import 'package:firebase_chat/pages/contact/state.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactController extends GetxController {
  ContactController();
  final ContactState state = ContactState();
  final db = FirebaseFirestore.instance;
  final token = UserStore.to.token;

  @override
  void onReady() {
    super.onReady();
    asyncLoadAllData();
  }

  asyncLoadAllData() async {
    QuerySnapshot<UserData> userBase = await db
        .collection("users")
        .where("id", isNotEqualTo: token)
        .withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData userdata, options) => userdata.toFirestore(),
        )
        .get();

    for (var doc in userBase.docs) {
      state.contactList.add(doc.data());
      print(doc.toString());
    }
  }
}
