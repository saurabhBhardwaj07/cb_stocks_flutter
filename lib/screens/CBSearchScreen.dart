import 'package:cb_stocks/Shared/shared_Screens/basicLayout.dart';
import 'package:cb_stocks/utils/CBColors.dart';
import 'package:cb_stocks/utils/CBStyles.dart';
import 'package:flutter/material.dart';

class CBSearchScreen extends StatefulWidget {
  const CBSearchScreen({super.key});

  @override
  State<CBSearchScreen> createState() => _CBSearchScreenState();
}

class _CBSearchScreenState extends State<CBSearchScreen> {
  TextEditingController searchCtr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CBBasicLayout(
        backIcon: true,
        screenHeading: 'Search',
        child: Column(
          children: [
            TextFormField(
              controller: searchCtr,
              style: CBStyles.semiBold600(),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                filled: true,
                hintText: "Find Wallpaper",
                fillColor: Colors.white,
                suffixIcon: const Icon(
                  Icons.search,
                  color: CBColors.prusianBlue,
                ),
                hintStyle: CBStyles.regular400(),
              ),
              onFieldSubmitted: (value) {},
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ));
  }
}
