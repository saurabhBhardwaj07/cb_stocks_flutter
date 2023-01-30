import 'package:cb_stocks/Shared/shared_Screens/basicLayout.dart';
import 'package:cb_stocks/utils/CBColors.dart';
import 'package:cb_stocks/utils/CBStyles.dart';
import 'package:flutter/material.dart';

class CBHomeScreen extends StatefulWidget {
  const CBHomeScreen({super.key});

  @override
  State<CBHomeScreen> createState() => _CBHomeScreenState();
}

class _CBHomeScreenState extends State<CBHomeScreen> {
  TextEditingController searchCtr = TextEditingController();
  ScrollController scrollCtr = ScrollController();

  List<Color> color = [
    Colors.green,
    Colors.pink,
    Colors.brown,
    Colors.deepOrange,
    Colors.blue,
    Colors.greenAccent,
    Colors.purple
  ];

  List<String> categories = [
    "Abstrack",
    "Nature",
    "Dhoom3",
    "DDLJ",
    "Besharm",
    "YJDK",
    "Welcome"
  ];
  @override
  Widget build(BuildContext context) {
    return CBBasicLayout(
        child: ListView(
      controller: scrollCtr,
      children: [
        const SizedBox(
          height: 30,
        ),
        TextFormField(
          controller: searchCtr,
          style: CBStyles.semiBold600(),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            filled: true,
            hintText: "Find Wallpaper",
            fillColor: CBColors.beauBlue,
            hintStyle: CBStyles.regular400(),
            suffixIcon: Icon(Icons.search, color: Colors.white),
          ),
          onFieldSubmitted: (value) {},
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          'Best Of Wallpaper',
          style: CBStyles.textLabelBrownStyle,
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 180,
          child: ListView.builder(
              controller: scrollCtr,
              shrinkWrap: true,
              itemCount: color.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.of(context).size.width / 2.7,
                  margin: EdgeInsets.symmetric(horizontal: index == 0 ? 0 : 8),
                  decoration: BoxDecoration(
                      color: color[index],
                      borderRadius: BorderRadius.circular(12)),
                );
              }),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'The Color tone',
          style: CBStyles.textLabelBrownStyle,
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 50,
          child: ListView.builder(
              controller: scrollCtr,
              shrinkWrap: true,
              itemCount: color.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: 50,
                  margin: EdgeInsets.symmetric(horizontal: index == 0 ? 0 : 8),
                  decoration: BoxDecoration(
                      color: color[index],
                      borderRadius: BorderRadius.circular(12)),
                );
              }),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Categories',
          style: CBStyles.textLabelBrownStyle,
        ),
        const SizedBox(
          height: 20,
        ),
        GridView.builder(
            itemCount: categories.length,
            shrinkWrap: true,
            controller: scrollCtr,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                mainAxisExtent: 100),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                // width: MediaQuery.of(context).size.width / 2.7,
                // margin: EdgeInsets.symmetric(horizontal: index == 0 ? 0 : 8),
                decoration: BoxDecoration(
                    color: color[index],
                    borderRadius: BorderRadius.circular(12)),

                child: Center(
                  child: Text(
                    categories[index],
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: CBColors.white),
                  ),
                ),
              );
            }),
        SizedBox(
          height: 20,
        ),
      ],
    ));
  }
}
