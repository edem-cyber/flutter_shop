import 'dart:convert';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/HttpException.dart';

class AuthProvider with ChangeNotifier {
  String _token = '';
  DateTime _expiryDate = DateTime.now();
  String _userId = '';
  // late Timer _authTimer;
  int _role = 1;

  bool get isAuth {
    return token != '';
  }

  String get token {
    if (_expiryDate != DateTime.now() &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != '') {
      return _token;
    }
    return '';
  }

  String get userId {
    return _userId;
  }

  int get role {
    return _role;
  }

  Future<void> authenticate(String urlpath, Object data) async {
    final Uri url =
        Uri.http("fluttershop-backend.herokuapp.com", 'user/$urlpath');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: data,
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']);
      }
      _token = responseData['token'];
      _userId = responseData['userId'];
      _role = responseData['role'];
      _expiryDate = DateTime.now().add(
        Duration(
          hours: responseData['expiresIn'],
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password, String fname, String lname,
      int role) async {
    final data = json.encode(
      {
        'email': email,
        'password': password,
        'firstname': fname,
        'lastname': lname,
        'role': role,
      },
    );

    return authenticate('signup', data);
  }

  Future<void> login(String email, String password) async {
    final data = json.encode({'email': email, 'password': password});
    return authenticate('login', data);
  }
}
