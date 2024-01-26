import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/post.dart';

class PostRepository {
  static Future<void> updatePost(Post post) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .add(post.toMap());
  }
}
