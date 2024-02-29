// import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m2/clubRoom/button/time_select_button.dart';
import 'package:m2/clubRoom/button/year_select_button.dart';

class RoomDetail extends StatefulWidget {
  final String roomName;

  const RoomDetail({super.key, required this.roomName});

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
        // height: 10,
        width: width / 1.4,
        child: Image.network(
            "https://yt3.googleusercontent.com/ytc/AIf8zZR8VBlMDZi6X85aGN_jcLIojmXoqPG1vrx93Nmj6w=s900-c-k-c0x00ffffff-no-rj",
            width: width / 2,
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
            width: 10,
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
            width: 10,
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
          Container(
            // color: Colors.red,
            height: height / 1.9,
            child: Padding(
              padding: EdgeInsets.only(left: 15.0, top: height * 0.03),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height * 0.15,
                    color: Colors.red,
                    child: const Column(
                      children: [
                        Text("예약 가능 시간 확인"),
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
                        child: timeIcon(textSize),
                      ),
                      YearSelectButton(selectedFullDate: DateTime.now()),
                      TimeSelectButton(
                          dateForm: durationForm,
                          selectedDateAtTime: selectedDateAtTime,
                          selectedDateForDate: selectedDateForDate,
                          selectedFullDate: selectedFullDate)
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
                    padding: EdgeInsets.only(bottom: 9),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0, top: 15),
                          child: timeIcon(textSize),
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
        amPmFormat = "오전";
      });
    } else {
      setState(() {
        amPmFormat = "오후";
      });
    }

    return '$amPmFormat $timeFormat';
  }

  // ElevatedButton yearSelectButton(BuildContext context, double textSize) {
  //   DateTime? selectedDate;
  //   double width = MediaQuery.of(context).size.width;
  //   double textSize = width * 0.05;
  //
  //   return ElevatedButton(
  //       style: ButtonStyle(
  //         backgroundColor: MaterialStateProperty.all(Colors.transparent),
  //         elevation: MaterialStateProperty.all(0),
  //         overlayColor: MaterialStateProperty.all(Colors.transparent),
  //         shadowColor: MaterialStateProperty.all(Colors.transparent),
  //         padding: MaterialStateProperty.resolveWith((states) {
  //           return EdgeInsets.only(right: width / 90);
  //         }),
  //       ),
  //       onPressed: () async {
  //         selectedDate = await showDatePicker(
  //             context: context,
  //             firstDate: DateTime(DateTime.now().year),
  //             lastDate: DateTime(DateTime.now().year + 1));
  //
  //         if (selectedDate != null) {
  //           selectedDateForDate = DateTime(
  //               selectedDate!.year, selectedDate!.month, selectedDate!.day);
  //
  //           setState(() {
  //             selectedFullDate = DateTime(
  //               selectedDateForDate.year,
  //               selectedDateForDate.month,
  //               selectedDateForDate.day,
  //               selectedDateForDate.weekday,
  //               selectedDateAtTime.hour,
  //               selectedDateAtTime.minute % 60,
  //             );
  //           });
  //         }
  //       },
  //       child: Text(
  //         "${selectedDateForDate.year}. ${selectedDateForDate.month}. ${selectedDateForDate.day}. ${weekDayFormatting(selectedDateForDate.weekday)}",
  //         style: TextStyle(
  //             color: Colors.black,
  //             fontWeight: FontWeight.w400,
  //             fontSize: textSize),
  //       ));
  // }

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

  // CupertinoButton timeSelectedButton(double textSize) {
  //   double width = MediaQuery.of(context).size.width;
  //
  //   return CupertinoButton(
  //     onPressed: () {
  //       showCupertinoModalPopup<void>(
  //         context: context,
  //         builder: (BuildContext context) => Container(
  //           height: width/1.5,
  //           padding: const EdgeInsets.only(top: 1.0),
  //           margin: EdgeInsets.only(
  //             bottom: MediaQuery.of(context).viewInsets.bottom,
  //           ),
  //           color: CupertinoColors.systemBackground.resolveFrom(context),
  //           child: SafeArea(
  //             top: false,
  //             child: CupertinoDatePicker(
  //               mode: CupertinoDatePickerMode.time,
  //               initialDateTime: selectedDateAtTime,
  //               onDateTimeChanged: (DateTime newDateTime) {
  //                 selectedDateAtTime = DateTime(
  //                     selectedDateForDate.year,
  //                     selectedDateForDate.month,
  //                     selectedDateForDate.day,
  //                     newDateTime.hour,
  //                     0,
  //                     0);
  //
  //                 selectedFullDate = DateTime(
  //                     selectedDateForDate.year,
  //                     selectedDateForDate.month,
  //                     selectedDateForDate.day,
  //                     selectedDateAtTime.hour,
  //                     0);
  //
  //                 setState(() {
  //                   durationForm = changeDurationForm(selectedFullDate);
  //                 });
  //               },
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //     child: Text(
  //       durationForm = changeDurationForm(selectedFullDate),
  //       semanticsLabel: durationForm,
  //       style: TextStyle(
  //         fontWeight: FontWeight.w400,
  //         color: Colors.black,
  //         fontSize: textSize,
  //       ),
  //     ),
  //   );
  // }

  bool isTimeAllowed(Duration newDuration) {
    Duration one = const Duration(hours: 3, minutes: 30);
    Duration two = const Duration(hours: 2, minutes: 30);

    if (newDuration == one) {
      return false;
    }

    if (newDuration == two) {
      return false;
    }

    return true;
  }
}

Icon timeIcon(double textSize) {
  return Icon(
    Icons.access_time_outlined,
    size: textSize,
  );
}
