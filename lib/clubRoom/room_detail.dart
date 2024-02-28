// import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoomDetail extends StatefulWidget {
  final String roomName;

  const RoomDetail({super.key, required this.roomName});

  @override
  State<RoomDetail> createState() => _RoomDetailState();
}

class _RoomDetailState extends State<RoomDetail> {
  // Duration duration = const Duration(hours: 00, minutes: 00, seconds: 00);
  late DateTime selectedDateForDate = DateTime.now();
  late DateTime selectedDateAtTime = DateTime.now();
  DateTime selectedFullDate = DateTime.now();
  String durationForm = "";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double textSize = width * 0.05;

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: height / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "예약 시간",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Icon(
                        Icons.access_time_outlined,
                        size: textSize,
                      ),
                    ),
                    yearSelectButton(context, textSize),
                    timeSelectedButton(textSize)
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  String changeDurationForm(double left, DateTime duration) {
    String amPmFormat = "";
    String timeFormat = duration.toString().substring(11, 16);

    print('${duration.hour}');
    if (duration.hour < 13) {
      amPmFormat = "오전";
    }
    amPmFormat = "오후";


    return '${amPmFormat} ${timeFormat}';
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
          shadowColor:
              MaterialStateProperty.all(Colors.transparent), // 그림자 색을 투명으로 설정
          padding: MaterialStateProperty.resolveWith((states) {
            return EdgeInsets.only(right: width/20);
          }),
        ),
        onPressed: () async {
          selectedDate = await showDatePicker(
              context: context,
              firstDate: DateTime(DateTime.now().year),
              lastDate: DateTime(DateTime.now().year + 1));

          if (selectedDate != null) {
            selectedDateForDate = DateTime(
                selectedDate!.year, selectedDate!.month, selectedDate!.day);

            setState(() {
              selectedFullDate = DateTime(
                selectedDateForDate.year,
                selectedDateForDate.month,
                selectedDateForDate.day,
                selectedDateForDate.weekday,
                selectedDateAtTime.hour,
                selectedDateAtTime.minute % 60,
              );
            });
          }
        },
        child: Text(
          "${selectedDateForDate.year} - ${selectedDateForDate.month} - ${selectedDateForDate.day} - ${weekDayFormatting(selectedDateForDate.weekday)}",
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
          builder: (BuildContext context) //{
              =>
              Container(
            height: width/2,
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
                      selectedDateAtTime.minute % 60);

                  setState(() {
                    durationForm = changeDurationForm(width, selectedFullDate);
                  });
                },
              ),
            ),
          ),
        );
      },
      child: Text(
        durationForm = changeDurationForm(width, selectedFullDate),


        semanticsLabel: "$durationForm",
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.black,
          fontSize: textSize,
        ),
      ),
    );
  }

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
