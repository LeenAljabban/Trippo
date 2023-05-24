import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trippo/Models/TripModel.dart';

import '../API/api.dart';
import 'Trip.dart';
import 'home.dart';

List<TripModel> disscount = <TripModel>[];

class Discounts extends StatefulWidget {
  @override
  _DiscountsState createState() => _DiscountsState();
}

class _DiscountsState extends State<Discounts> {
  List<TripModel> _disscount = <TripModel>[];
  void initState() {
    _FetchDiscounts().then((value) {
      setState(() {
        _disscount.addAll(value);
        disscount.addAll(value);
      });
    });
    super.initState();
  }

  Future<List<TripModel>> _FetchDiscounts() async {
    var response = await CallApi().getdata('get_trip_withdiscount');
    // print(response.body);
    var discounts = <TripModel>[];
    var item = json.decode(response.body);

    for (var i in item) {
      discounts.add(TripModel.fromJson(i));
    }

    return discounts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Container(
          //  height: 380,
          child: ListView.builder(
              itemCount: _disscount.length,
              padding: EdgeInsets.only(top: 10, bottom: 15),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Trip(tripModel: _disscount[index])),
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(120, 20, 20, 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    //     color: Colors.red,
                                    width: 130,
                                    child: Text(
                                      _disscount[index].trip_name,
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w600),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        _disscount[index]
                                                .total_trip_price
                                                .toString() +
                                            ' SP',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationColor: Colors.red,
                                            decorationThickness: 2,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        _disscount[index]
                                                .price_after_discount
                                                .toString() +
                                            ' SP',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            decorationThickness: 2,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Container(
                                padding: EdgeInsets.all(2),
                                width: 100.0,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  _disscount[index].trip_status,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    width: 100.0,
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade100,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      _disscount[index].trip_start,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    width: 100.0,
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade100,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      _disscount[index].trip_start,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        top: 15,
                        bottom: 15,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(
                            width: 110,
                            image: NetworkImage(
                                'http://192.168.43.164:8000/${_disscount[index].photo}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
