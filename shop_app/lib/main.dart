import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/authProvider.dart';
import 'package:shop_app/provider/productProvider.dart';

import './screens/mainPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ProductProvider>(
          create: (context) => ProductProvider('', '', []),
          update: (context, auth, previous) => ProductProvider(auth.token,
              auth.userId, previous == null ? [] : previous.products),
        )
      ],
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild?.unfocus();
          }
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SoulShop',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MainScreen(),
        ),
      ),
    );
  }
}
