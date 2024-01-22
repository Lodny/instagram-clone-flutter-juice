import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_flutter/model/instagram_user.dart';
import 'package:instagram_clone_flutter/repository/user_repository.dart';

import '../binding/init_binding.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  Rx<InstagramUser> user = InstagramUser().obs;

  final repository = UserRepository();

  Future<InstagramUser?> loginUser(String uid) async {
    var userData = await repository.findUserByUid(uid);
    if (userData == null)
      return null;

    user(userData);
    InitBinding.additionalBinding();
    return userData;
  }

  void signup(InstagramUser signupUser, XFile? thumbnail) async {
    if (thumbnail == null) {
      _submitSignup(signupUser);
      return;
    }

    var ext = thumbnail.path.split('.').last;
    var filename = '${signupUser.uid}/profile.${ext}';
    var uploadTask = _uploadXFile(thumbnail, filename);
    uploadTask.snapshotEvents.listen((event) async {
      if (event.bytesTransferred == event.totalBytes && event.state == TaskState.success) {
        var downloadUrl = await event.ref.getDownloadURL();
        var updateUserData = signupUser.copyWith(thumbnail: downloadUrl);
        _submitSignup(updateUserData);
      }
    });
  }

  UploadTask _uploadXFile(XFile file, String filename) {
    var f = File(file.path);
    final metaData = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );
    var ref = FirebaseStorage.instance.ref()
        .child('users')
        .child(filename);

    return ref.putFile(f, metaData);
  }

  void _submitSignup(InstagramUser signupUser) async {
    var result = await repository.signup(signupUser);
    if (! result) return;

    loginUser(signupUser.uid!);
  }
}
