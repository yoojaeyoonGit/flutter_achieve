import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:m2/log_in_status.dart';
import 'package:m2/page/Auth_page.dart';
import 'package:m2/page/home_page.dart';
import 'package:m2/secure_storage.dart';
import 'package:provider/provider.dart';

import 'models/error_request_model.dart';

enum Status {
  signUp,
  signIn,
  reservation,
  notification
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: Achieve(),
    ),
  );
}

class Achieve extends StatefulWidget {
  const Achieve({super.key});

  @override
  State<Achieve> createState() => _AchieveState();
}

class _AchieveState extends State<Achieve> {
  final AuthStorage secureStorage = AuthStorage();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Consumer<UserProvider>(builder: (context, userProvider, _) {
        return Scaffold(
          body: userProvider.isLoggedIn
              ? HomePage() : AuthPage(),
              // : Column(
              //     children: [
              //       Text("Tlqkf"),
              //       TextButton(onPressed: () async {
              //         final url = Uri.parse(
              //           // "https://achieve-project.store/api/email/verification/confirm"
              //             "http://localhost:8080/api/user/sign-in");
              //         //
              //         Map data = {
              //           "email":  "jaeyoond@d.com", //_controllerEmail.text,
              //           "password": "1105" //_controllerPassword.text,
              //         };
              //         //
              //         var body = json.encode(data);
              //
              //         final response = await http.post(url,
              //             headers: {"Content-Type": "application/json"},
              //             body: body);
              //         //
              //         if (response.statusCode == 200) {
              //           // print(response.headers["refresh-token"]);
              //           final accessToken = response.headers["authorization"];
              //           final refreshToken =
              //           response.headers["refresh-token"];
              //           setState(() {
              //             if (accessToken != null && refreshToken != null) {
              //               secureStorage.saveAccessToken(accessToken);
              //               secureStorage.saveRefreshToken(refreshToken);
              //               secureStorage.readAccessToken();
              //               userProvider.loginUser();
              //             }
              //           });
              //         } else {
              //           final signUpRequestApply =
              //           jsonDecode(utf8.decode(response.bodyBytes));
              //           ErrorRequestModel message =
              //           ErrorRequestModel.fromJson(signUpRequestApply);
              //           print(message.errorMessage);
              //               if (message.errorMessage == "인증되지 않은 Email입니다.") {
              //             setState(() {
              //               // emailAuthCodeColor = Colors.red;
              //               // emailColor = Colors.red;
              //             });
              //           }
              //         }
              //       }, child: Text("님 로그인"))
              //     ],
              //   ),
        );
      }),
    );
  }
}
