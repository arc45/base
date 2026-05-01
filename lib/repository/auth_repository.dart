import 'package:flutter/foundation.dart';
import 'package:base_project/core/api_config/client/api_client.dart';

class AuthRepository {
  final ApiClient apiClient;
  AuthRepository({required this.apiClient});

  // Future<RegisterModel> registerApiCall({required String email}) async {
  //   try {
  //     final Map<String, dynamic> data = {"email": email};

  //     var response = await apiClient.request(RequestType.POST, ApiEndPoint.register, data: data);
  //     return await compute(RegisterModel.fromJson, response);
  //   } catch (error) {
  //     rethrow;
  //   }
  // }
}
