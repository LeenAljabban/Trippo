class CountryNameIdModel {
  late String county_name;
  late int countryId;

  CountryNameIdModel(this.county_name, this.countryId);
  CountryNameIdModel.fromJson(Map<String, dynamic> json) {
    county_name = json['county name'] as String;
    countryId = json['country_id'] as int;
  }
}
