import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  double? width;
  double height;
  String title;
  Color? borderColor;
  Color iconColor;
  Color? bgColor;
  Color textColor;
  IconData icon;
  String? count;
  final VoidCallback onPressed;

  CustomButton(
      {Key? key,
      this.width,
      required this.height,
      required this.title,
      this.borderColor,
      required this.icon,
      this.bgColor = Colors.white,
      this.iconColor = Colors.white,
      this.count,
      this.textColor = Colors.white,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
            ),
            const SizedBox(
              width: 4,
            ),
            count != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: Text(
                      count!,
                      style: TextStyle(color: textColor),
                    ),
                  )
                : const SizedBox(),
            Text(
              title,
              style: TextStyle(color: textColor),
            )
          ],
        ),
      ),
    );
  }
}
