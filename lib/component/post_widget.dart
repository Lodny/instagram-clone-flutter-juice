import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

import '../imagepath.dart';
import 'avater_widget.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _header(),
          SizedBox(height: 15,),
          _image(),
          SizedBox(height: 15,),
          _infoCount(),
          SizedBox(height: 5,),
          _infoDesc(),
          SizedBox(height: 5,),
          _replyTextBtn(),
          SizedBox(height: 5,),
          _dataAgo(),
        ],
      )
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AvatarWidget(
            type: AvatarTypeEnum.TYPE3,
            nickName: 'Juice',
            size: 40,
            thumbPath: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCR_l8xKBB1Agql-QYEn9IrGvTfA-IBPw29nzmJJJ52D79F5pcVWBKtKE38MvmWNjVxUQ&usqp=CAU',
          ),
          GestureDetector(
            onTap: (){},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(IconsPath.postMoreIcon, width: 20),
            ),
          )
        ],
      ),
    );
  }

  Widget _image() {
    return CachedNetworkImage(
        imageUrl: 'https://starwalk.space/gallery/images/what-is-space/1920x1080.jpg'
    );
  }

  Widget _infoCount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(IconsPath.likeOffIcon, width: 35,),
              SizedBox(width: 15,),
              Image.asset(IconsPath.replyIcon, width: 30,),
              SizedBox(width: 15,),
              Image.asset(IconsPath.directMessage, width: 30,),
            ],
          ),
          Image.asset(IconsPath.bookMarkOffIcon, width: 30,),
        ],
      ),
    );
  }

  Widget _infoDesc() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '좋아요 150개',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          ExpandableText(
            '컨텐츠 1입니다.\n컨텐츠 1입니다.\n컨텐츠 1입니다.\n컨텐츠 1입니다.',
            prefixText: 'Juice',
            prefixStyle: TextStyle(fontWeight: FontWeight.bold),
            onPrefixTap: () {
              print('Juice 페이지로 이동');
            },
            expandText: '더보기',
            collapseText: '접기',
            maxLines: 3,
            expandOnTextTap: true,
            collapseOnTextTap: true,
            linkColor: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _replyTextBtn() {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
          '댓글 199개 모두 보기',
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
      ),
    );
  }

  Widget _dataAgo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        '1일전',
        style: TextStyle(color: Colors.grey, fontSize: 11),
      ),
    );
  }
}
