class Comment {
  final int commentId, sequenceNumber;
  final String context, createdAt;

  Comment.fromJson(Map<String, dynamic> json)
      : commentId = json["id"],
        sequenceNumber = json["sequenceNumber"],
        context = json["context"],
        createdAt = json["createdAt"];
}

List<Comment> receivedComment(Map<String, dynamic> json) {
  final List<dynamic> values = json['values'];
  return values.map((value) => Comment.fromJson(value)).toList();
}
