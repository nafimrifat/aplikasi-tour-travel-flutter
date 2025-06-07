import 'package:flutter/material.dart';
import 'package:tour_travel_app/helpers/user_info.dart';
import 'package:tour_travel_app/ui/login_page.dart';
import 'package:tour_travel_app/ui/travel_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserInfo().getToken();
    if (token != null) {
      setState(() {
        page = const TravelPage();
      });
    } else {
      setState(() {
        page = const LoginPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tour and Travel App',
      debugShowCheckedModeBanner: false,
      home: page,
    );
  }
}
