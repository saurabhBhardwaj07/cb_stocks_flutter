import 'package:cached_network_image/cached_network_image.dart';
import 'package:cb_stocks/utils/CBColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../data/model/images_response.dart';

class CBImageFullViewScreen extends StatefulWidget {
  final List<SingleImagesItem> imageList;
  final int index;
  const CBImageFullViewScreen(
      {super.key, required this.imageList, required this.index});

  @override
  State<CBImageFullViewScreen> createState() => _CBImageFullViewScreenState();
}

class _CBImageFullViewScreenState extends State<CBImageFullViewScreen> {
  PageController imageController = PageController();
  var currentSliderPosition = 0.obs;
  double _currPageValue = 0;

  @override
  void initState() {
    imageController =
        PageController(initialPage: widget.index, viewportFraction: 0.85);
    imageController.addListener(() {
      setState(() {
        _currPageValue = imageController.page!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //scale factor
    double scaleFactor = 0.8;
    //view page height
    double height = 500;
    _buildImagePage(int index) {
      Matrix4 matrix = Matrix4.identity();
      if (index == _currPageValue.floor()) {
        var currScale = 1 - (_currPageValue - index) * (1 - scaleFactor);
        var currTrans = height * (1 - currScale) / 2;
        matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
          ..setTranslationRaw(1, currTrans, 0);
      } else if (index == _currPageValue.floor() + 1) {
        var currScale =
            scaleFactor + (_currPageValue - index + 1) * (1 - scaleFactor);
        var currTrans = height * (1 - currScale) / 2;
        matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
          ..setTranslationRaw(0, currTrans, 0);
      } else if (index == _currPageValue.floor() - 1) {
        var currScale = 1 - (_currPageValue - index) * (1 - scaleFactor);
        var currTrans = height * (1 - currScale) / 2;
        matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
          ..setTranslationRaw(0, currTrans, 0);
      } else {
        var currScale = 0.8;
        matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
          ..setTranslationRaw(0, height * (1 - scaleFactor) / 2, 0);
      }
      var x = widget.imageList[index];
      return Transform(
        transform: matrix,
        child: Padding(
          padding: const EdgeInsets.only(
            right: 10.0,
          ),
          child: CachedNetworkImage(
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height * 0.24,
            imageUrl: x.path ?? "",
            fit: BoxFit.cover,
            errorWidget: (context, url, error) =>
                Image.asset('assets/images/ad_banner.png'),
          ),
        ),
      );
    }

    return Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: true,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0.0,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.black,
              statusBarIconBrightness: Brightness.light),
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.6,
                child: PageView.builder(
                    itemCount: widget.imageList.length,
                    physics: const BouncingScrollPhysics(),
                    controller: imageController,
                    onPageChanged: (index) {
                      currentSliderPosition.value = index;
                    },
                    itemBuilder: (context, position) {
                      return _buildImagePage(position);
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(45.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CBColors.white,
                        ),
                        icon: const Icon(
                          Icons.thumb_up,
                          color: Colors.black,
                        ),
                        label: const Text(
                          'Like',
                          style: TextStyle(color: Colors.black),
                        )),
                    ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CBColors.redCrayola,
                        ),
                        icon: const Icon(Icons.upload),
                        label: const Text('Download')),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
