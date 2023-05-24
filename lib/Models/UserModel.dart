import 'package:flutter/cupertino.dart';

import 'ReservationModel.dart';

class UserModel {
  late int id;
  late String FirstName;
  late String LastName;
  late String Gender;
  late String Email;
  late String PhoneNumber;
  late String photo;

  UserModel(
    this.FirstName,
    this.LastName,
    this.Gender,
    this.Email,
    this.PhoneNumber,
  );
  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    FirstName = json['first_name'];
    LastName = json['last_name'];
    Gender = json['gender'];
    Email = json['email'];
    PhoneNumber = json['phone'];
    photo = json['photo'];
  }
}
