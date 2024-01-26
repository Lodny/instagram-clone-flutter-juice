import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_flutter/controller/upload_controller.dart';
import 'package:instagram_clone_flutter/imagepath.dart';

class UploadDescriptionPage extends GetView<UploadController> {
  const UploadDescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: Get.back,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Image.asset(
              IconsPath.backBtnIcon,
              width: 50,
            ),
          ),
        ),
        title: Text(
          '새 게시물',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: controller.uploadPost,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Image.asset(
                IconsPath.uploadComplete,
                width: 50,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: Container(
              child: GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _description(),
                      Divider(color: Color(0xffe9e9e9),),
                      _infoOne('사람 태그하기'),
                      Divider(color: Color(0xffe9e9e9),),
                      _infoOne('위치 추가'),
                      Divider(color: Color(0xffe9e9e9),),
                      _infoOne('다른 미디어에도 게시'),
                      _snsInfo(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _description() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: Image.file(
              controller.filteredFile!,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller.textEditingController,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: '문구 입력...'
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _infoOne(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 7,
        horizontal: 15,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 17,
        ),
      ),
    );
  }

  Widget _snsInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15,),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Facebook',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Switch(
                value: false,
                onChanged: (value) => {},
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Twitter',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Switch(
                value: false,
                onChanged: (value) => {},
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tumblr',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Switch(
                value: false,
                onChanged: (value) => {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
