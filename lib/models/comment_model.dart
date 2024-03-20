class CommentModel {
  final int commentId, sequenceNumber;
  final String context, createdAt;

  CommentModel.fromJson(Map<String, dynamic> json)
      : commentId = json["id"],
        sequenceNumber = json["sequenceNumber"],
        context = json["context"],
        createdAt = json["createdAt"];
}

List<CommentModel> receivedCommentModels(Map<String, dynamic> json) {
  final List<dynamic> values = json['values'];
  return values.map((value) => CommentModel.fromJson(value)).toList();
}
