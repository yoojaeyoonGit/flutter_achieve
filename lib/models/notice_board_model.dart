class BoardModel {
  final int id, viewCount, commentCount;
  final String title, context, createdAt;

  BoardModel.fromJson(Map<String, dynamic> json)
      : id = json["boardId"],
        viewCount = json["viewCount"],
        title = json["title"],
        context = json["context"],
        commentCount = json["commentCount"],
        createdAt = json["createdAt"];
}

List<BoardModel> parseBoardModelList(Map<String, dynamic> json) {
  final List<dynamic> values = json['values'];
  return values.map((value) => BoardModel.fromJson(value)).toList();
}
