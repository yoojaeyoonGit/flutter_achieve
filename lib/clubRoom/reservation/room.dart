import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m2/clubRoom/reservation/room_detail.dart';

class Room extends StatefulWidget {
  final String roomName;
  final String description;

  const Room({super.key, required this.roomName, required this.description});

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
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

    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>
                RoomDetail(roomName: widget.roomName)
            ));
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10.0),
            ),
            height: height / 4.5,
            // width: width / 1,
            child: Padding(
              padding: const EdgeInsets.all(1.3),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(widget.roomName,
                      style:
                      const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600)),
                  const Divider(
                    color: Colors.black,
                    // 선의 색상 설정
                    thickness: 1,
                    height: 20,
                    indent: 10,
                    endIndent: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.description),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
