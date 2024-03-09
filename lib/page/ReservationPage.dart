import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m2/clubRoom/reservation/room.dart';
import 'package:m2/models/room_model.dart';
import 'package:m2/service/ApiService.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  // final Future<List<RoomModel>> =
  // final Future<List<Room>>
  // Future<List<RoomModel>>

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final Future<List<RoomModel>> rooms = ApiService.getRooms();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;
    double height = MediaQuery.of(context).size.height / 2;
    // List<Room> rooms = [
    //   const Room(
    //       roomName: "Palo Alto",
    //       description: "실리콘밸리의 탄생지(Birthplace of Silicon Valley)로 불리는 미국"
    //           " 캘리포니아주 산타클라라 군에 속한 실리콘밸리 북부의 도시의 이름에서 따온 방입니다."),
    //   const Room(
    //       roomName: "Apple",
    //       description: "애플(영어: Apple Inc.)"
    //           "은 미국 캘리포니아의 아이폰, 아이패드, 애플 워치, 에어팟, 아이맥, 맥북, "
    //           "맥 스튜디오와 맥 프로, 홈팟, 비전 프로, 에어태그 등의 하드웨어")
    // ];

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        toolbarHeight: 80,
        title: const Text(
          "예약",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(children: [
        Image.network(
          "https://i.postimg.cc/TPRSF0MG/2023-10-15-8-26-50.png",
          height: height * 2,
          fit: BoxFit.cover,
        ),
        FutureBuilder(
            future: rooms,
            // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: roomList(width, height, snapshot),
                    )),
                  ],
                );
              }
              return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  )
              );
            }),
      ]),
    );
  }

  ListView roomList(
      double width, double height, AsyncSnapshot<List<RoomModel>> snapshot) {
    return ListView.separated(
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        var room = snapshot.data![index];
        return Room(roomName: room.roomName, description: room.description, id: room.id);
      },
      separatorBuilder: (context, index) => SizedBox(
        height: height * 0.07,
      ),
    );
  }
}
