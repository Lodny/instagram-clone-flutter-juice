import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/component/avater_widget.dart';

class ActivePage extends StatelessWidget {
  const ActivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '활동',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        )
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              _newRecentlyActiveView('오늘'),
              _newRecentlyActiveView('이번주'),
              _newRecentlyActiveView('이번달'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _newRecentlyActiveView(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        _activeItemOne(),
        _activeItemOne(),
        _activeItemOne(),
        _activeItemOne(),
        _activeItemOne(),
        SizedBox(height: 15,),
      ],
    );
  }

  Widget _activeItemOne() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          AvatarWidget(
            type: AvatarTypeEnum.TYPE2,
            size: 40,
            thumbPath: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCR_l8xKBB1Agql-QYEn9IrGvTfA-IBPw29nzmJJJ52D79F5pcVWBKtKE38MvmWNjVxUQ&usqp=CAU',
          ),
          SizedBox(width: 10,),
          Expanded(
              child: Text.rich(
                TextSpan(
                  text: 'Juice',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                        text: '님이 회원님의 게시물을 좋아합니다. 님이 회원님의 게시물을 좋아합니다.',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        )
                    ),
                    TextSpan(
                        text: ' 5일전',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                          color: Colors.black54,
                        )
                    )
                  ]
                )
              ),
          ),
        ],
      ),
    );
  }
}
