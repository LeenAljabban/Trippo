class PlacesNameIdModel {
  late int id;
  late String place_name;

  PlacesNameIdModel(this.place_name, this.id);
  PlacesNameIdModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    place_name = json['place_name'] as String;
  }
}
