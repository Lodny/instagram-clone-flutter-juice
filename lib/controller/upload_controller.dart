import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as imageLib;
import 'package:instagram_clone_flutter/controller/auth_controller.dart';
import 'package:instagram_clone_flutter/controller/home_controller.dart';
import 'package:instagram_clone_flutter/repository/post_repository.dart';
import 'package:instagram_clone_flutter/utils/data_util.dart';
import 'package:path/path.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photofilters/filters/filters.dart';
import 'package:photofilters/filters/preset_filters.dart';
import 'package:photofilters/widgets/photo_filter.dart';

import '../model/post.dart';
import '../page/upload_description_page.dart';


class UploadController extends GetxController {
  var albums = <AssetPathEntity>[];
  RxList<AssetEntity> imageList = <AssetEntity>[].obs;
  RxString headerTitle = ''.obs;
  TextEditingController textEditingController = TextEditingController();
  Rx<AssetEntity> selectedImage = AssetEntity(
      id: '',
      typeInt: 0,
      width: 0,
      height: 0,
  ).obs;

  File? filteredFile;
  Post? post;

  @override
  void onInit() {
    super.onInit();
    post = Post.init(AuthController.to.user.value);
    _loadPhotos();
  }

  void _loadPhotos() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    print(ps);
    if (ps.isAuth) {
      albums = await PhotoManager.getAssetPathList(
          type: RequestType.image,
          filterOption: FilterOptionGroup(
              imageOption: FilterOption(
                sizeConstraint: SizeConstraint(minHeight: 100, minWidth: 100),
              ),
              orders: [
                OrderOption(
                  type: OrderOptionType.createDate,
                  asc: false,
                ),
              ]
          )
      );
      _loadData();
    } else {
      PhotoManager.openSetting();
    }
  }

  void _loadData() {
    changeAlbum(albums.first);
  }

  Future<void> _pagingPhotos(AssetPathEntity album) async {
    imageList.clear();
    var photos = await album.getAssetListPaged(page: 0, size: 30);
    imageList.addAll(photos);
    changeSelectedImage(imageList.first);
  }

  void changeSelectedImage(AssetEntity ae) {
    selectedImage(ae);
  }

  void changeAlbum(AssetPathEntity album) async {
    headerTitle(album.name);
    await _pagingPhotos(album);
  }

  Future<void> gotoImageFilter() async {
    List<Filter> filters = presetFiltersList;

    final file = await selectedImage.value.file;
    final fileName = basename(file!.path);
    var image = imageLib.decodeImage(await file.readAsBytes());
    image = imageLib.copyResize(image!, width: 600);
    Map imageFile = await Navigator.push(
      Get.context!,
      new MaterialPageRoute(
        builder: (context) => new PhotoFilterSelector(
          title: Text("Photo Filter Example"),
          image: image!,
          filters: presetFiltersList,
          filename: fileName,
          loader: Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );

    if (imageFile != null && imageFile.containsKey('image_filtered')) {
      filteredFile = imageFile['image_filtered'];
      Get.to(() => UploadDescriptionPage());
    }
  }

  void uploadPost() {
    _unfocusKeyboard();
    print(textEditingController.text);
    final filename = DataUtil.makeFilePath();

    var uploadTask = _uploadFile(filteredFile!, '${AuthController.to.user.value.uid}/${filename}');
    uploadTask.snapshotEvents.listen((event) async {
      if (event.bytesTransferred == event.totalBytes &&
          event.state == TaskState.success) {
        var downloadUrl = await event.ref.getDownloadURL();
        var updatePost = post?.copyWith(thumbnail: downloadUrl, description: textEditingController.text);
        _submitPost(updatePost!);
      }
    });
  }

  void _unfocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  UploadTask _uploadFile(File file, String filename) {
    final metaData = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );
    var ref = FirebaseStorage.instance.ref()
        .child('instagram')
        .child(filename);

    return ref.putFile(file, metaData);
  }

  Future<void> _submitPost(Post post) async {
    await PostRepository.updatePost(post);
    final homeController = Get.find<HomeController>();
    homeController.loadPostList();

    showDialog(context: Get.context!,
      // builder: (context) => MessagePopup(
      //   title: '포스트',
      //   message: '포스팅이 완료 되었습니다.',
      //   okCallback: () => Get.until((route) => Get.currentRoute == '/'),
      // ),
      builder: (context) => AlertDialog(
        title: Text('포스트'),
        content: Text('포스팅이 완료 되었습니다.'),
        actions: [
          TextButton(
            onPressed: () {
              Get.until((route) => Get.currentRoute == '/');
            },
            child: Text('확인'),
          ),
        ],
      ),
    );
  }

}
