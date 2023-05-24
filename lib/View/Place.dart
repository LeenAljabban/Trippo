import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trippo/Models/placeModel.dart';
// import 'package:permission_handler/permission_handler.dart';

import '../Models/homeModel.dart';

class Place extends StatefulWidget {
  final PlaceModel place;
  const Place({Key? key, required this.place}) : super(key: key);
  @override
  _PlaceState createState() => _PlaceState();
}

class _PlaceState extends State<Place> {
  var Mymarkers = HashSet<Marker>();
  Text _RatingStars(int rating) {
    String star = '';
    for (int i = 0; i < rating; i++) star += '⭐ ';
    return Text(star);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                Container(
                  height: 230,
                  width: 450,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Image(
                    image: NetworkImage(
                        'http://192.168.43.164:8000/${widget.place.photo}'),
                    fit: BoxFit.cover,
                    // color: Colors.white.withOpacity(0.9),
                    // colorBlendMode: BlendMode.modulate,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back),
                    iconSize: 30,
                    color: Colors.white,
                  ),
                ),
              ]),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.place.place_name,
                      style: TextStyle(
                          color: Colors.black87,
                          //  r: Colors.indigo[900],
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.1),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    _RatingStars(widget.place.rate),

                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '${widget.place.time_open}-${widget.place.time_close} ',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 25),
                    //   child: Divider(
                    //     height: 15,
                    //     thickness: 1,
                    //     color: Colors.grey,
                    //   ),
                    // ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Fees',
                      style: TextStyle(
                          color: Colors.black87,
                          //  r: Colors.indigo[900],
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.1),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return Text(
                          String.fromCharCode(0x2022) + ' ' + widget.place.fees,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 10,
                        );
                      },
                    ),

                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      'Location on Map',
                      style: TextStyle(
                          color: Colors.black87,
                          //  r: Colors.indigo[900],
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.1),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 300,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                              widget.place.langtiude, widget.place.latitude),
                          zoom: 4,
                        ),
                        onMapCreated:
                            (GoogleMapController googleMapController) {
                          setState(() {
                            Mymarkers.add(
                              Marker(
                                markerId: MarkerId('1'),
                                position: LatLng(widget.place.langtiude,
                                    widget.place.latitude),
                              ),
                            );
                          });
                        },
                        markers: Mymarkers,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.black,
                        ),
                        Container(
                          width: 320,
                          child: Text(
                            widget.place.location,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
