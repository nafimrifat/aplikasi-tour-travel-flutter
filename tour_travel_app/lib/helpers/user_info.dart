import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserInfo {
  Future setToken(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString("auth_key", value);
  }

  Future<String?> getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getString("auth_key");
  }

  Future setUserID(int value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setInt("userID", value);
  }

  Future<int?> getUserID() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt("userID");
  }

  Future<void> logout() async {
    // Hapus token dari penyimpanan lokal
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();

    // Kirim permintaan ke endpoint logout di server
    final url = Uri.parse(
        'http://localhost:8080/logout'); // Ganti dengan URL endpoint logout Anda
    final token =
        await getToken(); // Anda mungkin perlu mendapatkan token dari penyimpanan lokal
    print(token);
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    // Cek status response, sesuaikan dengan kebutuhan Anda
    if (response.statusCode == 200) {
      print('Logout berhasil');
    } else {
      print('Logout gagal: ${response.statusCode}');
      throw Exception('Logout gagal');
    }
  }
}
