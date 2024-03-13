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

class _AvailReservationTimeState extends State<AvailReservationTime> {
  late Future<List<ReservedTimeModel>> reservedListFromApi;
  late List<ReservedTimeModel> fetchedReservedTimes;
  Map<String, DateTime> reservationAvailTimeMap = {};
  List<String> firstDayReservedAvailList = [];
  List<String> secondDayReservedAvailList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _settingReservedMap();
    // _fetchReservedListFromApi();
  }

  void _settingReservedMap() {
    for (int i = 0; i < 48; i++) {
      reservationAvailTimeMap[keyFormatter(DateTime.now(), i)] = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 0 + i);
    }
  }

  Future<void> _fetchReservedListFromApi() async {
    try {
      setState(() {
        _isLoading = true; // 데이터 로딩 시작
      });
      reservedListFromApi = ApiService.getReservedTimes(widget.id);
      fetchedReservedTimes = await reservedListFromApi;

      setState(() {
        _isLoading = false; // 데이터 로딩 시작
        print(_isLoading);
      });

      if (fetchedReservedTimes.length > 1) {
        for (var time in fetchedReservedTimes) {
          DateTime parsedTime = DateTime.parse(time.reservationStartTime);

          if (reservationAvailTimeMap
              .containsKey(keyFormatter(parsedTime, -1))) {
            reservationAvailTimeMap.remove(keyFormatter(parsedTime, -1));
          }
        }
        setState(() {
          for (var time in reservationAvailTimeMap.entries) {
            DateTime parsedTime = time.value;
            int firstDay =
                DateTime.parse(fetchedReservedTimes[0].reservationStartTime)
                    .day;
            if (parsedTime.day == firstDay) {
              firstDayReservedAvailList
                  .add(changeDurationForm(parsedTime.hour));
            } else {
              secondDayReservedAvailList
                  .add(changeDurationForm(parsedTime.hour));
            }
          }
        });
      } else {
        setState(() {
          for (int i = 0; i < 24; i++) {
            firstDayReservedAvailList.add(changeDurationForm(i));
            secondDayReservedAvailList.add(changeDurationForm(i));
          }
        });
      }
    } catch (error) {
      print("Error fetching reserved times: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width - 40;

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
                        return AlertDialog(
                          content: SizedBox(
                            width: width * 0.5,
                            height: height / 2,
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return reserveInformationList[index];
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      width: 20,
                                    ),
                                itemCount: reserveInformationList.length),
                          ),
                          insetPadding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                              child: const Text("확인",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                            )
                          ],
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
                    await _fetchReservedListFromApi();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: _isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : SizedBox(
                                  width: width * 0.75,
                                  child: Column(
                                    children: [
                                      Text(
                                        "${DateTime.now().year}년",
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            ReservationAvailListView(
                                              reservedAvailList:
                                                  firstDayReservedAvailList,
                                              month: DateTime.now().month,
                                              day: DateTime.now().day,
                                            ),
                                            ReservationAvailListView(
                                              reservedAvailList:
                                                  secondDayReservedAvailList,
                                              month: DateTime.now().month,
                                              day: DateTime.now()
                                                  .add(const Duration(days: 1))
                                                  .day,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          insetPadding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                              child: const Text("확인",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                            )
                          ],
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
      amPmFormat = "오전";
    } else {
      amPmFormat = "오후";
    }

    if (hour == 0) {
      hour = 12;
    }

    if (stringifyHour.length == 1 && "0" != stringifyHour) {
      return "$amPmFormat 0$hour";
    }
    return '$amPmFormat $hour';
  }
}
