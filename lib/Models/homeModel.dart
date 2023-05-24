import 'package:flutter/cupertino.dart';
import 'package:trippo/Models/placeModel.dart';

class homeModel {
  late int country_id;
  late String county_name;
  late String image;
  late double langtiude;
  late double latitude;
  late List<PlaceModel> places;

  homeModel(
      this.county_name, this.image, this.langtiude, this.latitude, this.places);

  homeModel.fromJson(Map<String, dynamic> json) {
    country_id = json['country_id'];
    county_name = json['county name'] as String;
    image = json['photo'] as String;
    langtiude = json['langtiude'];
    latitude = json['latitude'];
    if (json['places'] != null) {
      places = <PlaceModel>[];
      (json['places'] as List).forEach((element) {
        places.add(PlaceModel.fromJson(element));
        ////!
      });
    }
  }
}
