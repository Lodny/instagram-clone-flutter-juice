import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/page/searching_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<List<int>> groupbox = [[], [], []];

  @override
  void initState() {
    super.initState();

    List<int> sumSize = [0, 0, 0];
    for(var i = 0; i < 100; i++) {
      var minIdx = sumSize.fold(0, (min, curr) => curr < sumSize[min] ? sumSize.indexOf(curr) : min);
      var boxSize = (minIdx != 1) ? Random().nextInt(5) == 0 ? 2 : 1 : 1;
      sumSize[minIdx] += boxSize;
      groupbox[minIdx].add(boxSize);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _appBar(),
            Expanded(child: _body()),
          ],
        ),
      ),
    );
  }

  Widget _appBar() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              // Get.to(() => SearchingPage());
              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchingPage(),));
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              margin: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Color(0xffefefef),
              ),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.search),
                  Text(
                    '검색',
                    style: TextStyle(fontSize: 15, color: Color(0xff838383)),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.location_pin),
        ),
      ],
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          groupbox.length,
          (index) => Expanded(
            child: Column(
              children: groupbox[index]
                  .map((boxSize) => Container(
                        height: 140.0 * boxSize,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white,),
                          color: Colors.primaries[
                            Random().nextInt(Colors.primaries.length)
                          ]
                        ),
                        child: CachedNetworkImage(
                          imageUrl: 'https://starwalk.space/gallery/images/what-is-space/1920x1080.jpg',
                          fit: BoxFit.cover,
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
