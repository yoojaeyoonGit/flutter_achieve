import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YearSelectButton extends StatefulWidget {
  final DateTime selectedFullDate;

  const YearSelectButton({Key? key, required this.selectedFullDate}) : super(key: key);

  @override
  State<YearSelectButton> createState() => _YearSelectButtonState();
}
class _YearSelectButtonState extends State<YearSelectButton> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedFullDate;
  }

  @override
  Widget build(BuildContext context) {
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
        var selectedDate = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 365)),
        );

        if (selectedDate != null) {
          setState(() {
            _selectedDate = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              selectedDate.hour,
              selectedDate.minute % 60,
            );
          });
        }
      },
      child: Text(
        "${_selectedDate.year}. ${_selectedDate.month}. ${_selectedDate.day}. ${weekDayFormatting(_selectedDate.weekday)}",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: textSize,
        ),
      ),
    );
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

}
