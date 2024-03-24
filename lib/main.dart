import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:m2/log_in_status.dart';
import 'package:m2/screen/main/screen/auth/f_auth.dart';
import 'package:m2/screen/main/screen/home/f_home_page.dart';
import 'package:m2/secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  timeago.setLocaleMessages('ko', timeago.KoMessages());
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ko')],
      fallbackLocale: const Locale('en'),
      path: 'assets/translations',
      child: const FirstPageFragment(),
    ),
  );
}

class FirstPageFragment extends StatefulWidget {
  const FirstPageFragment({super.key});

  @override
  State<FirstPageFragment> createState() => _FirstPageFragmentState();
}

class _FirstPageFragmentState extends State<FirstPageFragment> {
  final AuthStorage secureStorage = AuthStorage();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        locale: const Locale("ko"),
        home: Consumer<UserProvider>(builder: (context, userProvider, _) {
          return Scaffold(
            body: userProvider.isLoggedIn
                ? const HomePage() : const AuthPage(),
          );
        }),
      ),
    );
  }
}
