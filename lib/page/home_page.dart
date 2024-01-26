import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:instagram_clone_flutter/controller/home_controller.dart';

import '../component/avater_widget.dart';
import '../component/post_widget.dart';
import '../imagepath.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          IconsPath.logo,
          width: 100,
        ),
        actions: [
          GestureDetector(
            onTap: (){},
            child: Image.asset(
              IconsPath.directMessage,
              width: 20,
            ),
          ),
          SizedBox(width: 10,)
        ],
      ),
      body: ListView(
        children: [
          _storyBoardList(),
          _postList(),
        ],
      ),
    );
  }

  Widget _storyBoardList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(width: 10,),
          _myStory(),
          SizedBox(width: 5,),
          ...List.generate(
              100,
                  (index) => AvatarWidget(
                type: AvatarTypeEnum.TYPE1,
                thumbPath: 'https://images.unsplash.com/photo-1528301721190-186c3bd85418?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D',
              )
            // Container(
            //   width: 60,
            //   height: 60,
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     color: Colors.grey,
            //   ),
            // )
          ),
        ],
      ),
    );
  }

  Widget _myStory() {
    return Stack(
      children: [
        AvatarWidget(
          type: AvatarTypeEnum.TYPE2,
          thumbPath: 'https://img.freepik.com/free-psd/3d-illustration-of-human-avatar-or-profile_23-2150671142.jpg?size=626&ext=jpg',
          size: 70,
        ),
        Positioned(
          right: 5,
          bottom: 0,
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
              border: Border.all(
                color: Colors.white,
                width: 2
              ),
            ),
            child: Center(
              child: Text(
                '+',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  height: 1.1,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _postList() {
    return Column(
      children: List.generate(50, (index) => PostWidget()),
    );
  }
}
