import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_flutter/controller/auth_controller.dart';
import 'package:instagram_clone_flutter/model/instagram_user.dart';
import 'dart:io';

class SignupPage extends StatefulWidget {
  final String uid;
  const SignupPage({super.key, required this.uid});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController nicknameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _thumbnailXFile;

  void update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 30,),
            _avatar(),
            SizedBox(height: 30,),
            _nickname(),
            SizedBox(height: 30,),
            _description(),
          ],
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          // todo : validation
          var signupUser = InstagramUser(
              uid: widget.uid,
              nickname: nicknameController.text,
              thumbnail: '',
              description: descriptionController.text
          );
          AuthController.to.signup(signupUser, _thumbnailXFile);
        },
        child: Text('회원가입'),
      ),
    );
  }

  Widget _avatar() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: SizedBox(
            width: 100,
            height: 100,
            child: _thumbnailXFile != null
                ? Image.file(
                    File(_thumbnailXFile!.path),
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/default_image.png',
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            _thumbnailXFile = await _imagePicker.pickImage(
              source: ImageSource.gallery,
              imageQuality: 30,
            );
            update();
          },
          child: Text(
            '이미지 변경'
          ),
        ),
      ],
    );
  }

  Widget _nickname() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        children: [
          TextField(
            controller: nicknameController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              hintText: '닉네임',
            ),
          ),
        ],
      ),
    );

  }

  Widget _description() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        children: [
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              hintText: '설명',
            ),
          ),
        ],
      ),
    );
  }
}
