import 'package:firebase_chat/common/store/store.dart';
import 'package:firebase_chat/pages/chat/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatController extends GetxController {
  final state = ChatState();
  ChatController();
  var doc_id;

  final textController = TextEditingController();
  ScrollController msgController = ScrollController();
  FocusNode contentNode = FocusNode();
  final user_id = UserStore.to.token;
  final db = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    var data = Get.parameters;
    doc_id = data['doc_id'] ?? "";
    state.to_uid.value = doc_id;
    state.to_name.value = data['to_name'] ?? "";
    state.to_avatar.value = data['to_avatar'] ?? "";
  }

  sendMessage() {
    String sendContent = textController.text;
    final content = 
  }
}
