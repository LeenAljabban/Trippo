import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trippo/View/EditPlace.dart';

import '../API/api.dart';
import '../Models/TripModel.dart';
import 'EditTrip.dart';

class OfficeViewTrips extends StatefulWidget {
  const OfficeViewTrips({Key? key}) : super(key: key);

  @override
  _OfficeViewTripsState createState() => _OfficeViewTripsState();
}

class _OfficeViewTripsState extends State<OfficeViewTrips> {
  bool isLoading = true;
  List<TripModel> _trips = <TripModel>[];
  void initState() {
    _FetchOfficeTrips().then((value) {
      setState(() {
        _trips.addAll(value);
        isLoading = false;
      });
    });
    super.initState();
  }

  Future<List<TripModel>> _FetchOfficeTrips() async {
    var response = await CallApi().getdata('officer/get_specific_office_trip');

    var trips = <TripModel>[];
    var item = json.decode(response.body);

    for (var i in item) {
      trips.add(TripModel.fromJson(i));
    }

    return trips;
  }

  _DeleteTrip(id) async {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['trip_id'] = id;
    var response = await CallApi().postdata(data, 'officer/delete_trip');
    // var body = json.decode(
    //     response.body);

    if (response.statusCode == 200) {
      Navigator.of(context).pop();
    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isLoading
          ? Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 20),
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
                color: Colors.blue.shade900,
              ),
            )
          : Scaffold(
              appBar: AppBar(
                  title: Text('My Trips'),
                  titleTextStyle: TextStyle(
                    fontSize: 30,
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.blue.shade900,
                  toolbarHeight: 70,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context, false),
                  )),
              body: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                          height: 15,
                        ),
                    itemCount: _trips.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 180,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Card(
                            color: Colors.grey.shade300,
                            shadowColor: Colors.blue.shade900,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  height: 150,
                                  width: 297,
                                  padding: const EdgeInsets.only(
                                      left: 8, top: 12, right: 8, bottom: 8),
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    children: [
                                      Text(
                                        _trips[index].trip_name,
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                            color: Colors.blue.shade900,
                                            fontSize: 20.0,
                                            fontFamily: 'source Sans Pro'),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(
                                        color: Colors.blue.shade900,
                                        thickness: 2,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.panorama_fish_eye,
                                            color: Colors.blue.shade900,
                                            size: 25,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              _trips[index].trip_status,
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                  color: Colors.blue.shade900,
                                                  fontSize: 20.0,
                                                  fontFamily:
                                                      'source Sans Pro'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.timelapse_rounded,
                                            color: Colors.blue.shade900,
                                            size: 25,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              _trips[index]
                                                      .duration
                                                      .toString() +
                                                  ' days',
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                  color: Colors.blue.shade900,
                                                  fontSize: 20.0,
                                                  fontFamily:
                                                      'source Sans Pro'),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  OfficeEditTrip(
                                                    tripModel: _trips[index],
                                                  )),
                                        );
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.blue.shade900,
                                        size: 25,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  title: Center(
                                                    child: Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  content: Text(
                                                    'Do You Want To Delete This Trip',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  actions: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        RaisedButton(
                                                          child: Text('Delete'),
                                                          onPressed: () {
                                                            setState(() {
                                                              _DeleteTrip(
                                                                  _trips[index]
                                                                      .id);
                                                              _trips.removeAt(
                                                                  index);
                                                            });
                                                          },
                                                        ),
                                                        RaisedButton(
                                                          child: Text('cancel'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ]);
                                            });
                                        /*Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ),
                                    );*/
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.blue.shade900,
                                        size: 25,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
    );
  }
}
