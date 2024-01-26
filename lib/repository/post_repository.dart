import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/post.dart';

class PostRepository {
  static Future<void> updatePost(Post post) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .add(post.toMap());
  }

  static Future<List<Post>> getPostList() async {
    final document = FirebaseFirestore.instance
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .limit(10);
    final feedlist = await document.get();

    return feedlist.docs.map<Post>((feed) =>
        // Post.fromJson(feed.id, feed.data()),).toList();
        Post.fromJson(feed.data())).toList();
  }
}
