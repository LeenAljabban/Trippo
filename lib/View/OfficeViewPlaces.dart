import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trippo/View/EditPlace.dart';

import '../API/api.dart';
import '../Models/placeModel.dart';

class OfficeViewPlaces extends StatefulWidget {
  @override
  _OfficeViewPlacesState createState() => _OfficeViewPlacesState();
}

class _OfficeViewPlacesState extends State<OfficeViewPlaces> {
  List<PlaceModel> _places = <PlaceModel>[];
  void initState() {
    _FetchPlaces().then((value) {
      setState(() {
        _places.addAll(value);
      });
    });
    super.initState();
  }

  Future<List<PlaceModel>> _FetchPlaces() async {
    var response = await CallApi().getdata('information_places');
    //   print(response.body);
    var places = <PlaceModel>[];
    var item = json.decode(response.body);

    for (var i in item) {
      places.add(PlaceModel.fromJson(i));
    }

    return places;
  }

  _DeletePlace(id) async {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['place_id'] = id;
    var response = await CallApi().postdata(data, 'officer/delete_places');
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
      child: Scaffold(
        appBar: AppBar(
            title: Text('Places'),
            titleTextStyle: TextStyle(
              fontSize: 30,
            ),
            centerTitle: true,
            backgroundColor: Colors.blue.shade900,
            toolbarHeight: 70,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                    height: 15,
                  ),
              itemCount: _places.length,
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
                                  _places[index].place_name,
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
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
                                      Icons.timer_outlined,
                                      color: Colors.blue.shade900,
                                      size: 25,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        _places[index].time_open,
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                            color: Colors.blue.shade900,
                                            fontSize: 20.0,
                                            fontFamily: 'source Sans Pro'),
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
                                      Icons.timer_off_outlined,
                                      color: Colors.blue.shade900,
                                      size: 25,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        _places[index].time_close,
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                            color: Colors.blue.shade900,
                                            fontSize: 20.0,
                                            fontFamily: 'source Sans Pro'),
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
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditPlace(
                                        placeModel: _places[index],
                                      ),
                                    ),
                                  );
                                  // _FetchPlaces().then((value) {
                                  //   setState(() {
                                  //     _places.addAll(value);
                                  //   });
                                  // });
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
                                              'DO YOU WANT TO DELETE THIS PLACE',
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
                                                    onPressed: () async {
                                                      setState(() {
                                                        _DeletePlace(
                                                            _places[index]
                                                                .place_id);
                                                        _places.removeAt(index);
                                                      });
                                                    },
                                                  ),
                                                  RaisedButton(
                                                    child: Text('cancel'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ]);
                                      });
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
