import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:m2/service/ApiService.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/notice_board_model.dart';

class NoticeBoardDetailPage extends StatefulWidget {
  final int id;

  const NoticeBoardDetailPage({super.key, required this.id});

  @override
  State<NoticeBoardDetailPage> createState() => _NoticeBoardDetailPageState();
}

class _NoticeBoardDetailPageState extends State<NoticeBoardDetailPage> {
  late Future<BoardModel> board;

  @override
  void initState() {
    super.initState();
    print('df');
    board = ApiService.getOneBoard(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
            child: ListView(
              children: [
                FutureBuilder(
                    future: board,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.only(left: 23, top: 20.0, right: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Container(
                                      height: height * 0.08,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(99),
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
                                              snapshot.data!.createdAt),
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
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              snapshot.data!.context,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 27,
                                  width: widthForViewCount(height, width),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.bookOpenReader,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "${snapshot.data!.viewCount}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  height: 27,
                                  width: widthForViewCount(height, width),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // const FaIcon(
                                      //   FontAwesomeIcons.solidComment,
                                      const Icon(
                                        Icons.mode_comment,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "${snapshot.data!.commentCount}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String timeFormatter(String dateTime) {
    DateTime parsedCreatedTime = DateTime.parse(dateTime);
    if (DateTime.now().day == parsedCreatedTime.day) {
      return "${DateTime.now().hour - parsedCreatedTime.hour} 시간 전";
    }

    return "${parsedCreatedTime.month} / ${parsedCreatedTime.day}";
  }

  widthForViewCount(double height, double width) {
    if (height > 1000) {
      return width * 0.07;
    }

    return width * 0.17;
  }
}
