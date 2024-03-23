import 'package:flutter/material.dart';
import 'package:m2/common/widget/w_height_and_width.dart';
import 'package:m2/screen/main/screen/board/vo/board_type.dart';
import 'package:m2/screen/main/screen/board/w_board_item.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../models/notice_board_model.dart';
import '../../../../service/ApiService.dart';

class NoticeBoardFragment extends StatefulWidget {
  const NoticeBoardFragment({super.key});

  @override
  State<NoticeBoardFragment> createState() => _NoticeBoardFragmentState();
}

class _NoticeBoardFragmentState extends State<NoticeBoardFragment> {
  Future<List<BoardModel>> noticeBoards =
      ApiService.getBoards((BoardType.noticeBoard.name.toUpperCase()), "20");
  bool isTapped = false;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        toolbarHeight: 60,
        title: const Text(
          "공지사항",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: noticeBoards,
              builder: (BuildContext context,
                  AsyncSnapshot<List<BoardModel>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Column(
                            children: [
                              height20,
                              BoardItemWidget(
                                  index: index,
                                  boardModel: snapshot.data![index]),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              BoardItemWidget(
                                  index: index,
                                  boardModel: snapshot.data![index]),
                            ],
                          );
                        }
                      },
                      separatorBuilder: (context, index) {
                        return height20;
                      },
                      itemCount: snapshot.data!.length);
                }

                return const Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ));
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
            ),
            width: width * 0.3,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.create_outlined,
                  color: Colors.white,
                ),
                width10,
                "글 작성".text.white.bold.size(17).make(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
