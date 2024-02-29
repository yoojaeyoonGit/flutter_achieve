import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeSelectButton extends StatefulWidget {
  final DateTime selectedDateAtTime;
  final DateTime selectedDateForDate;
  final DateTime selectedFullDate;
  final String dateForm;

  const TimeSelectButton(
      {super.key,
      required this.dateForm,
      required this.selectedDateAtTime,
      required this.selectedDateForDate,
      required this.selectedFullDate});

  @override
  State<TimeSelectButton> createState() => _TimeSelectButtonState();
}

class _TimeSelectButtonState extends State<TimeSelectButton> {
  late DateTime _selectedTime;
  late DateTime _selectedDate;
  late DateTime _selectedFullDateAndTime;
  late String durationForm;

  @override
  void initState() {
    super.initState();
    _selectedFullDateAndTime = widget.selectedFullDate;
    _selectedTime = widget.selectedDateAtTime;
    _selectedDate = widget.selectedDateForDate;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double textSize = width * 0.05;
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
                initialDateTime: _selectedTime,
                onDateTimeChanged: (DateTime newDateTime) {
                  _selectedTime = DateTime(
                      _selectedDate.year,
                      _selectedDate.month,
                      _selectedDate.day,
                      newDateTime.hour,
                      0,
                      0);

                  _selectedFullDateAndTime = DateTime(
                      _selectedDate.year,
                      _selectedDate.month,
                      _selectedDate.day,
                      _selectedDate.hour,
                      0);

                  setState(() {
                    durationForm = changeDurationForm(_selectedFullDateAndTime);
                  });
                },
              ),
            ),
          ),
        );
      },
      child: Text(
        durationForm = changeDurationForm(_selectedFullDateAndTime),
        semanticsLabel: durationForm,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.black,
          fontSize: textSize,
        ),
      ),
    );
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
}
