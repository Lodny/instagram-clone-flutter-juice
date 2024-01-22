import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_flutter/controller/auth_controller.dart';
import 'package:instagram_clone_flutter/model/instagram_user.dart';
import 'package:instagram_clone_flutter/page/login_page.dart';
import 'package:instagram_clone_flutter/page/signup_page.dart';

import 'app.dart';

class RootPage extends GetView<AuthController> {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (_, AsyncSnapshot<User?> user) {
        if ((user.hasData)) {
          return FutureBuilder<InstagramUser?>(
            future: controller.loginUser(user.data!.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData) return App();

              return Obx(() => controller.user.value.uid != null
                  ? App()
                  : SignupPage(uid: user.data!.uid));
            } ,
          );
        } else {
          return LoginPage();
        }
      }
      ,
    );
  }
}
