import 'dart:io';

import 'package:trippo/Models/UserModel.dart';
import 'package:trippo/Models/placeModel.dart';

class TripModel {
  late int id;
  late String trip_name;
  late String trip_start;
  late String trip_end;
  late int duration;
  late String trip_plane;
  late String trip_status;
  late int total_trip_price;
  late int price_after_discount;
  late int available_num_passenger;
  late String note;
  late String photo;
  late List<PlaceModel> places;
  late File userfile;
  late var dicounts;

  TripModel(
    this.trip_name,
    this.trip_start,
    this.trip_end,
    this.duration,
    this.trip_plane,
    this.trip_status,
    this.total_trip_price,
    this.price_after_discount,
    this.available_num_passenger,
    this.note,
    this.userfile,
    this.dicounts,

    //this.places
  );

  TripModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trip_name = json['trip_name'];
    trip_start = json[' trip_start'];
    trip_end = json['trip_end'];
    if (json['duration'] != null) duration = json['duration'];
    trip_plane = json['trip_plane'];
    trip_status = json['trip_status'];
    total_trip_price = json['total_trip_price'];
    if (json['price_after_discount'] != null)
      price_after_discount = json['price_after_discount'];
    if (json['available_num_passenger'] != null)
      available_num_passenger = json['available_num_passenger'];
    note = json['note'];
    photo = json['photo'];
    dicounts = json['discounts'];
    if (json['places'] != null) {
      places = <PlaceModel>[];
      (json['places'] as List).forEach((element) {
        places.add(PlaceModel.fromJson(element));
        ////!
      });
    }
  }
  Map<String, dynamic> toJson(trip_start, trip_end) {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['trip_start'] = trip_start;
    data['trip_end'] = trip_end;

    return data;
  }
}
