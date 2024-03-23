import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../common/widget/w_height_and_width.dart';
import '../../../../models/notice_board_model.dart';

class BoardStatWidget extends StatelessWidget {
  final BoardModel boardModel;
  final String category;

  const BoardStatWidget(
      {super.key, required this.boardModel, required this.category});

  @override
  Widget build(BuildContext context) {
    String statText = "";

    IconData icon() {
      if (category == "detailReadCount") {
        statText = "${boardModel.viewCount}";
        return FontAwesomeIcons.bookOpenReader;
      }

      if (category == "detailCommentCount") {

        statText = "${boardModel.commentCount}";
        return Icons.mode_comment;
      }

      if (category == "commentCount") {
        statText = "${boardModel.commentCount}";
        return Icons.mode_comment_outlined;
      }

      statText = dateFormatter(boardModel.createdAt);
      return Icons.calendar_month_outlined;
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
      ),
      height: isCategoryDetail(category) ? 27 : 22,
      width: widthForStat(category, height, width),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            color: Colors.white,
            icon(),
            size: isCategoryDetail(category) ? 18 : 11,
          ),
          width5,
          statText.text.white.size(isCategoryDetail(category) ? 14 : 11).make(),
        ],
      ),
    );
  }

  String dateFormatter(String createdAt) {
    String fullFormattedDate = "";
    String month = "";
    String day = "";

    if (DateTime.parse(createdAt).day == DateTime.now().day) {
      int hourAfterCreate =
          DateTime.now().hour - DateTime.parse(createdAt).hour;
      int minuteAfterCreate =
          DateTime.now().minute - DateTime.parse(createdAt).minute;

      if (DateTime.parse(createdAt).hour == DateTime.now().hour) {
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

  bool isCategoryDetail(String category) {
    if (category.contains("detail")) {
      return true;
    }

    return false;
  }

  double widthForStat(String category, double height, double width) {
    if (isCategoryDetail(category)) {
      return widthForViewCount(height, width);
    }

    if (category == "date") {
      return widthForDate(height, width);
    }

    return widthForMessage(height, width);
  }

  widthForViewCount(double height, double width) {
    if (height > 1000) {
      return width * 0.07;
    }

    return width * 0.17;
  }

  double widthForMessage(double height, double width) {
    if (height > 1000) {
      return width * 0.06;
    }

    if (height > 700 && height < 1000) {
      return width * 0.11;
    }

    return width * 0.14;
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
