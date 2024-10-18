import 'dart:io';

import 'package:get/get.dart';

import '../../services/user_services.dart';
import 'network_util.dart';

class ApiHelper extends GetConnect {
  static final ApiHelper _apiHelper = ApiHelper._internal();
  factory ApiHelper() => _apiHelper;
  ApiHelper._internal();

  @override
  bool get allowAutoSignedCert => true;

  @override
  void onInit() {
    allowAutoSignedCert = true;
    super.onInit();
  }

  Future<Map<String, dynamic>> getData(
    String url, {
    Map<String, String>? query,
  }) async {
    final authToken = Get.find<UserServices>().user?.accessToken ?? '';
    final response = await get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': authToken,
      },
      query: query,
    );

    return makeJsonResponse(response);
  }

  Future<Map<String, dynamic>> postData(String url, dynamic formData) async {
    final authToken = Get.find<UserServices>().user?.accessToken ?? '';
    // final authToken = '';
    // print('$authToken');
    final response = await post(
      url,
      formData,
      headers: {
        'Accept': 'application/json',
        'Authorization': authToken,
      },
    );

    return makeJsonResponse(response);
  }

// status.connectionError is true when statusCode is null.
// status.isUnauthorized is true when statusCode is equal 401.
// status.isNotFound is true when statusCode is equal 404.
// status.isServerError is true when statusCode is between 500 and 599.
// status.isOk is true when statusCode is between 200 and 299.
  Future<Map<String, dynamic>> makeJsonResponse(Response response) async {
    if (response.isOk) {
      return {
        'success': true,
        'statusCode': response.statusCode,
        'data': response.body,
      };
    }
    if (response.status.connectionError) {
      if (await DataConnectionChecker().hasConnection) {
        return {
          'success': false,
          'statusCode': response.statusCode,
          'error': 'Connection Error Occured. Please try again later',
        };
      }

      return {
        'success': false,
        'statusCode': response.statusCode,
        'error': 'No Internet Connection',
      };
    }

    if (response.status.isForbidden) {
      return {
        'success': false,
        'statusCode': response.statusCode,
        'error': 'You are not authorized to access this page',
      };
    }
    if (response.status.isUnauthorized) {
      return {
        'success': false,
        'statusCode': response.statusCode,
        'error': 'Please login again.',
      };
    }
    if (response.status.isNotFound) {
      return {
        'success': false,
        'statusCode': response.statusCode,
        'error': 'Resourse not found',
      };
    }

    return {
      'success': false,
      'statusCode': response.statusCode,
      'error': 'Invalid response from the server',
    };
  }
}

class CustomHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
