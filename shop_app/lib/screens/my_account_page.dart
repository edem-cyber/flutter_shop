import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/provider/userProvider.dart';

class MyAccountPage extends StatefulWidget {
  static const routeName = '/my-account';

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  var isLoading = false;

  @override
  void initState() {
    var provider = Provider.of<User>(context, listen: false);
    if (provider.currUser['email'] == '') {
      setState(() {
        isLoading = true;
      });
      provider.getMyDetail().then((value) {
        setState(() {
          isLoading = false;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var details = Provider.of<User>(context).currUser;
    print(details);
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Text('hello'),
            ),
    );
  }
}
