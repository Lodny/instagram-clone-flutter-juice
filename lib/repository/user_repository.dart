import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone_flutter/model/instagram_user.dart';

class UserRepository {
  var collection = FirebaseFirestore.instance.collection('users');

  Future<InstagramUser?> findUserByUid(String uid) async {
    var data = await collection
        .where('uid', isEqualTo: uid)
        .get();

    if (data.size == 0) return null;

    return InstagramUser.fromJson(data.docs.first.data());
  }

  Future<bool> signup(InstagramUser signupUser) async {
    try {
      await collection.add(signupUser.toMap());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
