import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../common/widget/w_height_and_width.dart';
import '../../../../models/notice_board_model.dart';

class BoardStatWidget extends StatelessWidget {
  final BoardModel boardModel;
  final String text;
  final double height;
  final double width;
  final IconData iconData;

  const BoardStatWidget({
    super.key,
    required this.boardModel,
    required this.text,
    required this.height,
    required this.width,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
      ),
      height: height,
      //isCategoryDetail(category) ? 27 : 22,
      width: width,
      // widthForStat(category, height, width),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            color: Colors.white,
            iconData,
            size: 11
          ),
          width5,
          text.text.white.make(),
        ],
      ),
    );
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
