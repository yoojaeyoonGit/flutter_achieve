import 'dart:async';

import 'package:flutter/material.dart';
import 'package:m2/main.dart';
import 'package:m2/screen/main/screen/board/f_notice_board.dart';
import 'package:m2/common/widget/w_bottom_nav_button.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../common/widget/w_appbar.dart';
import '../board/vo/vo_board.dart';
import '../reservation/f_reservation_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List basicFragmentList = <Widget>[
    const NoticeBoardFragment(),
    const ReservationFragment(),
  ];

  final PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;
  int pageCount = 12;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    bannerTimer();
  }

  @override
  void dispose() {
    pageController.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double listHeight = MediaQuery.of(context).size.height;

    double pageButtonHeight = MediaQuery.of(context).size.height / 12;
    double width = MediaQuery.of(context).size.width;
    double pageButtonWidth = MediaQuery.of(context).size.width / 2.6;

    List<Padding> pages = List.generate(pageCount,
        (index) => listItem(15, width, pageButtonHeight, currentPage, pageCount));
    return Scaffold(
      appBar: const CustomAppBar("Achieve"),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 3, bottom: 12),
                child: pageViewList(pages),
              ),
            ),
            SizedBox(
              height: listHeight > 800 ? listHeight * 0.53 : listHeight * 0.5,
              child: Image.network(
                  "https://author-picture.s3.ap-northeast-2.amazonaws.com/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA+2024-02-14+%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE+10.11.18.png"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BottomNavButtonWidget(
                    height: pageButtonHeight,
                    width: pageButtonWidth,
                    title: "동아리방 예약",
                    icon: const Icon(
                      Icons.book_online_outlined,
                      color: Colors.white,
                      size: 16,
                    ),
                    fontSize: 16,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ReservationFragment()),
                      );
                    }),
                BottomNavButtonWidget(
                    height: pageButtonHeight,
                    width: pageButtonWidth,
                    title: "공지사항",
                    icon: const Icon(
                      Icons.notification_important_outlined,
                      color: Colors.white,
                      size: 16,
                    ),
                    fontSize: 16,
                    onTap: () {
                      timer.cancel();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NoticeBoardFragment()),
                      ).then((_) => bannerTimer());
                    }),
              ],
            ).pOnly(bottom: pageButtonHeight / 2)
          ],
        ),
      ),
    );
  }

  PageView pageViewList(List<Padding> pages) {
    return PageView.builder(
      controller: pageController,
      itemCount: pages.length,
      onPageChanged: (page) {
        setState(() {
          currentPage = page;
          timer.cancel();
          bannerTimer();
        });
      },
      itemBuilder: (context, index) {
        return pages[index];
      },
    );
  }

  Padding listItem(
      double fontSize, double width, double height, currentPage, pageLength) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, top: height * 0.3, right: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      right: width * 0.02, bottom: height * 0.15),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: width * 0.13,
                      child: Center(
                        child: Text(
                          "${currentPage + 1} / $pageLength",
                          // style: TextStyle(color: Colors.white),
                        ),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void bannerTimer() {
    timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      print(currentPage);
      if (currentPage < pageCount - 1) {
        setState(() {
          currentPage++;
        });
      } else {
        setState(() {
          currentPage = 0;
        });
      }

      if (currentPage == 0) {
        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 1),
          curve: Curves.easeIn,
        );
      } else {
        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }
}
