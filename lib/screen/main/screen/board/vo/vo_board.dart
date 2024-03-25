class Board {
  final int id, viewCount, commentCount;
  final String title, context, createdAt;

  Board.fromJson(Map<String, dynamic> json)
      : id = json["boardId"],
        viewCount = json["viewCount"],
        title = json["title"],
        context = json["context"],
        commentCount = json["commentCount"],
        createdAt = json["createdAt"];
}

List<Board> receivedBoardModels(Map<String, dynamic> json) {
  final List<dynamic> values = json['values'];
  return values.map((value) => Board.fromJson(value)).toList();
}
