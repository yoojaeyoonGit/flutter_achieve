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

    IconData icon = isDate() ? Icons.calendar_month_outlined : Icons
        .calendar_month_outlined;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
      ),
      height: 22,
      width: isDate() ? width * 0.19 : width * 0.11,
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
            style: const TextStyle(
                color: Colors.white, fontSize: 11),
          ),
        ],
      ),
    );
  }

  String dateFormatter(String createdAt) {
    if (DateTime
        .parse(createdAt)
        .day == DateTime
        .now()
        .day) {
      if (DateTime
          .parse(createdAt)
          .hour < 10) {
        return "0${DateTime
            .parse(createdAt)
            .hour} / ${DateTime
            .parse(createdAt)
            .minute}";
      }
      return "${DateTime
          .parse(createdAt)
          .hour} / ${DateTime
          .parse(createdAt)
          .minute}";
    }

    return "${DateTime
        .parse(createdAt)
        .month / DateTime
        .parse(createdAt)
        .day}";
  }
}
