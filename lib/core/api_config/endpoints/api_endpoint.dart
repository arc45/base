import 'package:base_project/core/flavor_config/flavor_config.dart';

class ApiEndPoint {
  static String get baseUrl => FlavorConfig.instance.env.baseUrl;

  static String get refreshToken => "$baseUrl/api/auth/refresh";
}
