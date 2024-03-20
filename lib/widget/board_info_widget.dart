import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/notice_board_model.dart';

class BoardInfo extends StatelessWidget {
  final BoardModel boardModel;
  final String category;

  const BoardInfo(
      {super.key, required this.boardModel, required this.category});

  @override
  Widget build(BuildContext context) {
    bool isDate() {
      if (category == "date") {
        return true;
      }

      return false;
    }

    IconData icon =
        isDate() ? Icons.calendar_month_outlined : Icons.mode_comment_outlined;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
      ),
      height: 22,
      width: isDate()
          ? widthForDate(height, width)
          : widthForMessage(height, width),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            color: Colors.white,
            icon,
            size: 11,
          ),
          const SizedBox(width: 5),
          Text(
            category == "date"
                ? dateFormatter(boardModel.createdAt)
                : boardModel.commentCount.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 11),
          ),
        ],
      ),
    );
  }

  String dateFormatter(String createdAt) {
    String fullFormattedDate = "";
    String month = "";
    String day = "";

    if (DateTime.parse(createdAt).day == DateTime.now().day) {
      int hourAfterCreate = DateTime.now().hour - DateTime.parse(createdAt).hour;
      int minuteAfterCreate = DateTime.now().minute - DateTime.parse(createdAt).minute;

      if (DateTime.parse(createdAt).hour  == DateTime.now().hour) {
        return "$minuteAfterCreate분 전";
      }

      return "$hourAfterCreate시간 전";

    } else {
        month = "0${DateTime.parse(createdAt).month}월 ";

      if (DateTime.parse(createdAt).day < 10) {
        day = "0${DateTime.parse(createdAt).day}일";
      } else {
        day = "${DateTime.parse(createdAt).day}일";
      }
    }

    fullFormattedDate = month + day;
    return fullFormattedDate;
  }

  double widthForMessage(double height, double width) {
    if (height > 1000) {
      return width * 0.06;
    }

    if (height > 700 && height < 1000) {
      return width * 0.11;
    }

    return width * 0.11;
  }

  double widthForDate(double height, double width) {
    if (height > 1000) {
      return width * 0.08;
    }

    if (height > 700 && height < 1000) {
      return width * 0.19;
    }

    return width * 0.22;
  }
}
