import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.65,
            child: Image.asset(
              'assets/images/login.jpg',
              fit: BoxFit.fitHeight,
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}
