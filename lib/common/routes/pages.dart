import 'package:firebase_chat/common/middlewares/middlewares.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../pages/application/index.dart';
import '../../pages/message/chat/index.dart';
import '../../pages/contact/index.dart';
import '../../pages/welcome/index.dart';
import '../../pages/signIn/index.dart';

import 'routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.SIGN_IN;
  static const APPlication = AppRoutes.Application;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [
    GetPage(
        name: AppRoutes.INITIAL,
        page: () => const WelcomePage(),
        binding: WelcomeBinding(),
        middlewares: [
          RouteWelcomeMiddleware(priority: 1),
        ]),
    GetPage(
      name: AppRoutes.SIGN_IN,
      page: () => const SignInPage(),
      binding: SignInBinding(),
    ),

    // check if needed to login or not
    GetPage(
      name: AppRoutes.Application,
      page: () => const ApplicationPage(),
      binding: ApplicationBinding(),
      middlewares: [
        RouteAuthMiddleware(priority: 1),
      ],
    ),

    GetPage(
      name: AppRoutes.Contact,
      page: () => const ContactPage(),
      binding: ContactBinding(),
    ),

    GetPage(
      name: AppRoutes.Chat,
      page: () => const ChatPage(),
      binding: ChatBinding(),
    ),
    /*

    GetPage(
        name: AppRoutes.Message,
        page: () => MessagePage(),
        binding: MessageBinding()),
    GetPage(
      name: AppRoutes.Me,
      page: () => MePage(),
      binding: MeBinding(),
    ),

    GetPage(name: AppRoutes.Photoimgview, page: () => PhotoImgViewPage(), binding: PhotoImgViewBinding()),*/
  ];
}
