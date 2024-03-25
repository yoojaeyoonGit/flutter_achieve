import 'package:flutter/material.dart';
import 'package:m2/main.dart';

class BottomNavButtonWidget extends StatelessWidget {
  // final StatefulWidget fragment;
  final Icon icon;
  final String title;
  final double height;
  final double width;
  final double fontSize;
  final void Function() onTap;

  const BottomNavButtonWidget(
      {super.key,
      required this.title,
      required this.height,
      required this.width,
      required this.icon,
      required this.fontSize,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: fontSize),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
