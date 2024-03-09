import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage {
  final storage = new FlutterSecureStorage();

  Future<void> saveAccessToken(String accessToken) async {
    try {
      await storage.write(key: "ACCESS_TOKEN", value: accessToken);
    } catch (e) {
      print("ACCESS_TOKEN 저장 실패");
    }
  }

  Future<String?> readAccessToken() async {
      return await storage.read(key: "ACCESS_TOKEN");
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    try {
      await storage.write(key: "REFRESH_TOKEN", value: refreshToken);
    } catch (e) {
      print("REFRESH_TOKEN 저장 실패");
    }
  }

  Future<void> readRefreshToken() async {
    try {
      final refreshToken = await storage.read(key: "REFRESH_TOKEN");
      print("refreshToken: $refreshToken ");
    } catch (e) {
      print("REFRESH_TOKEN 읽기 실패");
    }
  }
}
