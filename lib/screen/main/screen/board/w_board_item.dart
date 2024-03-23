import 'package:flutter/material.dart';
import 'package:m2/screen/main/screen/board/vo/board_type.dart';
import 'package:m2/screen/main/screen/board/vo/vo_board.dart';
import 'package:m2/screen/main/screen/board/w_board_stat.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../common/widget/w_height_and_width.dart';
import '../../../../models/notice_board_model.dart';
import '../../../../service/ApiService.dart';
import 'f_notice_board_detail.dart';

class BoardItemWidget extends StatefulWidget {
  final int index;
  final BoardModel boardModel;
  const BoardItemWidget({super.key, required this.index, required this.boardModel});

  @override
  State<BoardItemWidget> createState() => _BoardItemWidgetState();
}

class _BoardItemWidgetState extends State<BoardItemWidget> {
  Future<List<BoardModel>> noticeBoards =
  ApiService.getBoards((BoardType.noticeBoard.name.toUpperCase()), "20");
  bool isTapped = false;
  int currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 0.3),
      ),
      child: GestureDetector(
        onTap: () {
          currentIndex = widget.index;
          isTapped = true;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      NoticeBoardDetail(id: widget.boardModel.id)))
              .then((value) => setState(() {
            isTapped = false;
          }));
        },
        onTapCancel: () {
          setState(() {
            isTapped = false;
          });
        },
        onTapDown: (_) {
          setState(() {
            currentIndex = widget.index;
            isTapped = true;
          });
        },
        onTapUp: (_) {
          setState(() {
            isTapped = false;
          });
        },
        child: AnimatedContainer(
          duration: 300.milliseconds,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4), // 그림자 색상 및 투명도
                spreadRadius: 3, // 그림자 전파 반경
                blurRadius: 8, // 그림자 흐림 반경
                offset: const Offset(0, 8), // 그림자 위치
              ),
            ],
            borderRadius: BorderRadius.circular(15),
            color: isTappedCondition(currentIndex, widget.index)
                ? Colors.grey.shade300
                : Colors.white,
          ),
          height: boardHeight(
            height,
          ),
          width: width * 0.95,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.boardModel.title.text.bold.size(17).make(),
                    widget.boardModel.context.text.black.size(15).maxLines(2).make(),
                    height10,
                    Row(
                      children: [
                        BoardStatWidget(
                            boardModel: widget.boardModel, category: "commentCount"),
                        width10,
                        BoardStatWidget(
                            boardModel: widget.boardModel, category: "date"),
                      ],
                    )
                  ],
                ).pOnly(left: 20, right: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  isTappedCondition(int currentIndex, int index) {
    if (isTapped == true && index == currentIndex) {
      return true;
    }

    return false;
  }

  double boardHeight(double height) {
    if (height > 700) {
      return height * 0.15;
    }

    return height * 0.2;
  }
}
