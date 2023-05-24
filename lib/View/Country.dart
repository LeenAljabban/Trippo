import 'dart:ui';
//import '../Models/placeModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trippo/Models/homeModel.dart';
import 'package:flutter_map/flutter_map.dart';

import 'Maps.dart';
import 'Place.dart';
import 'home.dart';

class Country extends StatefulWidget {
  final homeModel homemodel;
  const Country({Key? key, required this.homemodel}) : super(key: key);

  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<Country> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 220,
                    width: 450,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30)),
                      child: Image(
                        image: NetworkImage(
                            'http://192.168.43.164:8000/${widget.homemodel.image}'),
                        fit: BoxFit.cover,
                        // color: Colors.white.withOpacity(0.9),
                        // colorBlendMode: BlendMode.modulate,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.arrow_back),
                          iconSize: 30,
                          color: Colors.white,
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.search),
                              iconSize: 30,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 20,
                    bottom: 20,
                    child: Text(
                      widget.homemodel.county_name,
                      style: TextStyle(
                        color: Colors.white,
                        // fontWeight: FontWeight.w600,
                        fontSize: 50,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.homemodel.places.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Place(place: widget.homemodel.places[index])),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                          height: 125,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(120, 20, 20, 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 229,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: 119,
                                                height: 30,
                                                child: Text(
                                                  widget.homemodel.places[index]
                                                      .place_name,
                                                  style: TextStyle(
                                                      fontSize: 22.0,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.fade,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              for (int i = 0; i < 5; i++)
                                                (Icon(
                                                  Icons.star,
                                                  color: Colors.yellowAccent,
                                                  size: 20,
                                                )),
                                            ],
                                          ),
                                          Divider(
                                            thickness: 2,
                                            endIndent: 30,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_today,
                                                color: Colors.black,
                                                size: 20,
                                              ),
                                              Text(
                                                widget.homemodel.places[index]
                                                    .time_open,
                                                style: TextStyle(
                                                  fontSize: 19.0,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.fade,
                                              ),
                                              SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: VerticalDivider(
                                                  color: Colors.black,
                                                  thickness: 2,
                                                ),
                                              ),
                                              Icon(
                                                Icons.calendar_today,
                                                color: Colors.black,
                                                size: 20,
                                              ),
                                              Text(
                                                widget.homemodel.places[index]
                                                    .time_close,
                                                style: TextStyle(
                                                  fontSize: 19.0,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.fade,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                /* SizedBox(
                                  height: 50.0,
                                ),*/

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
                            borderRadius: BorderRadius.circular(20),
                            child: Image(
                              width: 110,
                              image: NetworkImage(
                                  'http://192.168.43.164:8000/${widget.homemodel.places[index].photo}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

// openDialog(contex) => showDialog(
//   context: context,
//   builder: (context) => AlertDialog(
//     title: Text('Map'),
//     // actions:,
//   ),
// );
}
