import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:m2/log_in_status.dart';
import 'package:m2/page/Auth_page.dart';
import 'package:m2/page/home_page.dart';
import 'package:m2/secure_storage.dart';
import 'package:provider/provider.dart';

import 'models/error_request_model.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..userAgent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36';
  }
}

enum Status {
  signUp,
  signIn,
  reservation,
  notification
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(
      //   colorScheme: ColorScheme.light(
      //     primary: Colors.black, // 헤더 배경색 및 선택된 날짜 색상 변경
      //     onPrimary: Colors.white, // 헤더 텍스트 색상 변경
      //   ),
      // ),
      home: Consumer<UserProvider>(builder: (context, userProvider, _) {
        return Scaffold(
          body: userProvider.isLoggedIn
              ? const HomePage() : const AuthPage(),
        );
      }),
    );
  }
}
