import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/userProvider.dart';

class MyAccountPage extends StatelessWidget {
  static const routeName = '/my-account';
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<User>(context);
    var x = provider.findById(provider.userId);
    print(x.email);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('hello'),
      ),
    );
  }
}
