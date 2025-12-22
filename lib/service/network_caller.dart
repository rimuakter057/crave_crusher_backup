import 'dart:convert';
import 'package:crave_crusher/view/features/auth/controllers/auth_controller.dart';
import 'package:get/get.dart' as getx;

import 'package:http/http.dart';
import 'package:logger/logger.dart';

class NetworkResponse {
  final int statusCode;
  final Map<String, dynamic>? responseData;
  final bool isSuccess;
  final String errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.responseData,
    this.errorMessage = 'Something went wrong!',
  });
}

class NetworkCaller {
  final Logger _logger = Logger();

  /// Log request
  void _logRequest(String url, Map<String, dynamic> headers,
      {Map<String, dynamic>? requestBody}) {
    _logger.i("URL => $url\nHeaders: $headers\nBody: $requestBody");
  }

  /// Log response
  void _logResponse(String url, Response response) {
    _logger.i(
        "URL => $url\nStatus Code: ${response.statusCode}\nHeaders: ${response.headers}\nBody: ${response.body}");
  }

  /// ---------------- GET REQUEST ----------------
  Future<NetworkResponse> getRequest({
    required String url,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      // Build query parameters
      if (queryParams != null && queryParams.isNotEmpty) {
        url += '?';
        queryParams.forEach((key, value) {
          url += '$key=$value&';
        });
      }

      Uri uri = Uri.parse(url);

      // Ensure token is loaded
      String? token = getx.Get.find<AuthController>().token;
      if (token == null) {
        await getx.Get.find<AuthController>().getUserData();
        token = getx.Get.find<AuthController>().token;
      }

      Map<String, String> headers = {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      };

      _logRequest(url, headers);

      Response response = await get(uri, headers: headers);

      _logResponse(url, response);

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: data,
        );
      }

      if (response.statusCode == 401) {
        await _handleUnauthorized();
      }

      return NetworkResponse(
        isSuccess: false,
        statusCode: response.statusCode,
        errorMessage: data['message'] ?? "Request failed",
      );
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  /// ---------------- POST REQUEST ----------------
  Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);

      // Ensure token is loaded
      String? token = getx.Get.find<AuthController>().token;
      if (token == null) {
        await getx.Get.find<AuthController>().getUserData();
        token = getx.Get.find<AuthController>().token;
      }

      Map<String, String> headers = {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      };

      _logRequest(url, headers, requestBody: body);

      Response response =
      await post(uri, headers: headers, body: jsonEncode(body));

      _logResponse(url, response);

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: data,
        );
      }

      if (response.statusCode == 401) {
        await _handleUnauthorized();
      }



      return NetworkResponse(
        isSuccess: false,
        statusCode: response.statusCode,
        errorMessage: data['message'] ?? "Request failed",
      );
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }











  /// ---------------- Handle Unauthorized ----------------
  Future<void> _handleUnauthorized() async {
    await getx.Get.find<AuthController>().clearUserData();
    getx.Get.offAllNamed('/login'); // Replace with your login route
  }
}
