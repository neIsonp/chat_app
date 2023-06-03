import 'dart:convert';

import 'package:firebase_chat/common/entities/user.dart';
import 'package:firebase_chat/common/store/store.dart';
import 'package:firebase_chat/pages/contact/state.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../common/entities/msg.dart';

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

  goChat(UserData toUserdata) async {
    var fromMessages = await db
        .collection("message")
        .withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, options) => msg.toFirestore(),
        )
        .where("from_uid", isEqualTo: token)
        .where("to_uid", isEqualTo: toUserdata.id)
        .get();

    var toMessages = await db
        .collection("message")
        .withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, options) => msg.toFirestore(),
        )
        .where("from_uid", isEqualTo: toUserdata.id)
        .where("to_uid", isEqualTo: token)
        .get();

    if (fromMessages.docs.isEmpty && toMessages.docs.isEmpty) {
      String profile = await UserStore.to.getProfile();
      print(profile);

      UserLoginResponseEntity userData = UserLoginResponseEntity.fromJson(
        jsonDecode(profile),
      );

      Msg messageData = Msg(
        from_uid: userData.accessToken,
        to_uid: toUserdata.id,
        from_name: userData.displayName,
        to_name: toUserdata.name,
        from_avatar: userData.photoUrl,
        to_avatar: toUserdata.photourl,
        last_msg: "",
        last_time: Timestamp.now(),
        msg_num: 0,
      );
      db
          .collection("message")
          .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore(),
          )
          .add(messageData)
          .then(
        (value) {
          Get.toNamed("/chat", parameters: {
            "doc_id": value.id,
            "to_uid": toUserdata.id ?? "",
            "to_name": toUserdata.name ?? "",
            "to_avatar": toUserdata.photourl ?? ""
          });
        },
      );
    } else {
      if (fromMessages.docs.isNotEmpty) {
        Get.toNamed("/chat", parameters: {
          "doc_id": fromMessages.docs.first.id,
          "to_uid": toUserdata.id ?? "",
          "to_name": toUserdata.name ?? "",
          "to_avatar": toUserdata.photourl ?? ""
        });
      }
      if (toMessages.docs.isNotEmpty) {
        Get.toNamed("/chat", parameters: {
          "doc_id": toMessages.docs.first.id,
          "to_uid": toUserdata.id ?? "",
          "to_name": toUserdata.name ?? "",
          "to_avatar": toUserdata.photourl ?? ""
        });
      }
    }
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
