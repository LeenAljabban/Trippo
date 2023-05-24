import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trippo/Models/TripModel.dart';

import '../API/api.dart';
import 'CheckboxList.dart';

class Reservation extends StatefulWidget {
  final TripModel tripModel;
  const Reservation({Key? key, required this.tripModel}) : super(key: key);
  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  int num = 1;
  int? total;
  List<CheckboxList> info = [];

  List<int> selected = [];
  void initState() {
    setState(() {
      if (widget.tripModel.dicounts != 0) {
        total = widget.tripModel.total_trip_price;
      } else
        total = widget.tripModel.price_after_discount;
    });

    for (int i = 0; i < widget.tripModel.places.length; i++) {
      info.add(CheckboxList(
          widget.tripModel.places[i].place_id,
          widget.tripModel.places[i].place_name,
          widget.tripModel.places[i].pivot.place_trip_price,
          true));
      selected.add(widget.tripModel.places[i].place_id);
    }
    super.initState();
  }

  Future _PostReserve() async {
    print(num);
    var data;

    data = {
      'confirm_button': 'yes',
      'trip_id': widget.tripModel.id,
      'passenger_number': num,
      'places_id': selected,
      'total_money': 0,
    };

    var response = await CallApi().postdata(data, 'user/add_reservation');
    print(response.body);
    // var body = json.decode(response.body);
    // print(body);

    if (response.statusCode == 200) {
      if (response.body ==
          'entered passenger_number larger than the total trip passenger') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Center(
                child: Text(
              'Error',
            )),
            content: Text(
                'entered passenger_number larger than the total trip passenger'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'))
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Center(
                child: Text(
              'Reservation Confirmed',
            )),
            content: Text(
                'If payment is not made within three days to the office, the reservation will be canceled'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'))
            ],
          ),
        );
      }
    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Padding(
          padding: const EdgeInsets.only(left: 95),
          child: Text('Reserve'),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
          iconSize: 30,
          color: Colors.white,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: info.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.blue.shade900, spreadRadius: 3),
                      ],
                    ),
                    child: CheckboxListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          info[index].name,
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.w600),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(info[index].price.toString()),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      onChanged: (value) {
                        setState(() {
                          info[index].isSelected = value!;
                          if (info[index].isSelected == true) {
                            selected.add(info[index].id);

                            total = total! + info[index].price;
                          } else if (info[index].isSelected == false) {
                            selected.removeWhere(
                                (element) => element == info[index].id);

                            total = total! - info[index].price;
                          }
                        });
                      },
                      value: info[index].isSelected,
                      activeColor: Colors.blue.shade900,
                    ),
                  ),
                );
              }),
          SizedBox(
            height: 15,
          ),
          Column(
            children: [
              Text(
                'Select the number of passenger',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30),
                child: Container(
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: Colors.blue.shade900, width: 2)),
                  height: 40,
                  child: ListWheelScrollView.useDelegate(
                    onSelectedItemChanged: (i) {
                      num = i + 1;
                    },
                    itemExtent: 40,
                    childDelegate: ListWheelChildLoopingListDelegate(
                      children: List<Widget>.generate(
                        widget.tripModel.available_num_passenger,
                        (index) => Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'Total Price',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30),
                child: Container(
                  child: Center(
                    child: Text(
                      total.toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  width: 120,
                  decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(1),
                      border:
                          Border.all(color: Colors.blue.shade900, width: 3)),
                  height: 40,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.blue.shade900,
                  borderRadius: BorderRadius.circular(50)),
              child: FlatButton(
                child: Text(
                  'Reserve',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (selected.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: Center(
                                child: Text(
                                  'Warning!!',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              content: Text(
                                'You Have To Choose Places',
                                style: TextStyle(color: Colors.black),
                              ),
                              actions: [
                                Center(
                                  child: RaisedButton(
                                    child: Text('Ok'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              ]);
                        });
                  } else
                    _PostReserve();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
