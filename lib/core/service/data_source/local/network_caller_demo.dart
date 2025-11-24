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

  /// log request=============================================================================
  void _logRequest(String url, Map<String, dynamic> headers,
      {Map<String, dynamic>? requestBody}) {
    _logger.i("URL => $url\nHeaders: $headers\nBody: $requestBody");
  }


  /// log response=============================================================================
  void _logResponse(String url, Response response) {
    _logger.i(
        "URL => $url\nStatus Code: ${response.statusCode}\nHeaders: ${response.headers}\nBody: ${response.body}");
  }

  ///get request
  Future<NetworkResponse> getRequest(
      {required String url, Map<String, dynamic>? queryParams}) async {
    try {
      url += '?';
      for (String key in queryParams?.keys ?? {}) {
        url += '$key=${queryParams![key]}&';
      }
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {'token': getx.Get.find<AuthController>().token ?? ''};

      _logRequest(url, headers);
      Response response = await get(uri, headers: headers);


      _logResponse(url, response);

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedResponse,
        );
      } else if (response.statusCode == 401) {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodedResponse['message'],
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodedResponse['message'],
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  ///post request===================================


  Future<NetworkResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'content-type': 'application/json',
        'token': getx.Get.find<AuthController>().token ?? ''
      };

      _logRequest(url, headers);
      Response response =
      await post(uri, headers: headers, body: jsonEncode(body));
      _logResponse(url, response);

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodedResponse);
      } else if (response.statusCode == 401) {
        await _clearUserData();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodedResponse['msg'],
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodedResponse['msg'],
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> _clearUserData() async {
    await getx.Get.find<AuthController>().clearUserData();
  }



}