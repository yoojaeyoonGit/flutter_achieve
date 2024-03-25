import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../common/utils/time_utils.dart';
import '../../../../common/widget/w_height_and_width.dart';
import '../../../../models/comment_model.dart';

class CommentWidget extends StatelessWidget {
  final Comment comment;

  const CommentWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), border: Border.all(width: 1)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                comment.context,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            Row(
              children: [
                TimeUtils.timeFormatterForComment(context, comment.createdAt)
                    .text
                    .color(Colors.grey.shade600)
                    .make(),
                width5,
              ],
            )
          ],
        ),
      ),
    );
  }
}
