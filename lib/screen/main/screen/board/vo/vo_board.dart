import 'board_type.dart';

class Board {
  final int id, viewCount, commentCount;
  final String title, context, createdAt;
  final BoardType boardType;

  Board(this.title, this.id, this.viewCount, this.commentCount, this.context, this.createdAt, this.boardType);
}