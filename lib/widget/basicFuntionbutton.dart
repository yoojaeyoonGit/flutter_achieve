import 'package:flutter/material.dart';
import 'package:m2/main.dart';

class BasicFunction extends StatelessWidget {
  const BasicFunction(
      {super.key,
      required this.title,
      required this.height,
      required this.width,
      required this.status,
      required this.fontSize,
      required this.iconSize});

  final Status status;
  final String title;
  final double height;
  final double width;
  final double fontSize;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    IconData icon = status == Status.reservation
        ? Icons.book_online_outlined
        : Icons.notification_important_outlined;

    if (status == Status.reservation) {
      icon = Icons.book_online_outlined;
    }

    if (status == Status.notification) {
      icon = Icons.notification_important_outlined;
    }

    if (status == Status.signUp) {
      icon = Icons.perm_identity_outlined;
    }

    if (status == Status.signIn) {
      icon = Icons.arrow_right_alt_outlined;
    }


    return Container(
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
          Icon(
            icon,
            color: Colors.white,
            size: iconSize,
          ),
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
    );
  }
}
