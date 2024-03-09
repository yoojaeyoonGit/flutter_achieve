import 'dart:convert';

import 'package:m2/models/room_model.dart';
import 'package:http/http.dart' as http;
import 'package:m2/secure_storage.dart';

class ApiService {
  static const String baseUrl = "http://localhost:8080";

  static Future<List<RoomModel>> getRooms() async {
    final AuthStorage authStorage = AuthStorage();

    List<RoomModel> roomInstances = [];
    final Url = Uri.parse("http://localhost:8080/api/meetingRooms");
    String? accessToken = await authStorage.readAccessToken();

    final response = await http.get(Url, headers: {
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
}
