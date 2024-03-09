import 'dart:ffi';

class RoomModel {
  final int id;
  final String roomName, description;

  RoomModel.fromJson(Map<String, dynamic> json)
      :
        id = json["id"],
        roomName = json["name"],
        description = json["description"];
}