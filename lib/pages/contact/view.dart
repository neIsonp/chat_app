import 'package:firebase_chat/common/widgets/widgets.dart';
import 'package:firebase_chat/pages/contact/widgets/contact_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/values/colors.dart';
import 'controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactPage extends GetView<ContactController> {
  const ContactPage({super.key});

  AppBar _buildAppbar() {
    return transparentAppBar(
      title: Text(
        'Contactos',
        style: TextStyle(
          color: AppColors.primaryBackground,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: const ContactList(),
    );
  }
}
