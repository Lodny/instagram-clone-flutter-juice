import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photofilters/filters/filters.dart';
import 'package:photofilters/filters/preset_filters.dart';
import 'package:path/path.dart';
import 'package:image/image.dart' as imageLib;
import 'package:photofilters/widgets/photo_filter.dart';

import '../page/upload_description_page.dart';


class UploadController extends GetxController {
  var albums = <AssetPathEntity>[];
  RxList<AssetEntity> imageList = <AssetEntity>[].obs;
  RxString headerTitle = ''.obs;
  Rx<AssetEntity> selectedImage = AssetEntity(
      id: '',
      typeInt: 0,
      width: 0,
      height: 0,
  ).obs;

  File? filteredFile;

  @override
  void onInit() {
    super.onInit();
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
}
