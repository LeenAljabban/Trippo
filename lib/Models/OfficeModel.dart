import 'package:flutter/cupertino.dart';

class OfficeModel {
  late String county_name;
  late String image;
  OfficeModel(this.county_name, this.image);

  OfficeModel.fromJson(Map<String, dynamic> json)
      : county_name = json['county name'] as String,
        image = json['photo'] as String;
}
