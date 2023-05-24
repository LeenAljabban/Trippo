import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:trippo/Models/PivotModel.dart';

class PlaceModel {
  late int country_id;
  late int place_id;
  late String place_name;
  late String time_open;
  late String time_close;
  late String fees;
  late String location;
  late double langtiude;
  late double latitude;
  late int rate;
  late String photo;
  late File userfile;
  late int place_price;
  late PivotModel pivot;

  PlaceModel(this.place_name, this.time_open, this.time_close, this.fees,
      this.location, this.rate, this.userfile, this.place_price);
  PlaceModel.fromJson(Map<String, dynamic> json) {
    place_id = json['id'];
    country_id = json['country_id'];
    place_name = json['place_name'];
    time_open = json['time_open'];
    time_close = json['time_close'];
    fees = json['fees'];
    location = json['location'];
    langtiude = json['langtiude'];
    latitude = json['latitude'];
    rate = json['rate'];
    photo = json['photo'];
    place_price = json['place_price'];
    if (json['pivot'] != null) {
      pivot = PivotModel.fromJson(json['pivot']);
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['place_name'] = place_name;
    data['time_open'] = time_open;
    data['time_close'] = time_close;
    data['fees'] = fees;
    data['location'] = location;
    data['photo'] = photo;
    data['place_price'] = place_price;
    return data;
  }
}
