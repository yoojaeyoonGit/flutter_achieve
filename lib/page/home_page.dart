
import 'package:flutter/material.dart';
import 'package:m2/main.dart';
import 'package:m2/page/NoticeBoardPage.dart';
import 'package:m2/page/ReservationPage.dart';
import 'package:m2/widget/basicFuntionbutton.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController controller = PageController(initialPage: 0);
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    double listHeight = MediaQuery.of(context).size.height;

    double fontSize;
    double iconSize;

    if (listHeight > 1100) {
      fontSize = 25;
      iconSize = 25;
    } else {
      fontSize = 15;
      iconSize = 17;
    }

    double height = MediaQuery.of(context).size.height / 12;

    double width2 = MediaQuery.of(context).size.width;

    double width = MediaQuery.of(context).size.width / 2.6;

    List<Padding> pages =
    List.generate(12, (index) => listItem(fontSize, width2, height));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 80,
        title: const Text(
          "Achieve",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: height / 3),
                child: pageViewList(width, pages),
              ),
            ),
            SizedBox(
              height: listHeight / 2,
              child: Image.network(
                  "https://author-picture.s3.ap-northeast-2.amazonaws.com/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA+2024-02-14+%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE+10.11.18.png"),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: height / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          // builder: (context) => const ReservationPage()),
                            builder: (context) => const ReservationPage()),
                      );

                    },
                    child: BasicFunction(
                      height: height,
                      width: width,
                      title: "동아리방 예약",
                      status: Status.reservation,
                      fontSize: fontSize,
                      iconSize: iconSize,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NoticeBoardPage()),
                        // builder: (context) => NoticeBoardPage()),
                      );
                    },
                    child: BasicFunction(
                        height: height,
                        width: width,
                        title: "공지사항",
                        status: Status.notification,
                        fontSize: fontSize,
                        iconSize: iconSize),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  PageView pageViewList(double width, List<Padding> pages) {
    return PageView.builder(
        controller: controller,
        itemCount: pages.length,
        onPageChanged: (page) {
          setState(() {
            currentPage = page;
          });
        },
        itemBuilder: (context, index) {
          return pages[index];
        });
  }

  Padding listItem(double fontSize, double width, double height) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: 10,
        width: width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      height: 20,
                      width: 70,
                      child: const Center(
                        child: Text(
                          "Achieve",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "테커 동아리방 예약 시스템 \n예약과 취소를 간편하게!",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: fontSize,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}