// import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:m2/clubRoom/reservation/Avail_reservation_time_check.dart';

import 'package:http/http.dart' as http;
import 'package:m2/models/email_request_model.dart';
import 'package:m2/service/ApiService.dart';

class RoomDetail extends StatefulWidget {
  final String roomName;
  final int id;

  const RoomDetail({super.key, required this.roomName, required this.id});

  @override
  State<RoomDetail> createState() => _RoomDetailState();
}

class _RoomDetailState extends State<RoomDetail> {
  late DateTime selectedDateForDate = DateTime.now();
  late DateTime selectedDateAtTime = DateTime.now();
  late DateTime endTime = DateTime.now();
  DateTime selectedFullDate = DateTime.now();
  String durationForm = "";

  @override
  void initState() {
    super.initState();
    _initializeDates();
  }

  void _initializeDates() {
    DateTime now = DateTime.now();

    if (DateTime.now().minute > 30) {
      selectedFullDate =
          DateTime(now.year, now.month, now.day, now.hour + 1, 0, 1);

      selectedDateAtTime = DateTime(now.year, now.month, now.day, now.hour + 1, 0, 1);
    } else {
      selectedFullDate =
          DateTime(now.year, now.month, now.day, now.hour, 0, 1);

      selectedDateAtTime =
          DateTime(now.year, now.month, now.day, now.hour, 0, 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double textSize = width * 0.05;

    List<Container> images = [
      Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        width: width / 1.4,
        child: Image.network(
            "https://yt3.googleusercontent.com/ytc/AIf8zZR8VBlMDZi6X85aGN_jcLIojmXoqPG1vrx93Nmj6w=s900-c-k-c0x00ffffff-no-rj",
            width: width,
            // width / 2,
            fit: BoxFit.cover),
      ),
      Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        width: width / 1.4,
        child: Image.network(
            "https://static01.nyt.com/images/2019/05/31/us/31applehq-01alt/31applehq-01alt-superJumbo.jpg?quality=75&auto=webp",
            height: width / 2,
            width: width,
            // 10,
            fit: BoxFit.cover),
      ),
      Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        width: width / 1.4,
        child: Image.network(
            "https://blog.spoongraphics.co.uk/wp-content/uploads/2009/apple-wallpaper/Picture-5.jpg",
            height: width / 2,
            width: width,
            // width: 10,
            fit: BoxFit.cover),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 80,
        leading: const BackButton(
          color: Colors.white,
        ),
        title: Text(
          widget.roomName,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Hero(
              tag: widget.id,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  // padding: const EdgeInsets.only(bottom: 300),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 40, left: 10, right: 10),
                      child: images[index],
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        width: 20,
                      )),
            ),
          ),
          SizedBox(
            width: 900,
            height: height * 0.56,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width * 2,
                    height: height * 0.15,
                    child: Column(
                      children: [
                        AvailReservationTime(id: widget.id),
                      ],
                    ),
                  ),
                  Text(
                    "예약 시간 (선택)",
                    style: TextStyle(
                      fontSize: textSize,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 13.0),
                        child: Icon(
                          Icons.access_time_outlined,
                          size: textSize,
                        ),
                      ),
                      yearSelectButton(context, textSize),
                      timeSelectedButton(textSize),
                    ],
                  ),
                  SizedBox(
                    height: height / 30,
                  ),
                  Text(
                    "예약 종료 시간",
                    style: TextStyle(
                      fontSize: textSize,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 9),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0, top: 15),
                          child: Icon(
                            Icons.timer_off_outlined,
                            size: textSize,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: width / 20, top: 15),
                          child: Text(
                            endYearFormat(selectedFullDate, endTime),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: textSize),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            endTimeFormatter(selectedFullDate, endTime),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: textSize),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Center(
                      child: IconButton(
                          onPressed: () async {
                            final url = Uri.parse(
                                "https://achieve-project.store/api/email/verification/request");
                            Map data = {"email": "jaeyoon321@naver.com"};

                            var body = json.encode(data);

                            final response = await http.post(url,
                                headers: {"Content-Type": "application/json"},
                                body: body);

                            if (response.statusCode == 200) {
                              final dynamic emailRequestApply =
                                  jsonDecode(response.body);
                              EmailRequestModel message =
                                  EmailRequestModel.fromJson(emailRequestApply);
                            } else {
                              throw Error();
                            }
                          },
                          icon: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: 100,
                            height: 40,
                            child: Center(
                              child: TextButton(
                                onPressed: () {
                                  print(selectedFullDate);
                                  print("${selectedFullDate.add(
                                      const Duration(hours: 1)).subtract(
                                      const Duration(seconds: 1))}");
                                  ApiService.makeReservation(
                                      widget.id,
                                      selectedFullDate,
                                      selectedFullDate
                                          .add(const Duration(hours: 1))
                                          .subtract(
                                              const Duration(seconds: 1)));
                                },
                                child: const Text(
                                  "예약",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String endYearFormat(DateTime selectedFullDate, DateTime endTime) {
    endTime = selectedFullDate;

    setState(() {
      endTime = endTime.add(const Duration(hours: 1));
    });
    return "${endTime.year}. "
        "${endTime.month}. "
        "${endTime.day}. "
        "${weekDayFormatting(endTime.weekday)}";
  }

  String endTimeFormatter(DateTime selectedFullDate, DateTime endTime) {
    endTime = selectedFullDate;
    String endTimeFormat = "";
    setState(() {
      endTime = endTime.add(const Duration(hours: 1));
      endTimeFormat = changeDurationForm(endTime);
    });

    return endTimeFormat;
  }

  String changeDurationForm(DateTime duration) {
    String amPmFormat = "";
    String timeFormat = duration.toString().substring(11, 16);

    if (duration.hour < 12) {
      setState(() {
        amPmFormat = "AM";
      });
    } else {
      setState(() {
        amPmFormat = "PM";
      });
    }

    return '$amPmFormat $timeFormat';
  }

  ElevatedButton yearSelectButton(BuildContext context, double textSize) {
    DateTime? selectedDate;
    double width = MediaQuery.of(context).size.width;
    double textSize = width * 0.05;

    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          elevation: MaterialStateProperty.all(0),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          padding: MaterialStateProperty.resolveWith((states) {
            return EdgeInsets.only(right: width / 90);
          }),
        ),
        onPressed: () async {
          selectedDate = await showDatePicker(
              context: context,
              firstDate: DateTime(DateTime.now().year),
              lastDate: DateTime(DateTime.now().year + 1));

          if (selectedDate != null) {
            selectedDateForDate = DateTime(
                selectedDate!.year,
                selectedDate!.month,
                selectedDate!.day,
                selectedFullDate.hour,
                0,
                1);

            setState(() {
              selectedFullDate = DateTime(
                selectedDateForDate.year,
                selectedDateForDate.month,
                selectedDateForDate.day,
                selectedDateForDate.hour,
                0,
                1,
              );
            });
          }
        },
        child: Text(
          "${selectedDateForDate.year}. "
          "${selectedDateForDate.month}. "
          "${selectedDateForDate.day}. "
          "${weekDayFormatting(selectedDateForDate.weekday)}",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: textSize),
        ));
  }

  String weekDayFormatting(int weekDay) {
    if (weekDay == 1) {
      return "월요일";
    }

    if (weekDay == 2) {
      return "화요일";
    }

    if (weekDay == 3) {
      return "수요일";
    }

    if (weekDay == 4) {
      return "목요일";
    }

    if (weekDay == 5) {
      return "금요일";
    }

    if (weekDay == 6) {
      return "토요일";
    }

    return "일요일";
  }

  CupertinoButton timeSelectedButton(double textSize) {
    double width = MediaQuery.of(context).size.width;

    return CupertinoButton(
      onPressed: () {
        showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) => Container(
            height: width / 1.5,
            padding: const EdgeInsets.only(top: 1.0),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: SafeArea(
              top: false,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: selectedDateAtTime,
                onDateTimeChanged: (DateTime newDateTime) {
                  selectedDateAtTime = DateTime(
                      selectedDateForDate.year,
                      selectedDateForDate.month,
                      selectedDateForDate.day,
                      newDateTime.hour,
                      0,
                      0);

                  selectedFullDate = DateTime(
                      selectedDateForDate.year,
                      selectedDateForDate.month,
                      selectedDateForDate.day,
                      selectedDateAtTime.hour,
                      0,
                      1);

                  setState(() {
                    durationForm = changeDurationForm(selectedFullDate);
                  });
                },
              ),
            ),
          ),
        );
      },
      child: Text(
        durationForm = changeDurationForm(selectedFullDate),
        semanticsLabel: durationForm,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.black,
          fontSize: textSize,
        ),
      ),
    );
  }
}
