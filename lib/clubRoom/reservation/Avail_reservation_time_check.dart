import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:m2/widget/informationList.dart';
import 'package:m2/service/ApiService.dart';
import 'package:m2/widget/reservation_avail_list.dart';

import '../../models/Reserved_time_model.dart';

class AvailReservationTime extends StatefulWidget {
  final int id;

  const AvailReservationTime({super.key, required this.id});

  @override
  State<AvailReservationTime> createState() => _AvailReservationTimeState();
}

class _AvailReservationTimeState extends State<AvailReservationTime>
    with TickerProviderStateMixin {
  late Future<List<ReservedTimeModel>> reservedListFromApi;
  late List<ReservedTimeModel> fetchedReservedTimes;
  Map<String, DateTime> reservationAvailTimeMap = {};
  List<String> firstDayReservedAvailList = [];
  List<String> secondDayReservedAvailList = [];
  bool _isLoading = false;
  late ScrollController _scrollController;
  final ScrollController _scrollControllerForTimeFirst = ScrollController();
  final ScrollController _scrollControllerForTimeSecond = ScrollController();
  bool isTop = true;
  int cursorDateNum = 0;

  @override
  initState() {
    super.initState();
    _settingReservedMap(DateTime.now().toString());
    _scrollController = ScrollController()
      ..addListener(() {
        print(isTop);
        setState(() {
          if (_scrollController.offset > 0) {
            isTop = false;
          } else {
            isTop = true;
          }
        });
      });
  }

  void scrollToEnd(ScrollController scrollController) {
    setState(() {
      isTop = false;
    });
    if (scrollController.hasClients) {
      final double maxScrollExtent = scrollController.position.maxScrollExtent;
      scrollController.animateTo(maxScrollExtent,
          duration: const Duration(milliseconds: 100), curve: Curves.linear);
    }
  }

  void scrollToStart(ScrollController scrollController) {
    setState(() {
      isTop = true;
    });
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 100), curve: Curves.linear);
  }

  void _settingReservedMap(String dateTime) {
    DateTime dateTimeParsed = DateTime.parse(dateTime);
    setState(() {
      reservationAvailTimeMap.clear();
      for (int i = 0; i < 48; i++) {
        reservationAvailTimeMap[keyFormatter(dateTimeParsed, i)] = DateTime(
            dateTimeParsed.year,
            dateTimeParsed.month,
            dateTimeParsed.day,
            0 + i);
      }
    });
  }

  Future<void> _fetchReservedListFromApi(
      int cursorDate, String cursorAvailTime) async {
    try {
      setState(() {
        _isLoading = true;
      });
      reservedListFromApi =
          ApiService.getReservedTimes(widget.id, cursorAvailTime);

      fetchedReservedTimes = await reservedListFromApi;

      setState(() {
        _isLoading = false;
      });

      if (fetchedReservedTimes.length > 1) {
        for (var time in fetchedReservedTimes) {
          DateTime parsedTime = DateTime.parse(time.reservationStartTime);

          if (reservationAvailTimeMap
              .containsKey(keyFormatter(parsedTime, -1))) {
            reservationAvailTimeMap.remove(keyFormatter(parsedTime, -1));
          }
        }

        String? firstKey = reservationAvailTimeMap.keys.first;
        dynamic? firstValue = reservationAvailTimeMap[firstKey];
        int firstDay = firstValue.day;
        for (var time in reservationAvailTimeMap.entries) {
          DateTime parsedTime = time.value;

          if (parsedTime.day == firstDay) {
            firstDayReservedAvailList.add(changeDurationForm(parsedTime.hour));
          } else {
            secondDayReservedAvailList.add(changeDurationForm(parsedTime.hour));
          }
        }
      } else {
        for (int i = 0; i < 24; i++) {
          firstDayReservedAvailList.add(changeDurationForm(i));
          secondDayReservedAvailList.add(changeDurationForm(i));
        }
      }
    } catch (error) {
      print("Error fetching reserved times: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width - 40;

    String cursorDateTimeMaker(DateTime time) {
      DateTime cursorDateTimeBefore =
          DateTime(time.year, time.month, time.day, 0, 0);

      print(cursorDateTimeBefore);
      DateTime cursorDateTimeAfter =
          cursorDateTimeBefore.add(Duration(days: cursorDateNum));

      return cursorDateTimeAfter.toString().replaceAll(' ', 'T');
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return WillPopScope(
                          onWillPop: () async {
                            setState(() {
                              isTop = true;
                            });
                            return true;
                          },
                          child: AlertDialog(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            content: SizedBox(
                              width: width * 0.9,
                              height: height * 0.85,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      controller: _scrollController,
                                      itemBuilder: (context, index) {
                                        return Center(
                                            child:
                                                reserveInformationList[index]);
                                      },
                                      itemCount: reserveInformationList.length,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: IconButton(
                                      onPressed: () {
                                        isTop
                                            ? scrollToEnd(_scrollController)
                                            : scrollToStart(_scrollController);
                                      },
                                      icon: isTop
                                          ? const Icon(
                                              Icons.arrow_drop_down_circle)
                                          : const Icon(
                                              Icons.arrow_drop_up_outlined),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        setState(() {
                                          isTop = true;
                                        });
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.black,
                                      ),
                                      child: const Text("확인",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            insetPadding:
                                const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          ),
                        );
                      },
                    );
                  },
                  icon: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: width * 0.45,
                      height: 40,
                      child: const Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "예약 방법 안내",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Icon(
                            Icons.info_outline_rounded,
                            color: Colors.white,
                          )
                        ],
                      )))),
              IconButton(
                  onPressed: () async {
                    _settingReservedMap(DateTime.now().toString());
                    await _fetchReservedListFromApi(
                        cursorDateNum, DateTime.now().toIso8601String());
                    showDialog(
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return WillPopScope(
                          onWillPop: () async {
                            cursorDateNum = 0;
                            reservationAvailTimeMap.clear();
                            firstDayReservedAvailList.clear();
                            secondDayReservedAvailList.clear();
                            return true;
                          },
                          child: AlertDialog(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            content: _isLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : SizedBox(
                                    width: width * 0.9,
                                    height: height * 0.85,
                                    child: Column(
                                      children: [
                                        Text(
                                          "${DateTime.now().year}년",
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                      Icons.chevron_left)),
                                              ReservationAvailListView(
                                                  reservedAvailList:
                                                      firstDayReservedAvailList,
                                                  month: DateTime.now().month,
                                                  day: DateTime.now().day,
                                                  scrollController:
                                                      _scrollControllerForTimeFirst),
                                              ReservationAvailListView(
                                                  reservedAvailList:
                                                      secondDayReservedAvailList,
                                                  month: DateTime.now().month,
                                                  day: DateTime.now()
                                                      .add(const Duration(
                                                          days: 1))
                                                      .day,
                                                  scrollController:
                                                      _scrollControllerForTimeSecond),
                                              IconButton(
                                                  onPressed: () {
                                                    cursorDateNum += 1;
                                                    firstDayReservedAvailList
                                                        .clear();
                                                    secondDayReservedAvailList
                                                        .clear();
                                                    _settingReservedMap(
                                                        cursorDateTimeMaker(
                                                            DateTime.now()));
                                                    _fetchReservedListFromApi(
                                                        cursorDateNum,
                                                        cursorDateTimeMaker(
                                                            DateTime.now()));
                                                      setState(() {
                                                        scrollToStart(
                                                            _scrollControllerForTimeFirst);
                                                        scrollToStart(
                                                            _scrollControllerForTimeSecond);
                                                      });
                                                    // }
                                                  },
                                                  icon: const Icon(
                                                      Icons.chevron_right)),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20.0),
                                          child: TextButton(
                                            onPressed: () {
                                              reservationAvailTimeMap.clear();
                                              firstDayReservedAvailList.clear();
                                              secondDayReservedAvailList
                                                  .clear();
                                              cursorDateNum = 0;
                                              Navigator.of(context).pop();
                                            },
                                            style: TextButton.styleFrom(
                                              backgroundColor: Colors.black,
                                            ),
                                            child: const Text("확인",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                            insetPadding:
                                const EdgeInsets.fromLTRB(0, 30, 0, 30),
                          ),
                        );
                      },
                      context: context,
                    );
                  },
                  icon: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: width * 0.45,
                      height: 40,
                      child: const Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "예약 가능 시간",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Icon(
                            Icons.watch_later_outlined,
                            color: Colors.white,
                          )
                        ],
                      )))),
            ],
          ),
        )
      ],
    );
  }

  String reservationListTimeFormatter(int index) {
    if (index < 10) {
      return "0$index";
    }

    return "$index";
  }

  String keyFormatter(DateTime dateTime, i) {
    if (i == -1) {
      return "${dateTime.year}${dateTime.month}${dateTime.day}${dateTime.hour}";
    }

    if (i < 24) {
      return "${dateTime.year}${dateTime.month}${dateTime.day}${0 + i}";
    }

    return "${dateTime.year}${dateTime.month}${dateTime.day + 1}${0 + (i - 24)}";
  }

  String changeDurationForm(int hour) {
    String stringifyHour = hour.toString();
    String amPmFormat = "";

    if (hour < 12) {
      amPmFormat = "AM";
    } else {
      amPmFormat = "PM";
    }

    if (hour == 0) {
      hour = 12;
    }

    if (stringifyHour.length == 1 && "0" != stringifyHour) {
      return "$amPmFormat 0$hour:00";
    }
    return '$amPmFormat $hour:00';
  }
}
