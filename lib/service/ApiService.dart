import 'dart:convert';

import 'package:m2/models/Reserved_time_model.dart';
import 'package:m2/models/room_model.dart';
import 'package:http/http.dart' as http;
import 'package:m2/secure_storage.dart';

class ApiService {
  static const String baseUrl = "http://localhost:8080";

  static Future<List<RoomModel>> getRooms() async {
    final AuthStorage authStorage = AuthStorage();

    List<RoomModel> roomInstances = [];
    // final Url = Uri.parse("http://localhost:8080/api/meetingRooms");
    final url = Uri.parse("http://localhost:8080/api/meetingRooms");
    String? accessToken = await authStorage.readAccessToken();

    final response = await http.get(url, headers: {
      "Authorization": '$accessToken'
    });

    if (response.statusCode == 200) {
      final List<dynamic> rooms = jsonDecode(utf8.decode(response.bodyBytes));

      for (var room in rooms) {
        roomInstances.add(RoomModel.fromJson(room));
      }

      return roomInstances;
    }
    throw Error();
  }


  static void makeReservation(int id, DateTime startTime, DateTime endTime) async {
    final AuthStorage authStorage = AuthStorage();

    // final Url = Uri.parse("http://localhost:8080/api/meetingRooms");
    final url = Uri.parse("http://localhost:8080/api/reservation");
    String? accessToken = await authStorage.readAccessToken();
    String startTimeModified = startTime.toString().replaceFirst(" ", "T");
    String endTimeModified = endTime.toString().replaceFirst(" ", "T");

    Map data = {
      "meetingRoomId" : id,
      "members" : 2,
      "reservationStartTime": startTimeModified,
      "reservationEndTime": endTimeModified
  };

    var body = json.encode(data);

    final response = await http.post(url,
        headers: {
        "Authorization": '$accessToken',
        "Content-Type": "application/json"
        },
        body: body);

    if (response.statusCode == 201) {
      print("reservation finished");
    } else {
      throw Error();
    }
  }

  static Future<List<ReservedTimeModel>> getReservedTimes(int id) async {
    final AuthStorage authStorage = AuthStorage();

    List<ReservedTimeModel> reservedList = [];
    // final Url = Uri.parse("http://localhost:8080/api/meetingRooms");
    print("허허 $id");
    final url = Uri.parse("http://localhost:8080/api/reservation/$id/avail");
    String? accessToken = await authStorage.readAccessToken();

    final response = await http.get(url, headers: {
      "Authorization": '$accessToken'
    });

    if (response.statusCode == 200) {
      final List<dynamic> reservedTimes = jsonDecode(utf8.decode(response.bodyBytes));

      for (var time in reservedTimes) {
        // print(ReservedTimeModel.fromJson(time).reservationStartTime);
        reservedList.add(ReservedTimeModel.fromJson(time));
      }

      return reservedList;
    }
    throw Error();
  }

}