import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:instagram_clone_flutter/controller/mypage_controller.dart';
import 'package:instagram_clone_flutter/imagepath.dart';

import '../component/avater_widget.dart';
import '../component/user_widget.dart';

class MyPage extends GetView<MyPageController> {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
          controller.targetUser.value.nickname!,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        )),
        actions: [
          GestureDetector(
            onTap: (){},
            child: Image.asset(IconsPath.uploadIcon, width: 30,),
          ),
          GestureDetector(
            onTap: (){},
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset(IconsPath.menuIcon, width: 30,),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              _information(),
              _menu(),
              _discoverPeople(),
              _tabMenu(),
              _tabView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _information() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            AvatarWidget(
              type: AvatarTypeEnum.TYPE3,
              size: 40,
              // thumbPath: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCR_l8xKBB1Agql-QYEn9IrGvTfA-IBPw29nzmJJJ52D79F5pcVWBKtKE38MvmWNjVxUQ&usqp=CAU',
              thumbPath: controller.targetUser.value.thumbnail!,
            ),
            SizedBox(width: 20,),
            _statisticsOne('Post', 15),
            _statisticsOne('Followers', 25),
            _statisticsOne('Following', 35),
          ],
        ),
        SizedBox(height: 15,),
        Text(
          controller.targetUser.value.description!,
          style: TextStyle(
            fontSize: 14,
          ),
        )
      ],
    ));
  }

  Widget _statisticsOne(String title, int count,) {
    return Expanded(
      child: Column(
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _menu() {
    return Row(
      children: [
        SizedBox(height: 50,),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: Colors.black12)),
            child: Text(
              'Edit Profile',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 5,),
        Image.asset(IconsPath.addFriend, width: 22,),
      ],
    );
  }

  Widget _discoverPeople() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Discover People',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text('See All',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        SizedBox(height: 5,),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                10,
                (index) => UserCard(),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _tabMenu() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: TabBar(
        controller: controller.tabController,
        indicatorWeight: 1,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          Container(
            padding: EdgeInsets.all(2),
            child: Image.asset(
                IconsPath.gridViewOn,
            ),
            width: 20,
          ),
          Container(
            padding: EdgeInsets.all(2),
            child: Image.asset(
                IconsPath.myTagImageOff,
            ),
            width: 20,
          )
        ],
      ),
    );
  }

  Widget _tabView() {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 100,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),
      itemBuilder: (context, index) => Container(
        color: Colors.grey,
      ),
    );
  }
}
