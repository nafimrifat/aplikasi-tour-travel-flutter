class Login {
  int? code;
  bool? status;
  String? auth_key;
  String? userID;
  String? userEmail;

  Login({this.code, this.status, this.auth_key, this.userID, this.userEmail});

  factory Login.fromJson(Map<String, dynamic> obj) {
    return Login(
        code: obj['code'],
        status: obj['status'],
        auth_key: obj['data']['auth_key'],
        userID: obj['data']['user']['id'],
        userEmail: obj['data']['user']['email']);
  }
}
