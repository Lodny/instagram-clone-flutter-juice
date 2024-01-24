import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

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
}
