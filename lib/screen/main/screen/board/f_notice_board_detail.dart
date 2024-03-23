import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:m2/models/comment_model.dart';
import 'package:m2/screen/main/screen/board/w_board_stat.dart';
import 'package:m2/service/ApiService.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../common/widget/w_height_and_width.dart';
import '../../../../models/notice_board_model.dart';

class NoticeBoardDetail extends StatefulWidget {
  final int id;

  const NoticeBoardDetail({super.key, required this.id});

  @override
  State<NoticeBoardDetail> createState() => _NoticeBoardDetailPageState();
}

class _NoticeBoardDetailPageState extends State<NoticeBoardDetail> {
  late Future<BoardModel> boards;
  late Future<List<CommentModel>> comments;
  final TextEditingController _commentController = TextEditingController();
  bool isEmptyTextField = true;
  String? labelTextForComment = "댓글을 입력하세요.";

  @override
  void initState() {
    super.initState();
    comments = ApiService.getCommentsByBoardId(widget.id, "20");
    boards = ApiService.getOneBoard(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView(
                children: [
                  FutureBuilder(
                      future: boards,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 23, top: 20.0, right: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 20.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 12.0),
                                          child: Container(
                                            height: height * 0.08,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(99),
                                              child: Image.network(
                                                  "https://author-picture.s3.ap-northeast-2.amazonaws.com/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA+2024-03-19+%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE+10.23.00.png"),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: height * 0.09,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "eumbabma",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              const Text(
                                                "Techeer",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                timeFormatter(
                                                    snapshot.data!.createdAt,
                                                    "board"),
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    snapshot.data!.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: height > 700 ? 25 : 22,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    snapshot.data!.context,
                                    style: TextStyle(
                                      fontSize: height > 700 ? 20 : 17,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.03,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      BoardStatWidget(boardModel: snapshot.data!, category: "detailCommentCount"),
                                      width15,
                                      BoardStatWidget(boardModel: snapshot.data!, category: "detailReadCount"),
                                      // Container(
                                      //   height: 27,
                                      //   width: widthForViewCount(height, width),
                                      //   decoration: BoxDecoration(
                                      //     color: Colors.black,
                                      //     borderRadius:
                                      //         BorderRadius.circular(15),
                                      //   ),
                                      //   child: Row(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.center,
                                      //     children: [
                                      //       const FaIcon(
                                      //         FontAwesomeIcons.bookOpenReader,
                                      //         size: 18,
                                      //         color: Colors.white,
                                      //       ),
                                      //       const SizedBox(width: 10),
                                      //       Text(
                                      //         "${snapshot.data!.viewCount}",
                                      //         style: const TextStyle(
                                      //           color: Colors.white,
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),

                                      // Container(
                                      //   height: 27,
                                      //   width: widthForViewCount(height, width),
                                      //   decoration: BoxDecoration(
                                      //     color: Colors.black,
                                      //     borderRadius:
                                      //         BorderRadius.circular(15),
                                      //   ),
                                      //   child: Row(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.center,
                                      //     children: [
                                      //       const Icon(
                                      //         Icons.mode_comment,
                                      //         size: 18,
                                      //         color: Colors.white,
                                      //       ),
                                      //       const SizedBox(width: 10),
                                      //       Text(
                                      //         "${snapshot.data!.commentCount}",
                                      //         style: const TextStyle(
                                      //           color: Colors.white,
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: width,
                              height: 12,
                              color: Colors.grey.shade300,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 23, top: 20.0, right: 24, bottom: 30),
                              child: FutureBuilder(
                                  future: comments,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<CommentModel>>
                                          snapshot) {
                                    if (snapshot.hasData) {
                                      return ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                border: Border.all(width: 1)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 15),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10.0),
                                                    child: Text(
                                                      snapshot
                                                          .data![index].context,
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  Text(
                                                    timeFormatter(
                                                        snapshot.data![index]
                                                            .createdAt,
                                                        "comment"),
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade600),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return const SizedBox(
                                            height: 20,
                                          );
                                        },
                                        itemCount: snapshot.data!.length,
                                      );
                                    }

                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }),
                            )
                          ],
                        );
                      }),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 23,
                  right: 23,
                  top: 10,
                  bottom: checkHeight(height) ? 12 : 26),
              child: Container(
                width: width - 20,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 0.06,
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            isEmptyTextField = false;
                            if (_commentController.text == "") {
                              isEmptyTextField = true;
                            }
                          });
                        },
                        // keyboardType: TextInputType.multiline,
                        maxLines: isEmptyTextField ? 1 : 3,
                        cursorColor: Colors.white,
                        cursorWidth: 2.0,
                        cursorHeight: 20,
                        style: TextStyle(
                            fontSize: checkHeight(height) ? 14 : 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                        controller: _commentController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 4),
                            border: InputBorder.none,
                            hintText: labelTextForComment,
                            hintStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 14)),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.1,
                      child: IconButton(
                        onPressed: () async {
                          await ApiService.createComment(
                              _commentController.text, widget.id);

                          setState(() {
                            comments = ApiService.getCommentsByBoardId(
                                widget.id, "20");
                          });
                        },
                        icon: const FaIcon(FontAwesomeIcons.penToSquare),
                        iconSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String timeFormatter(String dateTime, String type) {
    DateTime parsedCreatedTime = DateTime.parse(dateTime);

    if (type == "board") {
      if (DateTime.now().day == parsedCreatedTime.day) {
        return "${DateTime.now().hour - parsedCreatedTime.hour}시간 전";
      }

      if (DateTime.now().day - parsedCreatedTime.day == 1) {
        if (DateTime.now()
                .subtract(Duration(hours: parsedCreatedTime.hour))
                .hour ==
            0) {
          return "${parsedCreatedTime.month} / ${parsedCreatedTime.day}";
        }
        return "${DateTime.now().subtract(Duration(hours: parsedCreatedTime.hour)).hour} 시간 전";
      }

      return "${parsedCreatedTime.month} / ${parsedCreatedTime.day}";
    }

    if (DateTime.now().hour == parsedCreatedTime.hour) {
      return "${DateTime.now().minute - parsedCreatedTime.minute}분 전";
    }

    if (DateTime.now().day == parsedCreatedTime.day) {
      return "${DateTime.now().hour - parsedCreatedTime.hour}시간 전";
    }

    return "${parsedCreatedTime.month}/${parsedCreatedTime.day} ${zeroFormatter(parsedCreatedTime.hour)}:${zeroFormatter(parsedCreatedTime.minute)}";
  }

  String zeroFormatter(int time) {
    if (time < 10) {
      return "0$time";
    }

    return time.toString();
  }

  widthForViewCount(double height, double width) {
    if (height > 1000) {
      return width * 0.07;
    }

    return width * 0.17;
  }

  bool checkHeight(double height) {
    return height < 700 ? true : false;
  }
}
