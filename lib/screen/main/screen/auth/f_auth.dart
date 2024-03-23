import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m2/main.dart';
import 'package:m2/common/widget/w_bottom_nav_button.dart';
import 'f_login.dart';
import 'f_sign_up.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    double listHeight = MediaQuery.of(context).size.height;

    double fontSize;
    double iconSize;

    if (listHeight > 1100) {
      fontSize = 25;
      iconSize = 25;
    } else {
      fontSize = 15;
      iconSize = 17;
    }

    double height = MediaQuery.of(context).size.height / 12;

    double width2 = MediaQuery.of(context).size.width;

    double width = MediaQuery.of(context).size.width / 2.6;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 60,
        title: const Text(
          "Achieve",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                height: listHeight / 2,
                child: Image.network(
                    "https://author-picture.s3.ap-northeast-2.amazonaws.com/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA+2024-02-14+%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE+10.11.18.png"),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: height / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BottomNavButtonWidget(
                    height: height,
                    width: width,
                    title: "회원가입",
                    status: Status.signUp,
                    fontSize: fontSize,
                    iconSize: iconSize,
                    fragment: const SignUpFragment(),
                  ),

                  BottomNavButtonWidget(
                    height: height,
                    width: width,
                    title: "로그인",
                    status: Status.signIn,
                    fontSize: fontSize,
                    iconSize: iconSize,
                    fragment: const LoginFragment(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
