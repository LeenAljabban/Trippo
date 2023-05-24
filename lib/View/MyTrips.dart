import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../API/api.dart';
import '../Models/ReservationModel.dart';
import '../Models/TripModel.dart';
import 'Edit Reservation.dart';

List<ReservationModel> piovot = <ReservationModel>[];
List names = [];

class MyTrips extends StatefulWidget {
  @override
  MyTripsState createState() => MyTripsState();
}

class MyTripsState extends State<MyTrips> {
  var isLoading = true;
  List<ReservationModel> _myTrips = <ReservationModel>[];
  void initState() {
    _FetchMyTrips().then((value) {
      setState(() {
        _myTrips.addAll(value);
        isLoading = false;
      });
    });
    super.initState();
  }

  Future<List<ReservationModel>> _FetchMyTrips() async {
    var response = await CallApi().postdata(null, 'user/get_reservation');

    var myTrips = <ReservationModel>[];
    var item = json.decode(response.body);

    for (var i in item) {
      myTrips.add(ReservationModel.fromJson(i));
      print('d');
    }

    return myTrips;
  }

  _DeleteReserv(id) async {
    print(id);
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['selected_reserv'] = id;
    var response = await CallApi().postdata(data, 'user/cancelled_reservation');
    // var body = json.decode(
    //     response.body);

    if (response.statusCode == 200) {
      Navigator.of(context).pop();
    } else {
      print('error');
    }
  }

  int count = 0;
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
              backgroundColor: Colors.grey.shade300,
              appBar: AppBar(
                backgroundColor: Colors.blue.shade900,
                title: Text('My Trips'),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {},
                ),
              ),
              body: ListView.builder(
                  itemCount: _myTrips.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 7),
                      child: Slidable(
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
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
                                            'DO YOU WANT TO DELETE THIS PLACE',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                RaisedButton(
                                                  child: Text('Delete'),
                                                  onPressed: () {
                                                    setState(() {
                                                      // print(_myTrips[index].id);
                                                      _DeleteReserv(
                                                          _myTrips[index].id);
                                                      _myTrips.removeAt(index);
                                                    });
                                                  },
                                                ),
                                                RaisedButton(
                                                  child: Text('cancel'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            ),
                                          ]);
                                    });
                              },
                              padding:
                                  const EdgeInsets.only(top: 25.0, bottom: 15),
                              backgroundColor: Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'cancel',
                            ),
                          ],
                        ),
                        startActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditReservation(
                                          reservationModel: _myTrips[index])),
                                );
                                isLoading = true;
                                _FetchMyTrips().then((value) {
                                  setState(() {
                                    _myTrips.clear();
                                    _myTrips.addAll(value);
                                    isLoading = false;
                                  });
                                });
                              },
                              padding:
                                  const EdgeInsets.only(top: 25.0, bottom: 15),
                              backgroundColor: Colors.blue.shade500,
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              label: 'Edit',
                            ),
                          ],
                        ),
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            title: Padding(
                              padding:
                                  const EdgeInsets.only(top: 25.0, left: 15),
                              child: Text(
                                _myTrips[index].trip[0].trip_name,
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
    );
  }
}
