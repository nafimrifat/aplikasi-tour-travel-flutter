import 'dart:convert';

import 'package:tour_travel_app/helpers/api_url.dart';
import 'package:tour_travel_app/model/login.dart';
import 'package:tour_travel_app/helpers/api.dart';

class LoginBloc {
  static Future<Login> login({String? email, String? password}) async {
    String apiUrl = ApiUrl.login;
    var body = {"email": email, "password": password};
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return Login.fromJson(jsonObj);
  }
}
