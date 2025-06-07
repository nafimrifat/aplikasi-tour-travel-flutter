import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tour_travel_app/helpers/user_info.dart';
import 'app_exception.dart';

class Api {
  Future<dynamic> post(String url, dynamic data) async {
    var token = await UserInfo().getToken();
    var responseJson;
    try {
      print('POST request to $url with data: $data'); // Logging request
      final response = await http.post(Uri.parse(url),
          body: data,
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No Internet connection');
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> get(String url) async {
    var token = await UserInfo().getToken();
    var responseJson;
    try {
      print('GET request to $url'); // Logging request
      final response = await http.get(Uri.parse(url),
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No Internet connection');
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    var token = await UserInfo().getToken();
    var responseJson;
    try {
      print('DELETE request to $url'); // Logging request
      final response = await http.delete(Uri.parse(url),
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No Internet connection');
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic data) async {
    var token = await UserInfo().getToken();
    var responseJson;
    try {
      print('PUT request to $url with data: $data'); // Logging request
      final response = await http.put(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
          "Content-Type": "application/json"
        },
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No Internet connection');
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 422:
        throw InvalidInputException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode :${response.statusCode}');
    }
  }
}
