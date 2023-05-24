import 'dart:convert';

import 'package:flutter/material.dart';

import '../API/api.dart';
import '../Models/placeModel.dart';
import 'Place.dart';
import 'home.dart';

List<PlaceModel> places = <PlaceModel>[];

String TimeOpen = '';
String TimeClose = '';

class Attractions extends StatefulWidget {
  @override
  _AttractionsState createState() => _AttractionsState();
}

Text _RatingStars(int rating) {
  String star = '';
  for (int i = 0; i < rating; i++) star += '⭐ ';
  return Text(star);
}

class _AttractionsState extends State<Attractions> {
  String? val;
  int? cid;
  TextEditingController open = new TextEditingController();
  TextEditingController close = new TextEditingController();
  List<PlaceModel> _places = <PlaceModel>[];
  void initState() {
    _FetchPlaces().then((value) {
      setState(() {
        _places.addAll(value);
        places.clear();
        places.addAll(value);
      });
    });
    super.initState();
  }

  Future<List<PlaceModel>> _FetchPlaces() async {
    var response = await CallApi().getdata('information_places');
    // print(response.body);
    var places = <PlaceModel>[];
    var item = json.decode(response.body);

    for (var i in item) {
      places.add(PlaceModel.fromJson(i));
    }

    return places;
  }

  Future FilterPlace() async {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (TimeOpen != '') {
      data['time_open'] = startDate;
      data['time_close'] = EndDate;
    }

    data['country_id'] = cid;
    var response = await CallApi().postdata(data, 'user/placesfilters');
    print(response.body);
    if (response.statusCode == 200) {
      var item = json.decode(response.body);
      setState(() {
        for (var i in item) {
          _places.add(PlaceModel.fromJson(i));
          print(_places.length);
        }
      });
      // load = true;
    } else
      print('vgbhjk');
  }

  var selectedList = <String>[];
  Future<void> FilterDialog() {
    open.text = TimeOpen;
    close.text = TimeClose;

    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext Filter) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Container(
              // height: 800,
              //  color: Colors.grey.shade200,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Filter By ',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Country: ',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.indigo, width: 2),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: val,
                              isExpanded: true,
                              hint: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Text(
                                  'Select Country',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.blue.shade900,
                              ),
                              iconSize: 30,
                              borderRadius: BorderRadius.circular(8),
                              items: countries.map((itemsname) {
                                return DropdownMenuItem(
                                  value: itemsname.county_name,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      itemsname.county_name,
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newVal) {
                                setState(() {
                                  val = newVal as String?;
                                  for (int i = 0; i < countries.length; i++) {
                                    if (countries[i].county_name == val)
                                      cid = countries[i].country_id;
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Open Time: ',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: SizedBox(
                            height: 50,
                            width: 300,
                            child: TextField(
                              controller: open,
                              onChanged: (value) {
                                TimeOpen = value;
                                if (EndDate != '') num = 1;
                              },
                              decoration: InputDecoration(
                                hintText: 'Open Time',
                                icon: Icon(
                                  Icons.timer,
                                  color: Colors.blue.shade900,
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 20,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 2,
                                    color: Colors.indigo,
                                  ),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: SizedBox(
                            height: 50,
                            width: 300,
                            child: TextField(
                              controller: close,
                              onChanged: (value) {
                                TimeClose = value;
                                if (EndDate != '') num = 2;
                              },
                              decoration: InputDecoration(
                                hintText: 'Close Time',
                                icon: Icon(
                                  Icons.timer_off,
                                  color: Colors.blue.shade900,
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 20,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 2,
                                    color: Colors.indigo,
                                  ),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.blue.shade900,
                              borderRadius: BorderRadius.circular(50)),
                          child: FlatButton(
                            child: Text(
                              'Reset',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                open.text = '';
                                close.text = '';
                              });
                            },
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.blue.shade900,
                              borderRadius: BorderRadius.circular(50)),
                          child: FlatButton(
                            child: Text(
                              'Apply',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              if (cid != null || TimeOpen != '') {
                                _places.clear();
                                FilterPlace();
                              }
                              // if (load == true)
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Container(
                    height: 50,
                    width: 70,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.grey.withOpacity(0.5), //color of shadow
                            spreadRadius: 2, //spread radius
                            blurRadius: 7, // blur radius
                            offset: Offset(0, 2), // changes position of shadow
                          )
                        ],
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: IconButton(
                      onPressed: () {
                        FilterDialog();
                      },
                      icon: Icon(Icons.filter_alt, color: Colors.grey.shade700),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _places.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Place(place: _places[index])),
                        );
                      },
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(45, 5, 20, 5),
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(120, 20, 20, 20),
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
                                        width: 200,
                                        child: Text(
                                          _places[index].place_name,
                                          style: TextStyle(
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.w600),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4.0,
                                  ),
                                  _RatingStars(_places[index].rate),
                                  // Container(
                                  //   width: 300,
                                  //   child: Text(
                                  //     'Pla pla information ...',
                                  //     style: TextStyle(
                                  //       fontSize: 18.0,
                                  //     ),
                                  //     maxLines: 2,
                                  //     overflow: TextOverflow.ellipsis,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 20,
                            top: 7,
                            bottom: 7,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                width: 130,
                                image: NetworkImage(
                                  'http://192.168.43.164:8000/${_places[index].photo}',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
