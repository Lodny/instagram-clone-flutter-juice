import 'package:get/get.dart';
import 'package:instagram_clone_flutter/repository/post_repository.dart';

import '../model/post.dart';

class HomeController extends GetxController {
  RxList<Post> rxPostList = <Post>[].obs;

  @override
  void onInit() {
    _loadPostList();
    super.onInit();
  }

  Future<void> _loadPostList() async {
    final postList = await PostRepository.getPostList();
    rxPostList(postList);

    print('postList.length:' + postList.length.toString());
  }
}
