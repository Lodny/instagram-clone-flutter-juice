import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum AvatarTypeEnum {
  TYPE1,
  TYPE2,
  TYPE3,
}

class AvatarWidget extends StatelessWidget {
  bool? hasStory;
  String thumbPath;
  String? nickName;
  AvatarTypeEnum type;
  double? size;


  AvatarWidget({
    super.key,
    required this.type,
    required this.thumbPath,
    this.hasStory,
    this.nickName,
    this.size = 65,
  }); // AvatarWidget({

  @override
  Widget build(BuildContext context) {
    switch(type) {
      case AvatarTypeEnum.TYPE1:
        return type1Widget();
      case AvatarTypeEnum.TYPE2:
        return type2Widget();
      case AvatarTypeEnum.TYPE3:
        return type3Widget();
    }
  }

  Widget type1Widget() {
    return Container(
      padding: EdgeInsets.all(3),
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.purple,
            Colors.orange,
          ]
        ),
        shape: BoxShape.circle,
      ),
      child: type2Widget(),
    );
  }

  Widget type2Widget() {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      padding: EdgeInsets.all(2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size!),
        child: CachedNetworkImage(
          imageUrl: thumbPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget type3Widget() {
    return Row(
      children: [
        type1Widget(),
        Text(
          nickName ?? '',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
