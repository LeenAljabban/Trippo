class MapModel {
  late String county_name;
  late double langtiude;
  late double latitude;

  MapModel(this.county_name, this.langtiude, this.latitude);
  MapModel.fromJson(Map<String, dynamic> json) {
    county_name = json['county name'];
    langtiude = json['langtiude'];
    latitude = json['latitude'];
  }
}
