import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trippo/Models/ReservationModel.dart';
import 'package:trippo/Models/TripModel.dart';

import '../API/api.dart';
import 'CheckboxList.dart';

class EditReservation extends StatefulWidget {
  final ReservationModel reservationModel;
  const EditReservation({Key? key, required this.reservationModel})
      : super(key: key);
  @override
  _EditReservationState createState() => _EditReservationState();
}

class _EditReservationState extends State<EditReservation> {
  int? num = 1;
  int? total;
  bool isload = false;
  List<CheckboxList> info = [];
  List<int> selected = [];

  void initState() {
    /////////
    // num = widget.reservationModel.passenger_number;

    total = widget.reservationModel.reservation_price;
    for (int i = 0; i < widget.reservationModel.trip[0].places.length; i++) {
      setState(() {
        if (widget.reservationModel.places_reserv.any((item) =>
            item.place_id ==
            widget.reservationModel.trip[0].places[i].place_id)) {
          selected.add(widget.reservationModel.trip[0].places[i].place_id);
          // print(widget.reservationModel.trip[0].places[i].place_id);
        }
        info.add(CheckboxList(
          widget.reservationModel.trip[0].places[i].place_id,
          widget.reservationModel.trip[0].places[i].place_name,
          widget.reservationModel.trip[0].places[i].pivot.place_trip_price,
          widget.reservationModel.places_reserv.any((item) =>
                  item.place_id ==
                  widget.reservationModel.trip[0].places[i].place_id)
              ? true
              : false,
        ));

        //  WidgetsBinding.instance.addPostFrameCallback(initListData);
      });
    }

    isload = true;

    super.initState();
  }

  Future _PostReserve() async {
    print(num.toString());
    print(widget.reservationModel.id.toString());
    var data;

    data = {
      'reserv_id': widget.reservationModel.id,
      'passenger_number': num,
      'places_id': selected,
    };
    print(selected);
    var response = await CallApi().postdata(data, 'user/edit_reserv');

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
              'Reservation Updated Succesfully',
            )),
            // content: Text(
            //     'If payment is not made within three days to the office, the reservation will be canceled'),
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
    return isload
        ? Scaffold(
            backgroundColor: Colors.grey.shade300,
            appBar: AppBar(
              backgroundColor: Colors.blue.shade900,
              title: Padding(
                padding: const EdgeInsets.only(left: 95),
                child: Text(widget.reservationModel.trip[0].trip_name),
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
                              BoxShadow(
                                  color: Colors.blue.shade900, spreadRadius: 3),
                            ],
                          ),
                          child: CheckboxListTile(
                            value: info[index].isSelected,
                            title: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, bottom: 9),
                              child: Text(
                                info[index].name,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(info[index].price.toString()),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
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
                            border: Border.all(
                                color: Colors.blue.shade900, width: 3)),
                        height: 40,
                        child: ListWheelScrollView.useDelegate(
                          onSelectedItemChanged: (i) {
                            num = i + 1;
                            print(num);
                          },
                          // perspective: double.parse(
                          //     widget.reservationModel.passenger_number.toString()),
                          itemExtent: 40,
                          childDelegate: ListWheelChildLoopingListDelegate(
                            children: List<Widget>.generate(
                              widget.reservationModel.trip_id,
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
                            border: Border.all(
                                color: Colors.blue.shade900, width: 3)),
                        height: 40,
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    height: 50,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade900,
                        borderRadius: BorderRadius.circular(50)),
                    child: FlatButton(
                      child: Text(
                        'Ok',
                        style: TextStyle(
                          fontSize: 20,
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
          )
        : Container();
  }
}
