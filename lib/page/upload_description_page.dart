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
            onTap: () {},
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
              maxLines: null,
            ),
          )
        ],
      ),
    );
  }
}
