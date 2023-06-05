import 'dart:io';
import 'package:firebase_chat/common/entities/msgcontent.dart';
import 'package:firebase_chat/common/store/store.dart';
import 'package:firebase_chat/common/utils/security.dart';
import 'package:firebase_chat/pages/message/chat/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatController extends GetxController {
  final state = ChatState();
  ChatController();
  var doc_id;

  final textController = TextEditingController();
  ScrollController msgScrolling = ScrollController();
  FocusNode contentNode = FocusNode();
  final user_id = UserStore.to.token;
  final db = FirebaseFirestore.instance;
  var listener;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _photo = File(pickedFile.path);
      uploadFile();
    } else {
      print("no image selected");
    }
  }

  Future getImgUrl(String name) async {
    final spaceRef = FirebaseStorage.instance.ref("chat").child(name);
    var str = await spaceRef.getDownloadURL();
    return str ?? "";
  }

  sendImageMessage(String url) async {
    final content = Msgcontent(
      uid: user_id,
      content: url,
      type: "image",
      addtime: Timestamp.now(),
    );

    await db
        .collection("message")
        .doc(doc_id)
        .collection("msglist")
        .withConverter(
          fromFirestore: Msgcontent.fromFirestore,
          toFirestore: (Msgcontent msg, options) => msg.toFirestore(),
        )
        .add(content)
        .then((DocumentReference doc) {
      print("document snapshot added with id ${doc.id}");
      textController.clear();
      Get.focusScope?.unfocus();
    });
    await db.collection("message").doc(doc_id).update({
      "last_msg": "[image]",
      "last_time": Timestamp.now(),
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;

    final filename = getRandomString(15) + extension(_photo!.path);

    try {
      final ref = FirebaseStorage.instance.ref("chat").child(filename);
      ref.putFile(_photo!).snapshotEvents.listen((event) async {
        switch (event.state) {
          case TaskState.running:
            break;
          case TaskState.paused:
            break;
          case TaskState.success:
            String imgUrl = await getImgUrl(filename);
            sendImageMessage(imgUrl);
            break;
        }
      });
    } catch (err) {
      print("there's an erro $err");
    }
  }

  @override
  void onInit() {
    super.onInit();
    var data = Get.parameters;
    doc_id = data['doc_id'] ?? "";
    state.to_uid.value = doc_id;
    state.to_name.value = data['to_name'] ?? "";
    state.to_avatar.value = data['to_avatar'] ?? "";
  }

  sendMessage() async {
    String sendContent = textController.text;
    final content = Msgcontent(
      uid: user_id,
      content: sendContent,
      type: "text",
      addtime: Timestamp.now(),
    );

    await db
        .collection("message")
        .doc(doc_id)
        .collection("msglist")
        .withConverter(
          fromFirestore: Msgcontent.fromFirestore,
          toFirestore: (Msgcontent msg, options) => msg.toFirestore(),
        )
        .add(content)
        .then((DocumentReference doc) {
      print("document snapshot added with id ${doc.id}");
      textController.clear();
      Get.focusScope?.unfocus();
    });
    await db.collection("message").doc(doc_id).update({
      "last_msg": sendContent,
      "last_time": Timestamp.now(),
    });
  }

  @override
  void onReady() {
    super.onReady();

    var messages = db
        .collection("message")
        .doc(doc_id)
        .collection("msglist")
        .withConverter(
          fromFirestore: Msgcontent.fromFirestore,
          toFirestore: (Msgcontent msg, options) => msg.toFirestore(),
        )
        .orderBy("addtime", descending: false);

    state.msgContentList.clear();

    listener = messages.snapshots().listen(
      (event) {
        for (var change in event.docChanges) {
          switch (change.type) {
            case DocumentChangeType.added:
              if (change.doc.data() != null) {
                state.msgContentList.insert(0, change.doc.data()!);
              }
              break;
            case DocumentChangeType.modified:
              break;
            case DocumentChangeType.removed:
              break;
          }
        }
      },
      onError: (error) => print("listen failed $error"),
    );
  }

  @override
  void dispose() {
    msgScrolling.dispose();
    listener.cancel();
    super.dispose();
  }
}
