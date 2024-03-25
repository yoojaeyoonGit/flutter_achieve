import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../common/widget/w_height_and_width.dart';
import 'vo/vo_board.dart';

class BoardStatWidget extends StatelessWidget {
  final Board board;
  final Widget text;
  final double height;
  final double width;
  final Icon icon;

  const BoardStatWidget({
    super.key,
    required this.board,
    required this.text,
    required this.height,
    required this.width,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
      ),
      height: height,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          width5,
          text
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
