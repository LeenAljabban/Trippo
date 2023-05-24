class PivotModel {
  // late int trip_id;
  late int place_id;

  late int place_trip_price;

  PivotModel(
      // this.trip_id, this.place_id,
      this.place_trip_price);
  PivotModel.fromJson(Map<String, dynamic> json) {
    // trip_id = json['trip_id'];
    place_id = json['place_id'];
    if (json['place_trip_price'] != null)
      place_trip_price = json['place_trip_price'];
  }
}
