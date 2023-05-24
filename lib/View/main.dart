import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trippo/View/EditPlace.dart';
import 'package:trippo/View/MyTrips.dart';
import 'package:trippo/View/Office.dart';
import 'package:trippo/View/OfficeViewTrips.dart';
import 'package:trippo/View/Reservation.dart';
import 'package:trippo/View/UserProfile.dart';
import 'package:trippo/View/addPlace.dart';
import 'package:trippo/View/home.dart';
import 'package:trippo/View/SplashScreen.dart';
import 'package:trippo/View/login.dart';
import 'package:trippo/View/User_Register.dart';
import 'AddTrip.dart';
import 'Edit Reservation.dart';
import 'EditProfile.dart';
import 'Favourites.dart';
import 'Maps.dart';
import 'OfficeViewPlaces.dart';
import 'OffiecProfile_OfficerSide.dart';
import 'OffiecProfile_UserSide.dart';
import 'Place.dart';
import 'Trip.dart';
import 'User_Type.dart';
import 'hh.dart';
import 'officerDashboard.dart';
import 'OfficesList.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
