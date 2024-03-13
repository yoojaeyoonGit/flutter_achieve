import 'package:flutter/material.dart';

class ReservationAvailListView extends StatefulWidget {
  final List<String> reservedAvailList;
  final int month;
  final int day;

  const ReservationAvailListView(
      {super.key,
        required this.reservedAvailList, required this.month, required this.day});

  @override
  State<ReservationAvailListView> createState() => _ReservationAvailListViewState();
}

class _ReservationAvailListViewState extends State<ReservationAvailListView> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Container(
              height: height * 0.035,
              width: width * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black,
              ),
              child: Center(
                child: Text(
                  "${widget.month}월 ${widget.day}일",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                String time = widget.reservedAvailList[index];
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Text(time.toString(),
                    style: const TextStyle(
                        fontSize: 16,
                    ),),
                  ),
                );
              },
              itemCount: widget.reservedAvailList.length,
            ),
          ),
        ],
      ),
    );
  }
}
