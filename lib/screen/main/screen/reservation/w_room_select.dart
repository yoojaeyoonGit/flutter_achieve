import 'package:flutter/material.dart';
import 'package:m2/screen/main/screen/reservation/f_room_detail.dart';
import 'package:m2/screen/main/screen/reservation/vo/vo_room.dart';
import 'package:nav/nav.dart';
import 'package:velocity_x/velocity_x.dart';

class RoomSelectWidget extends StatelessWidget {
  final Room room;

  const RoomSelectWidget({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;

    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.4), // 그림자 색상 및 투명도
          spreadRadius: 8, // 그림자 전파 반경
          blurRadius: 12, // 그림자 흐림 반경
          offset: const Offset(0, 8), // 그림자 위치
        )
      ]),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RoomDetail(room: room),
                fullscreenDialog: true,
              ));
          },
        child: Column(
          children: [
            Hero(
              tag: room.id,
              child: Material(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  height: height * 0.25,
                  // width: width / 1,
                  child: Padding(
                    padding: const EdgeInsets.all(1.3),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        room.name.text.bold.size(20).make(),
                        const Divider(
                          color: Colors.black,
                          thickness: 1,
                          height: 20,
                          indent: 10,
                          endIndent: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Text(room.description).pSymmetric(h: 10),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
