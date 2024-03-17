import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:m2/clubRoom/reservation/room_detail.dart';

class Room extends StatefulWidget {
  final int id;
  final String roomName, description;

  const Room({super.key, required this.roomName, required this.description, required this.id});

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
                RoomDetail(roomName: widget.roomName, id: widget.id),
              fullscreenDialog: true,
            ));
      },
      child: Column(
        children: [
          Hero(
            tag: widget.id,
            child: Material(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                height: height * 0.2,
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                          child: Text(widget.description),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
