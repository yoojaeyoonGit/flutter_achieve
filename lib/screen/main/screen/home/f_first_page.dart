
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../log_in_status.dart';
import '../../../../secure_storage.dart';
import '../auth/f_auth.dart';
import 'f_home_page.dart';

class FirstPageFragment extends StatefulWidget {
  const FirstPageFragment({super.key});

  @override
  State<FirstPageFragment> createState() => _FirstPageFragmentState();
}

class _FirstPageFragmentState extends State<FirstPageFragment> {
  final AuthStorage secureStorage = AuthStorage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Consumer<UserProvider>(builder: (context, userProvider, _) {
        return Scaffold(
          body: userProvider.isLoggedIn
              ? const HomePage() : const AuthPage(),
        );
      }),
    );
  }
}
