import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoticeBoardDetailPage extends StatefulWidget {
  final String title, content;
  const NoticeBoardDetailPage({super.key, required this.title, required this.content});

  @override
  State<NoticeBoardDetailPage> createState() => _NoticeBoardDetailPageState();
}

class _NoticeBoardDetailPageState extends State<NoticeBoardDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        toolbarHeight: 80,
        title: const Text(
          "공지사항",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
