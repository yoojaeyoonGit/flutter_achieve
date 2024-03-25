import 'dart:convert';

import 'package:m2/models/Reserved_time_model.dart';
import 'package:m2/models/comment_model.dart';
import 'package:m2/models/room_model.dart';
import 'package:http/http.dart' as http;
import 'package:m2/secure_storage.dart';

import '../models/error_request_model.dart';
import '../screen/main/screen/board/vo/vo_board.dart';

class ApiService {
  static const String baseUrl = "http://localhost:8080";

  // static final AuthStorage authStorage = AuthStorage();

  static Future<List<RoomModel>> getRooms() async {
    final AuthStorage authStorage = AuthStorage();

    List<RoomModel> roomInstances = [];
    final url = Uri.parse("$baseUrl/api/meetingRooms");
    String? accessToken = await authStorage.readAccessToken();

    final response =
        await http.get(url, headers: {"Authorization": '$accessToken'});

    if (response.statusCode == 200) {
      final List<dynamic> rooms = jsonDecode(utf8.decode(response.bodyBytes));

      for (var room in rooms) {
        roomInstances.add(RoomModel.fromJson(room));
      }

      return roomInstances;
    }
    throw Error();
  }

  static void makeReservation(
      int id, DateTime startTime, DateTime endTime) async {
    final AuthStorage authStorage = AuthStorage();

    final url = Uri.parse("$baseUrl/api/reservation");
    String? accessToken = await authStorage.readAccessToken();
    String startTimeModified = startTime.toString().replaceFirst(" ", "T");
    String endTimeModified = endTime.toString().replaceFirst(" ", "T");

    Map data = {
      "meetingRoomId": id,
      "members": 2,
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
      final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
      print(
          "Business code: ${ErrorRequestModel.fromJson(jsonData).businessCode}");
      print(
          "Error message: ${ErrorRequestModel.fromJson(jsonData).errorMessage}");
      throw Error();
    }
  }

  static Future<List<ReservedTimeModel>> getReservedTimes(
      int id, String cursor) async {
    final AuthStorage authStorage = AuthStorage();

    List<ReservedTimeModel> reservedList = [];
    final url =
        Uri.parse("$baseUrl/api/reservation/avail/$id?dateTime=$cursor");
    String? accessToken = await authStorage.readAccessToken();

    final response =
        await http.get(url, headers: {"Authorization": '$accessToken'});

    if (response.statusCode == 200) {
      final List<dynamic> reservedTimes =
          jsonDecode(utf8.decode(response.bodyBytes));

      for (var time in reservedTimes) {
        reservedList.add(ReservedTimeModel.fromJson(time));
      }
      return reservedList;
    }
    throw Error();
  }

  static Future<List<Board>> getBoards(
      String category, String cursor) async {
    final AuthStorage authStorage = AuthStorage();

    final url =
        Uri.parse("$baseUrl/api/boards?category=$category&cursor=$cursor");
    String? accessToken = await authStorage.readAccessToken();

    final response =
        await http.get(url, headers: {"Authorization": '$accessToken'});

    if (response.statusCode == 200) {
      Map<String, dynamic> parsedPosts =
          jsonDecode(utf8.decode(response.bodyBytes));

      return receivedBoardModels(parsedPosts);
    } else {
      final errorJsonData = jsonDecode(utf8.decode(response.bodyBytes));
      print(
          "Business code: ${ErrorRequestModel.fromJson(errorJsonData).businessCode}");
      print(
          "Error message: ${ErrorRequestModel.fromJson(errorJsonData).errorMessage}");
    }
    throw Error();
  }

  static Future<Board> getOneBoard(int id) async {
    final AuthStorage authStorage = AuthStorage();

    final url = Uri.parse("$baseUrl/api/boards/$id");
    String? accessToken = await authStorage.readAccessToken();

    final response =
        await http.get(url, headers: {"Authorization": '$accessToken'});

    if (response.statusCode == 200) {
      Map<String, dynamic> receivedBoard =
          jsonDecode(utf8.decode(response.bodyBytes));

      return Board.fromJson(receivedBoard);
    } else {
      final errorJsonData = jsonDecode(utf8.decode(response.bodyBytes));
      print(
          "Business code: ${ErrorRequestModel.fromJson(errorJsonData).businessCode}");
      print(
          "Error message: ${ErrorRequestModel.fromJson(errorJsonData).errorMessage}");
    }
    throw Error();
  }

  static Future<List<CommentModel>> getCommentsByBoardId(
      int boardId, String cursor) async {
    final AuthStorage authStorage = AuthStorage();

    final url =
        Uri.parse("$baseUrl/api/comments/boards/$boardId?&cursor=$cursor");
    String? accessToken = await authStorage.readAccessToken();

    final response =
        await http.get(url, headers: {"Authorization": '$accessToken'});

    if (response.statusCode == 200) {
      Map<String, dynamic> receivedComments =
          jsonDecode(utf8.decode(response.bodyBytes));
      return receivedCommentModels(receivedComments);
    } else {
      final errorJsonData = jsonDecode(utf8.decode(response.bodyBytes));
      print(
          "Business code: ${ErrorRequestModel.fromJson(errorJsonData).businessCode}");
      print(
          "Error message: ${ErrorRequestModel.fromJson(errorJsonData).errorMessage}");
    }
    throw Error();
  }

  static Future<int> createComment(String content, int boardId) async {
    final AuthStorage authStorage = AuthStorage();

    final url = Uri.parse("$baseUrl/api/comments");
    String? accessToken = await authStorage.readAccessToken();

    Map data = {
      "boardId" : boardId,
      "context" : content,
    };

    var body = json.encode(data);

    final response = await http.post(url,
        headers: {
          "Authorization": '$accessToken',
          "Content-Type": "application/json"
        },
        body: body);

    if (response.statusCode == 201) {
      return 201;
    } else {
      final errorJsonData = jsonDecode(utf8.decode(response.bodyBytes));
      print(
          "Business code: ${ErrorRequestModel.fromJson(errorJsonData).businessCode}");
      print(
          "Error message: ${ErrorRequestModel.fromJson(errorJsonData).errorMessage}");
    }
    throw Error();
  }
}
