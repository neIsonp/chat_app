import 'package:firebase_chat/common/widgets/widgets.dart';
import 'package:firebase_chat/pages/message/chat/widgets/message_list.dart';
import 'package:flutter/material.dart';
import '../../common/values/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  AppBar _buildAppBar() {
    return transparentAppBar(
      title: Text(
        "Mensagens",
        style: TextStyle(
            color: AppColors.primaryBackground,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: const MessageList(),
    );
  }
}
