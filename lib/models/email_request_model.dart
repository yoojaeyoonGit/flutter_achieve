class EmailRequestModel {
  final String message;

  EmailRequestModel.fromJson(Map<String, dynamic> json)
      : message = json["message"];
}