import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/bottom_nav_controller.dart';
import '../imagepath.dart';

class SearchingPage extends StatefulWidget {
  const SearchingPage({super.key});

  @override
  State<SearchingPage> createState() => _SearchingPageState();
}

class _SearchingPageState extends State<SearchingPage> with TickerProviderStateMixin {
  late TabController tabController;
  List<String> tabMenuText = ['인기', '계정', '오디오', '태그', '장소'];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabMenuText.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset(IconsPath.backBtnIcon),
          ),
          // onTap: Get.back,
          onTap: BottomNavController.to.willPopAction,
        ),
        titleSpacing: 0,
        title: Container(
          margin: EdgeInsets.only(right: 20),
          // padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Color(0xffefefef),
          ),
          child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    vertical: 5, horizontal: 10),
                border: InputBorder.none,
                hintText: '검색',
                isDense: true,
              )
          ),
        ),
        bottom: _tabMenu(),
      ),
      body: _body(),
    );
  }

  PreferredSize _tabMenu() {
    return PreferredSize(
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
      child: Container(
        height: AppBar().preferredSize.height,
        width: Size.infinite.width,
        child: TabBar(
          controller: tabController,
          indicatorColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: _tabMenuList(),
        ),
      ),
    );
  }

  List<Widget> _tabMenuList() {

    return tabMenuText.map((menuText) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            menuText,
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
        ),
      )
      .toList();
  }

  Widget _body() {
    return TabBarView(
      controller: tabController,
      children: [
        Center(child: Text('인기페이지')),
        Center(child: Text('계정페이지')),
        Center(child: Text('오디오페이지')),
        Center(child: Text('태그페이지')),
        Center(child: Text('장소페이지')),
      ]
    );
  }
}
