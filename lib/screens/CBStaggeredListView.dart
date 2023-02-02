import 'package:cb_stocks/Shared/shared_Screens/basicLayout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CBStaggeredListView extends StatefulWidget {
  final String title;
  const CBStaggeredListView({super.key, required this.title});

  @override
  State<CBStaggeredListView> createState() => _CBStaggeredListViewState();
}

class _CBStaggeredListViewState extends State<CBStaggeredListView> {
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
    Colors.brown,
    Colors.deepOrange,
    Colors.blue,
    Colors.greenAccent,
    Colors.purple
  ];
  @override
  Widget build(BuildContext context) {
    return CBBasicLayout(
        screenHeading: widget.title,
        backIcon: true,
        child: GridView.custom(
          gridDelegate: SliverWovenGridDelegate.count(
            crossAxisCount: 2,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            pattern: [
              const WovenGridTile(1),
              const WovenGridTile(
                5 / 6,
                crossAxisRatio: 0.96,
                alignment: AlignmentDirectional.centerEnd,
              ),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                    decoration: BoxDecoration(
                        color: color[index],
                        borderRadius: BorderRadius.circular(12)),
                  ),
              childCount: color.length),
        ));
  }
}
