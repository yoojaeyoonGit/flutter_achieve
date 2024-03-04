class ErrorRequestModel {
  final String businessCode;
  final String errorMessage;

  ErrorRequestModel.fromJson(Map<String, dynamic> json)
      : businessCode = json["businessCode"],
        errorMessage = json["errorMessage"];
}
