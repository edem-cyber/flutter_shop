import 'dart:convert';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  Future<void> authenticate(String urlpath, Object data) async {
    final Uri url = Uri.http("192.168.0.195:3000", 'user/$urlpath');
    print(url);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: data,
    );
    print(response);
    final responseData = json.decode(response.body);
    print(responseData);
  }

  Future<void> signup(
      String email, String password, String fname, String lname) async {
    final data = json.encode(
      {
        'email': email,
        'password': password,
        'firstname': fname,
        'lastname': lname,
      },
    );

    authenticate('signup', data);
  }

  Future<void> login(String email, String password) async {
    final data = json.encode({'email': email, 'password': password});
    authenticate('login', data);
  }
}
