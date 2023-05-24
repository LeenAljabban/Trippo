import 'package:trippo/Models/TripModel.dart';
import 'package:trippo/Models/placeModel.dart';

class ReservationModel {
  late int id;
  late int trip_id;
  late int user_id;
  late String reservation_date;
  late int passenger_number;
  late int total_money;
  late String created_at;
  late String updated_at;
  late int reservation_price;
  late List<TripModel> trip;
  late List<PlaceModel> places_reserv;

  ReservationModel(
      this.trip_id, this.user_id, this.reservation_date, this.total_money);
  ReservationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trip_id = json['trip_id'];
    user_id = json['user_id'];
    reservation_date = json['reservation_date'] as String;
    passenger_number = json['passenger_number'];
    if (json['total_money'] != null) total_money = json['total_money'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    reservation_price = json['reservation_price'];
    if (json['trip'] != null) {
      trip = <TripModel>[];
      (json['trip'] as List).forEach((element) {
        trip.add(TripModel.fromJson(element));
        ////!
      });
    }
    if (json['places_reserv'] != null) {
      places_reserv = <PlaceModel>[];
      (json['places_reserv'] as List).forEach((element) {
        places_reserv.add(PlaceModel.fromJson(element));
        ////!
      });
    }
  }
}
