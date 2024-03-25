import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, size: 23,),
        color: Colors.white,
        onPressed: () {
          Navigator.of(context).pop();
        },

      ),
      backgroundColor: Colors.black,
      title: title.text.size(23).white.make(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}