class ReservedTimeModel {
  final String reservationStartTime, reservationEndTime;

  ReservedTimeModel.fromJson(Map<String, dynamic> json)
    : reservationStartTime = json["reservationStartTime"],
        reservationEndTime = json["reservationEndTime"];
}