import 'package:cached_network_image/cached_network_image.dart';
import 'package:cb_stocks/Shared/shared_Screens/basicLayout.dart';
import 'package:cb_stocks/data/repository.dart';
import 'package:cb_stocks/utils/CBColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/model/images_response.dart';

class CBImageFullViewScreen extends StatefulWidget {
  List<SingleImagesItem> imageList;
  int index;

  CBImageFullViewScreen(
      {super.key, required this.imageList, required this.index});

  @override
  State<CBImageFullViewScreen> createState() => _CBImageFullViewScreenState();
}

class _CBImageFullViewScreenState extends State<CBImageFullViewScreen> {
  final controller = ScrollController();
  @override
  void initState() {
    imageLiked.value = widget.imageList[widget.index].isLiked;
    super.initState();
  }

  List<Color> color = [
    Colors.green,
    Colors.pink,
    Colors.brown,
    Colors.deepOrange,
    Colors.blue,
    Colors.greenAccent,
    Colors.purple,
    Colors.green,
    Colors.pink,
  ];

  var imageLiked = false.obs;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double horizontalPadding = size.width * 0.05;
    return CBBasicLayout(
      backIcon: true,
      hasParentPadding: false,
      child: ListView(
        controller: controller,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                widget.index == 0
                    ? const SizedBox(
                        width: 20,
                      )
                    : InkWell(
                        onTap: () {
                          if (widget.index > 0) {
                            widget.index--;
                            imageLiked.value =
                                widget.imageList[widget.index].isLiked;
                            setState(() {});
                          }
                        },
                        child: const Icon(Icons.arrow_back_ios)),
                Expanded(
                  child: CachedNetworkImage(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    imageUrl: widget.imageList[widget.index].path ?? "",
                    fit: BoxFit.fitHeight,
                    errorWidget: (context, url, error) =>
                        Image.asset('assets/icons/ad_banner.png'),
                  ),
                ),
                widget.index < widget.imageList.length - 1
                    ? InkWell(
                        onTap: () {
                          print(widget.index);
                          print(widget.imageList.length);
                          if (widget.index < widget.imageList.length - 1) {
                            widget.index++;
                            imageLiked.value =
                                widget.imageList[widget.index].isLiked;
                            setState(() {});
                          }
                        },
                        child: const RotatedBox(
                            quarterTurns: 2, child: Icon(Icons.arrow_back_ios)))
                    : const SizedBox(
                        width: 20,
                      ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.imageList[widget.index].name ?? "",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          widget.imageList[widget.index].likes.toString(),
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        ElevatedButton.icon(
                            onPressed: () async {
                              if (imageLiked.value == true) {
                                imageLiked.value = !imageLiked.value;
                                widget.imageList[widget.index].likes--;
                                widget.imageList[widget.index].isLiked =
                                    imageLiked.value;
                                setState(() {});
                              } else {
                                imageLiked.value = !imageLiked.value;
                                widget.imageList[widget.index].likes++;
                                widget.imageList[widget.index].isLiked =
                                    imageLiked.value;
                                setState(() {});
                              }

                              await repository
                                  .likeImage(widget.imageList[widget.index].id
                                      .toString())
                                  .then((value) {});
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CBColors.white,
                            ),
                            icon: Icon(
                              Icons.thumb_up,
                              color: imageLiked.value
                                  ? Colors.redAccent
                                  : Colors.black,
                            ),
                            label: const Text(
                              'Like',
                              style: TextStyle(color: Colors.black),
                            )),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          widget.imageList[widget.index].downloads.toString(),
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        ElevatedButton.icon(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CBColors.redCrayola,
                            ),
                            icon: const Icon(Icons.upload),
                            label: const Text('Download')),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: GridView.builder(
                itemCount: color.length,
                controller: controller,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    mainAxisExtent: 140),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      decoration: BoxDecoration(
                          color: color[index],
                          borderRadius: BorderRadius.circular(12)));
                }),
          ),
        ],
      ),
    );
  }
}
