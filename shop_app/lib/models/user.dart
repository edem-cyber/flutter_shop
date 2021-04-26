//@dart=2.9

import 'package:flutter/foundation.dart';

class User {
  final int role;
  final String firstname;
  final String lastname;
  final String email;
  final String id;
  final String address;
  final String phoneNo;

  User({
    @required this.email,
    @required this.firstname,
    @required this.lastname,
    @required this.role,
    @required this.id,
    this.address,
    this.phoneNo,
  });
}
