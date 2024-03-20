import 'package:flutter/material.dart';
import 'package:m2/models/notice_board_model.dart';
import 'package:m2/page/notice_board_page_detail.dart';
import 'package:m2/service/ApiService.dart';
import 'package:m2/widget/board_info_widget.dart';

enum Category { notice, suggestion }

class NoticeBoardPage extends StatefulWidget {
  const NoticeBoardPage({super.key});

  @override
  State<NoticeBoardPage> createState() => _NoticeBoardPageState();
}

class _NoticeBoardPageState extends State<NoticeBoardPage> {
  Future<List<BoardModel>> noticeBoards =
      ApiService.getBoards((Category.notice.name.toUpperCase()), "20");
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
                              const SizedBox(
                                height: 20,
                              ),
                              board(index, snapshot.data![index]),
                            ],
                          );
                        }
                        else {
                          return Column(
                            children: [
                              board(index, snapshot.data![index]),
                            ],
                          );
                        }
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 15,
                        );
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
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.create_outlined,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "글 작성",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  isTappedCondition(int currentIndex, int index) {
    if (isTapped == true && index == currentIndex) {
      return true;
    }

    return false;
  }

  GestureDetector board(int index, BoardModel boardModel) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        currentIndex = index;
        isTapped = true;
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NoticeBoardDetailPage(id: boardModel.id)))
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
          currentIndex = index;
          isTapped = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          isTapped = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
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
          color: isTappedCondition(currentIndex, index)
              ? Colors.grey.shade300
              : Colors.white,
        ),
        height: boardHeight(
          height,
        ),
        width: width * 0.95,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // const Padding(
            //     padding: EdgeInsets.only(left: 20)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(boardModel.title,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 17)),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      boardModel.context,
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        BoardInfo(
                            boardModel: boardModel, category: "commentsCount"),
                        const SizedBox(
                          width: 10,
                        ),
                        BoardInfo(boardModel: boardModel, category: "date"),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double boardHeight(double height) {
    if (height > 700) {
      return height * 0.15;
    }

    return height * 0.2;
  }
}
