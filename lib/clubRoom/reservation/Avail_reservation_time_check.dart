import 'package:flutter/material.dart';

class AvailReservationTime extends StatefulWidget {
  const AvailReservationTime({super.key});

  @override
  State<AvailReservationTime> createState() => _AvailReservationTimeState();
}

class _AvailReservationTimeState extends State<AvailReservationTime> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List<Padding> reservationAvailList = List.generate(
        40,
        (index) => const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("2023년 11월 12일"),
            ));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Container(
                      height: height / 2,
                      width: 100,
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Center(child: reservationAvailList[index]);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                width: 20,
                              ),
                          itemCount: reservationAvailList.length),
                    ),
                    insetPadding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("확인"))
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
                width: width * 0.7,
                height: 40,
                child: const Center(
                    child: Text(
                  "예약 가능한 시간 확인",
                  style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.w700
                  ),
                ))))
      ],
    );
  }
}
