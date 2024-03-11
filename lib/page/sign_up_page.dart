import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:m2/models/error_request_model.dart';
import 'package:m2/page/login_page.dart';

import '../models/email_request_model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUpPage> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerAuthCode = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  String selectedAffiliation = 'Techeer';
  bool isVisible = false;
  String emailData = "not yet";
  Color emailAuthCodeColor = Colors.black;
  Color emailColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final List<String> dropdownItems = ['Techeer', 'Techeer Partners'];
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        toolbarHeight: 80,
        title: const Text(
          "회원가입",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: height * 0.12, bottom: height * 0.03),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1, color: Colors.black), // 아래쪽 border
                          ),
                        ),
                        width: width * 0.6,
                        height: height * 0.05,
                        child: Center(
                          child: DropdownButton(
                            underline: Container(),
                            value: selectedAffiliation,
                            items: dropdownItems
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ))
                                .toList(),
                            onChanged: (String? e) {
                              setState(() {
                                selectedAffiliation = e!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    signUpTextField(width, height, _controllerName, "이름"),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width * 0.45,
                            height: height * 0.075,
                            child: TextFormField(
                              style: const TextStyle(fontSize: 16),
                              controller: _controllerEmail,
                              decoration: InputDecoration(
                                  hintText: "이메일",
                                  hintStyle: TextStyle(color: emailColor),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: emailColor,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: emailColor,
                                    ),
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          Container(
                              width: width * 0.13,
                              height: height * 0.05,
                              decoration: BoxDecoration(
                                color: emailColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  sendEmailRequest(_controllerEmail.text);
                                },
                                child: authText(emailData),
                              )),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: isVisible,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: width * 0.45,
                              height: height * 0.075,
                              child: TextField(
                                style: const TextStyle(fontSize: 16),
                                controller: _controllerAuthCode,
                                decoration: InputDecoration(
                                  hintText: "인증 번호",
                                  hintStyle:
                                      const TextStyle(color: Colors.black),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: emailAuthCodeColor,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: emailAuthCodeColor, // 다른 색상으로 변경
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Container(
                                width: width * 0.13,
                                height: height * 0.05,
                                decoration: BoxDecoration(
                                  color: emailAuthCodeColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                    onPressed: () async {
                                      final url = Uri.parse(
                                          // "https://achieve-project.store/api/email/verification/confirm"
                                          "http://localhost:8080/api/email/verification/confirm");
                                          // "http://169.254.158.201:8080/api/email/verification/confirm");
                                      Map data = {
                                        "code": _controllerAuthCode.text,
                                        "email": _controllerEmail.text
                                      };

                                      var body = json.encode(data);

                                      final response = await http.post(url,
                                          headers: {
                                            "Content-Type": "application/json"
                                          },
                                          body: body);

                                      if (response.statusCode == 200) {
                                        final dynamic emailRequestApply =
                                            jsonDecode(utf8
                                                .decode(response.bodyBytes));
                                        EmailRequestModel message =
                                            EmailRequestModel.fromJson(
                                                emailRequestApply);

                                        setState(() {
                                          emailAuthCodeColor = Colors.black;
                                          emailColor = Colors.black;
                                          emailData = "not yet";
                                          isVisible = true;
                                        });
                                      } else {
                                        final dynamic emailErrorRequest =
                                            jsonDecode(utf8
                                                .decode(response.bodyBytes));
                                        ErrorRequestModel message =
                                            ErrorRequestModel.fromJson(
                                                emailErrorRequest);
                                        if (message.errorMessage ==
                                            "이미 인증된 이메일입니다.") {
                                          setState(() {
                                            emailAuthCodeColor = Colors.black;
                                          });
                                        } else {
                                          setState(() {
                                            emailAuthCodeColor = Colors.red;
                                          });
                                        }
                                      }
                                    },
                                    child: const Text(
                                      "전송",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),
                                    ))),
                          ],
                        ),
                      ),
                    ),
                    signUpTextField(width, height, _controllerPassword, "비밀번호"),
                  ],
                ),
              ),
            ),
            Container(
                height: height * 0.055,
                width: width * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black,
                ),
                child: TextButton(
                    onPressed: () async {
                      final url = Uri.parse(
                          // "https://achieve-project.store/api/email/verification/confirm"
                          "http://localhost:8080/api/user/sign-up");
                          // "http://169.254.158.201:8080/api/user/sign-up");

                      Map data = {
                        "name": _controllerName.text,
                        "email": _controllerEmail.text,
                        "password": _controllerPassword.text,
                        "affiliation": selectedAffiliation
                      };

                      var body = json.encode(data);

                      final response = await http.post(url,
                          headers: {"Content-Type": "application/json"},
                          body: body);

                      if (response.statusCode == 201) {
                        setState(() {
                          emailAuthCodeColor = Colors.black;
                          emailColor = Colors.black;
                          isVisible = true;
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        });
                      } else {
                        final signUpRequestApply =
                            jsonDecode(utf8.decode(response.bodyBytes));
                        ErrorRequestModel message =
                            ErrorRequestModel.fromJson(signUpRequestApply);
                        if (message.errorMessage == "인증되지 않은 Email입니다.") {
                          setState(() {
                            emailAuthCodeColor = Colors.red;
                            emailColor = Colors.red;
                          });
                        }
                      }
                    },
                    child: const Text(
                      "가입",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w900),
                    )))
          ],
        ),
      ),
    );
  }

  Padding signUpTextField(double width, double height,
      TextEditingController _controller, String label) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: width * 0.6,
        height: height * 0.075,
        child: TextField(
          style: const TextStyle(fontSize: 16),
          controller: _controller,
          decoration: InputDecoration(
            hintText: label,
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
    );
  }

  void sendEmailRequest(String email) async {
    if (email.isEmpty) {
      setState(() {
        emailColor = Colors.red;
      });
    } else {
      final url =
          Uri.parse("http://localhost:8080/api/email/verification/request");
      // Uri.parse("https://achieve-project.store/api/email/verification/request");
      Map data = {"email": email};

      var body = json.encode(data);

      final response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: body);

      if (response.statusCode == 200) {
        final dynamic emailRequestApply = jsonDecode(response.body);
        EmailRequestModel message =
            EmailRequestModel.fromJson(emailRequestApply);

        setState(() {
          emailData = "responsed";
          isVisible = true;
        });
      } else {
        setState(() {
          // emailColor = Colors.red;
        });
        // print("요청 실패");
      }
    }
  }

  void sendAuthCode(String code, String email, Color emailAuthColor) async {
    final url = Uri.parse(
        // "https://achieve-project.store/api/email/verification/confirm"
        "http://localhost:8080/api/email/verification/confirm");
        // "http://169.254.158.201:8080/api/email/verification/confirm");

    Map data = {"code": code, "email": email};

    var body = json.encode(data);

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 200) {
      final dynamic emailRequestApply = jsonDecode(response.body);
      EmailRequestModel message = EmailRequestModel.fromJson(emailRequestApply);

      setState(() {
        emailAuthColor = Colors.black;
        emailData = "not yet";
        isVisible = true;
      });
    } else {
      setState(() {
        emailAuthColor = Colors.red;
      });
    }
  }

  void sendSignUpRequest(
      String name, String email, String password, String affiliation) async {
    final url = Uri.parse(
        // "https://achieve-project.store/api/email/verification/confirm"
        "http://localhost:8080/api/user/sign-up");
        // "http://169.254.158.201:8080/api/user/sign-up");

    Map data = {
      "name": name,
      "email": email,
      "password": password,
      "affiliation": affiliation
    };

    var body = json.encode(data);

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    final dynamic signUpRequestApply = jsonDecode(response.body);
    ErrorRequestModel message = ErrorRequestModel.fromJson(signUpRequestApply);
    if (response.statusCode == 201) {
      setState(() {
        isVisible = true;
      });
    } else {
      if (message.errorMessage == "인증되지 않은 Email입니다.") {}
    }
  }

  Widget authText(String emailData) {
    if (emailData == 'not yet') {
      return const Text(
        "인증",
        style: TextStyle(
            fontSize: 13, color: Colors.white, fontWeight: FontWeight.w900),
      );
    } else {
      return const CircularProgressIndicator(
        strokeWidth: 2,
        color: Colors.white,
      );
    }
  }
}
