class ApiUrl {
  static const String baseUrl = 'http://localhost:8080';

  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String logout = baseUrl + '/logout';
  static const String listTravel = baseUrl + '/travel';
  static const String createTravel = baseUrl + '/travel';

  static String updateTravel(String id) {
    return baseUrl + '/travel/' + id;
  }

  static String showTravel(String id) {
    return baseUrl + '/travel/' + id.toString();
  }

  static String deleteTravel(String id) {
    return baseUrl + '/travel/' + id.toString();
  }
}
