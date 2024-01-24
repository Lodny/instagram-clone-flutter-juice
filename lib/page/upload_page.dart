import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_flutter/controller/upload_controller.dart';
import 'package:photo_manager/photo_manager.dart';

import '../imagepath.dart';

class UploadPage extends GetView<UploadController> {
  const UploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: Get.back,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset(IconsPath.closeImage),
          ),
        ),
        title: Text(
          'New Post',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(IconsPath.nextImage),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _imagePreview(),
            _header(),
            _imageSelectList(),
          ],
        ),
      ),
    );
  }

  Widget _imagePreview() {
    var width = Get.width;
    return Container(
      width: width,
      height: width,
      color: Colors.grey,
      child: Obx(() => controller.selectedImage.value.id != ''
          ? _photoWidget(controller.selectedImage.value, width.toInt())
          : Container()
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => showModalBottomSheet(
                context: Get.context!,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)
                  ),
                ),
                // isScrollControlled: false,
                // constraints: BoxConstraints(
                //   maxHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
                // ),
                builder: (context) => Container(
                  height: 200,
                  child: Column(
                    children: [
                      Center(
                        child: Text('.....'),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: List.generate(
                            controller.albums.length,
                            (index) => GestureDetector(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                child: Text(controller.albums[index].name),
                              ),
                              onTap: () {
                                controller.changeAlbum(controller.albums[index]);
                                Get.back();
                              },
                            ),
                          ),
                          // children: controller.albums.map((album) =>
                          //     GestureDetector(
                          //       child: Container(
                          //         padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                          //         child: Text(album.name),
                          //       ),
                          //       onTap: () {
                          //         controller.changeSelectedAlbum(album.name);
                          //       },
                          //     )
                          // ).toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              child: Row(
                children: [
                  Obx(() => Text(
                    controller.headerTitle.value ?? '',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  )),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: Color(0xff808080),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Image.asset(IconsPath.imageSelectIcon, width: 20,),
                    SizedBox(width: 5,),
                    Text(
                      '여러 항목 선택',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )
                  ],
                ),
              ),
              SizedBox(width: 8,),
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff808080),
                ),
                child: Image.asset(IconsPath.cameraIcon, width: 23,),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _imageSelectList() {
    return Obx(() => GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),
      itemCount: controller.imageList.length,
      itemBuilder: (BuildContext context, int index) {
        return _photoWidget(controller.imageList[index], 200);
      },
    ));
  }

  Widget _photoWidget(AssetEntity ae, int size) {
    return FutureBuilder(
      future: ae.thumbnailDataWithSize(ThumbnailSize.square(size)),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();

        return GestureDetector(
          onTap: () {
            controller.changeSelectedImage(ae);
          },
          child: Obx(() => Opacity(
            opacity: (ae == controller.selectedImage.value && size == 200) ? 0.3: 1,
            child: Image.memory(
              snapshot.data!,
              fit: BoxFit.cover,
            ),
          ),
        ));
      },
    );
  }
}
