import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_flutter/controller/upload_controller.dart';

import '../component/message_popup.dart';
import '../page/upload_page.dart';

enum BottomNavEnum {
  Home,
  Search,
  Upload,
  Activity,
  MyPage,
}

class BottomNavController extends GetxService {
  static BottomNavController get to => Get.find();
  RxInt bottomNavIndex = 0.obs;
  List<int> history = [0];
  GlobalKey<NavigatorState> searchPageNavigationKey = GlobalKey<NavigatorState>();


  void setBottomNavIndex(int index, {bool withoutHistory = false}) {
    if (bottomNavIndex == index) return;

    if (! withoutHistory) {
      history.remove(index);
      // history.add(bottomNavIndex.value);
      history.add(index);
    }
    print('set() : ' + history.toString());

    switch(BottomNavEnum.values[index]) {
      case BottomNavEnum.Upload:
        print('213123');
        Get.to(
          () => UploadPage(),
          binding: BindingsBuilder(() {
            Get.put(UploadController());
          }),
        );
        break;

      case BottomNavEnum.Home:
      case BottomNavEnum.Search:
      case BottomNavEnum.Activity:
      case BottomNavEnum.MyPage:
        bottomNavIndex(index);
        break;
    }
  }

  Future<bool> willPopAction() async {
    if (history.length == 1) {
      showDialog(
        context: Get.context!,
        builder: (context) => MessagePopup(
          title: '시스템',
          message: '종료하시겠습니까?',
          okCallback: () => exit(0),
          cancelCallback: Get.back,
        ),
      );
      print('exit');
      return true;
    }

    final navEnum = BottomNavEnum.values[history.last];
    if (navEnum == BottomNavEnum.Search) {
      final popSearchNav = await searchPageNavigationKey.currentState!.maybePop();
      if (popSearchNav) return false;
    }

    history.removeLast();
    var index = history.last;
    setBottomNavIndex(index, withoutHistory: true);
    print('goto before page!');
    print(history);
    return false;
  }

}
