import 'dart:convert';

import 'package:tour_travel_app/helpers/api.dart';
import 'package:tour_travel_app/helpers/api_url.dart';
import 'package:tour_travel_app/model/registrasi.dart';

class RegistrasiBloc {
  static Future<Registrasi> registrasi(
      {String? name, String? email, String? password}) async {
    String apiUrl = ApiUrl.registrasi;

    var body = {"name": name, "email": email, "password": password};

    try {
      print('Attempting registration with data: $body'); // Logging data
      var response = await Api().post(apiUrl, body);
      var jsonObj = json.decode(response.body);
      print('Registration response: $jsonObj'); // Logging response
      return Registrasi.fromJson(jsonObj);
    } catch (error) {
      print('Registration failed: $error'); // Logging error
      rethrow;
    }
  }
}
