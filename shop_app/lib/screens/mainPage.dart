import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/authProvider.dart';
import 'package:shop_app/screens/homepage.dart';

import 'homepage.dart';
import 'loginpage.dart';
import 'loginpage.dart';
import 'loginpage.dart';

enum ScreenSize {
  extraLarge,
  large,
  medium,
  small,
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    ScreenSize size;
    if (screenSize.width > 1920) {
      size = ScreenSize.extraLarge;
    } else if (screenSize.width > 1200) {
      size = ScreenSize.large;
    } else if (screenSize.width > 960) {
      size = ScreenSize.medium;
    } else {
      size = ScreenSize.small;
    }
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        if (!auth.isAuth) {
          return FutureBuilder(
            future: auth.tryAutoLogin(),
            builder: (context, snapshot) => LoginPage(screenSize),
          );
        }
        return HomePage(size, screenSize, auth.role);
      },
    );
  }
}
