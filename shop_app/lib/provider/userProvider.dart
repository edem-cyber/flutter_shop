import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/user.dart' as user;

class User with ChangeNotifier {
  String _token = '';
  String _userId = '';
  int _role = 1;
  List<user.User> users = [];

  User(this._token, this._userId, this._role);

  String get userId {
    return _userId;
  }

  String get token {
    return _token;
  }

  int get role {
    return _role;
  }

  Future getUsers() async {
    final Uri url = Uri.http("fluttershop-backend.herokuapp.com", 'user');
    var response =
        await http.get(url, headers: {"Authorization": "Bearer $_token"});
    var responseData = json.decode(response.body);
    var data = responseData['users'] as List<dynamic>;

    List<user.User> temp = [];
    data.forEach(
      (element) {
        temp.add(
          new user.User(
              email: element['email'],
              firstname: element['firstname'],
              lastname: element['lastname'],
              role: element['role'],
              id: element['_id'],
              phoneNo: element['phone'],
              address: element['address']),
        );
      },
    );
    users = temp;
    return users;
  }

  user.User findById(String id) {
    return users.firstWhere((element) => element.id == id);
  }
}
