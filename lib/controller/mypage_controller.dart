import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_flutter/controller/auth_controller.dart';
import 'package:instagram_clone_flutter/model/instagram_user.dart';

class MyPageController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  Rx<InstagramUser> targetUser = InstagramUser().obs;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    _loadData();

    super.onInit();
  }

  void _loadData() {
    _setTargetUser();
  }

  void _setTargetUser() {
    var uid = Get.parameters['targetUid'];
    if (uid == null) {
      targetUser(AuthController.to.user.value);
      return;
    }

    // todo
  }
}
