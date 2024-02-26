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
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

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
                    timeSelectButton(context, "날짜"),
                    SizedBox(
                      width: width / 5,
                    ),
                    CupertinoButton(
                      onPressed: () {
                        showCupertinoModalPopup<void>(
                          context: context,
                          builder: (BuildContext context) //{
                          =>
                              Container(
                                height: height / 3,
                                padding: const EdgeInsets.only(top: 1.0),
                                margin: EdgeInsets.only(
                                  bottom: MediaQuery
                                      .of(context)
                                      .viewInsets
                                      .bottom,
                                ),
                                color: CupertinoColors.systemBackground
                                    .resolveFrom(context),
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
                                        durationForm = changeDurationForm(
                                            selectedFullDate);
                                      });
                                    },
                                  ),
                                ),
                              ),
                        );
                      },
                      child: Text(
                        durationForm = changeDurationForm(selectedFullDate),
                        semanticsLabel: "$durationForm",
                        style: const TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  String changeDurationForm(DateTime duration) {
    return duration.toString().substring(0, 16);
  }

  ElevatedButton timeSelectButton(BuildContext context, String buttonType) {
    DateTime? selectedDate;

    ElevatedButton yearSelectButton = ElevatedButton(
        onPressed: () async {
          selectedDate = await showDatePicker(
              context: context,
              firstDate: DateTime(2024),
              lastDate: DateTime(2025));

          if (selectedDate != null) {
            selectedDateForDate = DateTime(
                selectedDate!.year, selectedDate!.month, selectedDate!.day);

            setState(() {
              selectedFullDate = DateTime(
                selectedDateForDate.year,
                selectedDateForDate.month,
                selectedDateForDate.day,
                selectedDateAtTime.hour,
                selectedDateAtTime.minute % 60,

              );
            });
          }
        },
        child: Text(buttonType));

    return yearSelectButton;
  }

  bool isTimeAllowed(Duration newDuration) {
    Duration one = Duration(hours: 3, minutes: 30);
    Duration two = Duration(hours: 2, minutes: 30);

    if (newDuration == one) {
      return false;
    }

    if (newDuration == two) {
      return false;
    }

    return true;
  }
}
