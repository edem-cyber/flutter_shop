import 'package:flutter/material.dart';
import 'package:shop_app/widgets/custom_app_drawer.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterStore'),
      ),
      drawer: CustomDrawer(12101998),
      body: Center(
        child: Text('Welcome Admin'),
      ),
    );
  }
}
