import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:permission_handler/permission_handler.dart';

import '../API/api.dart';
import '../Models/MapModel.dart';

class BigMap extends StatefulWidget {
  @override
  _BigMapState createState() => _BigMapState();
}

class _BigMapState extends State<BigMap> {
  List<MapModel> _map = <MapModel>[];
  int count = 0;
  bool load = false;
  @override
  // bool get wantKeepAlive => true;
  void initState() {
    _FetchMap().then((value) {
      setState(() {
        _map.addAll(value);
      });
      load = true;
    });
    super.initState();
  }

  Future<List<MapModel>> _FetchMap() async {
    var response = await CallApi().getdata('get_map');
    // print(response.body);
    var Map = <MapModel>[];
    var item = json.decode(response.body);

    for (var i in item) {
      Map.add(MapModel.fromJson(i));
    }

    return Map;
  }

  var Mymarkers = HashSet<Marker>();

  @override
  Widget build(BuildContext context) {
    return load
        ? Scaffold(
            body: Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(35.051045072234615, 38.55494081892699),
                    zoom: 6,
                  ),
                  onMapCreated: (GoogleMapController googleMapController) {
                    setState(() {
                      for (int i = 0; i < _map.length; i++) {
                        Mymarkers.add(Marker(
                          markerId: MarkerId((count++).toString()), //way points
                          position: LatLng(_map[i].langtiude, _map[i].latitude),

                          // icon: sourceIcon,
                        ));
                      }
                    });
                    // Mymarkers.add(
                    //   Marker(
                    //     markerId: MarkerId('1'),
                    //     position: LatLng(widget.langtiude, widget.latitude),
                    //   ),
                    // );
                  },
                  markers: Mymarkers,
                )
              ],
            ),
          )
        : Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 20),
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey,
              color: Colors.blue.shade900,
            ),
          );
  }
}
