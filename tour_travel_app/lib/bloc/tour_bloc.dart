import 'dart:convert';

import 'package:tour_travel_app/helpers/api.dart';
import 'package:tour_travel_app/helpers/api_url.dart';
import 'package:tour_travel_app/model/travel.dart';

class TourBloc {
  static Future<List<Travel>> getTours() async {
    String apiUrl = ApiUrl.listTravel;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listTravel = (jsonObj as Map<String, dynamic>)['data'];
    List<Travel> travel = [];
    for (int i = 0; i < listTravel.length; i++) {
      travel.add(Travel.fromJson(listTravel[i]));
    }
    return travel;
  }

  static Future addTour({Travel? travel}) async {
    String apiUrl = ApiUrl.createTravel;

    var body = {
      "nama": travel!.nama,
      "lokasi": travel.lokasi,
      "harga": travel.harga.toString(),
      "deskripsi": travel.deskripsi,
      "durasi": travel.durasi,
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> updateTour({required Travel travel}) async {
    String apiUrl = ApiUrl.updateTravel(travel.id!);

    var body = {
      "nama": travel.nama,
      "lokasi": travel.lokasi,
      "harga": travel.harga.toString(),
      "deskripsi": travel.deskripsi,
      "durasi": travel.durasi,
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, body);
    var jsonObj = json.decode(response.body);
    print('Response from server: $jsonObj');

    // Periksa apakah response berisi field 'status'
    if (jsonObj.containsKey('status') && jsonObj['status'] == true) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteTour({required String id}) async {
    String apiUrl = ApiUrl.deleteTravel(id);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    print('Response from server: $jsonObj');

    // Periksa apakah response berisi field 'status'
    if (jsonObj.containsKey('status') && jsonObj['status'] == true) {
      return true;
    } else {
      return false;
    }
  }
}
