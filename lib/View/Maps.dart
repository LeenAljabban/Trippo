import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:permission_handler/permission_handler.dart';

import '../API/api.dart';

class Maps extends StatefulWidget {
  final double langtiude;
  final double latitude;
  const Maps({Key? key, required this.langtiude, required this.latitude})
      : super(key: key);
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  var Mymarkers = HashSet<Marker>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.langtiude, widget.latitude),
              // zoom: 6,
            ),
            onMapCreated: (GoogleMapController googleMapController) {
              setState(() {
                Mymarkers.add(
                  Marker(
                    markerId: MarkerId('1'),
                    position: LatLng(widget.langtiude, widget.latitude),
                  ),
                );
              });
            },
            markers: Mymarkers,
          )
        ],
      ),
    );
  }
}
