import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_flutter/page/active_page.dart';
import 'package:instagram_clone_flutter/page/home_page.dart';
import 'package:instagram_clone_flutter/page/my_page.dart';
import 'package:instagram_clone_flutter/page/search_page.dart';

import 'controller/bottom_nav_controller.dart';
import 'imagepath.dart';

class App extends GetView<BottomNavController> {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await controller.willPopAction();
      },
      child: Obx(
        () => Scaffold(
          appBar: AppBar(),
          body: IndexedStack(
            index: controller.bottomNavIndex.value,
            children: [
              const HomePage(),
              Navigator(
                key: controller.searchPageNavigationKey,
                onGenerateRoute: (settings) => MaterialPageRoute(
                  builder: (context) => SearchPage(),
                ),
              ),
              Container(),
              ActivePage(),
              MyPage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: controller.bottomNavIndex.value,
            onTap: (index) {
              controller.setBottomNavIndex(index);
            },
            selectedItemColor: Colors.black,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  IconsPath.homeOff,
                ),
                activeIcon: Image.asset(IconsPath.homeOn),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  IconsPath.searchOff,
                ),
                activeIcon: Image.asset(IconsPath.searchOn),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  IconsPath.uploadIcon,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  IconsPath.activeOff,
                ),
                activeIcon: Image.asset(IconsPath.activeOn),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                ),
                label: 'Home',
              )
            ],
          ),
        ),
      ),
    );
  }
}
