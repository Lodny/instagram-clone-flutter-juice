import 'package:flutter/material.dart';

import 'avater_widget.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      width: 140,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        border: Border.all(
          color: Colors.black12,
        )
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Column(
              children: [
                SizedBox(height: 10,),
                AvatarWidget(
                  type: AvatarTypeEnum.TYPE3,
                  size: 40,
                  thumbPath: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCR_l8xKBB1Agql-QYEn9IrGvTfA-IBPw29nzmJJJ52D79F5pcVWBKtKE38MvmWNjVxUQ&usqp=CAU',
                ),
                Text(
                  'Juice1',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                Text(
                  'Cocopalm님이 팔로우합니다.',
                  style: TextStyle(
                    fontSize: 11,
                  ),
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Follow',
                    style: TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 5,
            top: 5,
            child: GestureDetector(
              onTap: (){},
              child: Icon(
                Icons.close,
                size: 14,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
