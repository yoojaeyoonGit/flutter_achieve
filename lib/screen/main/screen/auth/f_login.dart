import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:m2/log_in_status.dart';
import 'package:m2/secure_storage.dart';
import 'package:m2/service/ApiService.dart';

import '../../../../common/widget/w_appbar.dart';
import '../../../../models/error_request_model.dart';
import '../home/f_home_page.dart';


class LoginFragment extends StatefulWidget {
  const LoginFragment({super.key});

  @override
  State<LoginFragment> createState() => _LoginFragmentState();
}

class _LoginFragmentState extends State<LoginFragment> {
  final AuthStorage secureStorage = AuthStorage();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final UserProvider userProvider = UserProvider();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const CustomAppBar("로그인"),
      body: Padding(
        padding: EdgeInsets.only(top: height * 0.25),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  signUpTextField(width, height, _controllerEmail, "email"),
                  signUpTextField(
                      width, height, _controllerPassword, "password"),
                ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: height * 0.03),
              child: Container(
                  height: height * 0.055,
                  width: width * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black,
                  ),
                  child: TextButton(
                      onPressed: () async {
                        final url = Uri.parse("${ApiService.baseUrl}/api/user/sign-in");

                        Map data = {
                          "email": _controllerEmail.text,
                          "password": _controllerPassword.text,
                        };
                        var body = json.encode(data);

                        final response = await http.post(url,
                            headers: {"Content-Type": "application/json"},
                            body: body);
                        if (response.statusCode == 200) {
                          final accessToken = response.headers["authorization"];
                          final refreshToken =
                              response.headers["refresh-token"];
                          setState(() {
                            if (accessToken != null && refreshToken != null) {
                              secureStorage.saveAccessToken(accessToken);
                              secureStorage.saveRefreshToken(refreshToken);
                              userProvider.loginUser();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                                      (route) => false
                              );
                            }
                          });
                        } else {
                          final signUpRequestApply =
                              jsonDecode(utf8.decode(response.bodyBytes));
                          ErrorRequestModel message =
                              ErrorRequestModel.fromJson(signUpRequestApply);
                          if (message.errorMessage == "인증되지 않은 Email입니다.") {
                            setState(() {
                              // emailAuthCodeColor = Colors.red;
                              // emailColor = Colors.red;
                            });
                          }
                        }
                      },
                      child: const Text(
                        "로그인",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w900),
                      ))),
            ),
          ],
        ),
      ),
    );
  }

  Row signUpTextField(double width, double height,
      TextEditingController _controller, String hint) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: width * 0.6,
            height: height * 0.075,
            child: TextField(
              cursorColor: Colors.black,
              style: const TextStyle(fontSize: 16),
              controller: _controller,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: Colors.black),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black, // 원하는 색상으로 변경
                  ),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
