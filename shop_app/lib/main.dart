//@dart=2.9

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/authProvider.dart';
import 'package:shop_app/provider/productProvider.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

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
            textTheme: TextTheme(
              headline6: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, color: Colors.white),
              bodyText1: GoogleFonts.raleway(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              subtitle2: GoogleFonts.notoSans(fontSize: 16),
            ),
          ),
          home: MainScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          },
        ),
      ),
    );
  }
}
