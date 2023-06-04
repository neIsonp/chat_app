import 'package:firebase_chat/common/entities/msgcontent.dart';
import 'package:get/get.dart';

class ChatState {
  RxList<Msgcontent> msgContentList = <Msgcontent>[].obs;
  var to_uid = "".obs;
  var to_name = "".obs;
  var to_avatar = "".obs;
  var to_location = "Localização desconhecida".obs;
}
