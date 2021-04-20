import 'package:flutter/material.dart';
import 'package:shop_app/screens/loginpage.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: LoginPage(screenSize),
    );
  }
}
