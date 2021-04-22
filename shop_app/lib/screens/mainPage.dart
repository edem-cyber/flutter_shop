import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/authProvider.dart';
import 'package:shop_app/screens/homepage.dart';
import 'package:shop_app/screens/loginpage.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<AuthProvider>(
          builder: (context, auth, _) =>
              // !auth.isAuth ? LoginPage(screenSize) : HomePage(),
              HomePage()),
    );
  }
}
