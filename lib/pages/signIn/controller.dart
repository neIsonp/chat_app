import 'package:firebase_chat/common/entities/entities.dart';
import 'package:firebase_chat/common/routes/names.dart';
import 'package:firebase_chat/common/store/store.dart';
import 'package:firebase_chat/common/widgets/widgets.dart';
import 'package:get/get.dart';
import 'index.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>['openid']);

class SignInController extends GetxController {
  final state = SignInState();
  SignInController();
  final db = FirebaseFirestore.instance;

  Future<void> handleSignIn() async {
    try {
      var user = await _googleSignIn.signIn();

      if (user != null) {
        final gAuthentication = await user.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: gAuthentication.idToken,
          accessToken: gAuthentication.accessToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);

        String displayName = user.displayName ?? user.email;
        String email = user.email;
        String id = user.id;
        String photoUrl = user.photoUrl ?? "";
        UserLoginResponseEntity userProfile = UserLoginResponseEntity();
        userProfile.email = email;
        userProfile.accessToken = id;
        userProfile.displayName = displayName;
        userProfile.photoUrl = photoUrl;

        UserStore.to.saveProfile(userProfile);

        var userbase = await db
            .collection("users")
            .withConverter(
                fromFirestore: UserData.fromFirestore,
                toFirestore: (UserData userdata, options) =>
                    userdata.toFirestore())
            .where("id", isEqualTo: id)
            .get();

        if (userbase.docs.isEmpty) {
          final data = UserData(
            id: id,
            name: displayName,
            email: email,
            photourl: photoUrl,
            location: "",
            fcmtoken: "",
            addtime: Timestamp.now(),
          );

          await db
              .collection("users")
              .withConverter(
                  fromFirestore: UserData.fromFirestore,
                  toFirestore: (UserData userdata, options) =>
                      userdata.toFirestore())
              .add(data);

          toastInfo(msg: "Conectado com sucesso");
          Get.offAndToNamed(AppRoutes.Application);
        }
      }
    } catch (err) {
      toastInfo(msg: "Erro ao conectar-se");
      print(err);
    }
  }

  @override
  void onReady() {
    super.onReady();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('user is currently logged out');
      } else {
        print('user is logged in');
      }
    });
  }
}
