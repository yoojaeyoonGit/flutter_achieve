import 'package:flutter/material.dart';
import 'package:m2/clubRoom/reservation/room.dart';
import 'package:m2/models/room_model.dart';
import 'package:m2/service/ApiService.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final Future<List<RoomModel>> rooms = ApiService.getRooms();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;
    double height = MediaQuery.of(context).size.height / 2;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        toolbarHeight: 60,
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
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4), // 그림자 색상 및 투명도
                spreadRadius: 8, // 그림자 전파 반경
                blurRadius: 12, // 그림자 흐림 반경
                offset: const Offset(0, 8), // 그림자 위치
              )
            ]
          ),
            child: Room(roomName: room.roomName, description: room.description, id: room.id));
      },
      separatorBuilder: (context, index) => SizedBox(
        height: height * 0.07,
      ),
    );
  }
}
