import 'package:flutter/material.dart';

import 'NavBar.dart';

class Office extends StatefulWidget {
  // final PlaceModel place;
  // const Place({Key? key, required this.place}) : super(key: key);
  @override
  _OfficeState createState() => _OfficeState();
}

class _OfficeState extends State<Office> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.blue.shade900,
              toolbarHeight: 70,
              title: Text('Office Profile'),
              titleTextStyle: TextStyle(
                fontSize: 30,
              ),
              leading: Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  //TODO CHANGE ROUTE
                  onPressed: () => Navigator.pop(context),
                ),
              )),
          drawer: NavBar(),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60.0,
                ),
                Text('OFFICE INFORMATION',
                    style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Source Sans Pro',
                        fontSize: 20.0,
                        letterSpacing: 2.5,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 30.0,
                  width: 150.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 50,
                          // 335
                          //250
                          width: 300,
                          margin: const EdgeInsets.only(
                              left: 25, top: 0, right: 0, bottom: 0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.blue.shade900, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), //color of shadow
                                spreadRadius: 5, //spread radius
                                blurRadius: 7, // blur radius
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              )
                            ],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 25, top: 0, right: 0, bottom: 0),
                            child: Text(
                              // userprofilemodel.FirstName,
                              'Office Name',
                              softWrap: false,
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                  color: Colors.blue.shade900,
                                  fontSize: 20.0,
                                  fontFamily: 'source Sans Pro'),
                            ),
                          ),
                        ),
                        Stack(children: <Widget>[
                          CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Colors.blue.shade900,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.home_work,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                        ]),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 40.0,
                  width: 150.0,
                ),
                Text('CONTACT INFORMATION',
                    style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Source Sans Pro',
                        fontSize: 20.0,
                        letterSpacing: 2.5,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 30.0,
                  width: 150.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 50,
                          // 335
                          //250
                          width: 300,
                          margin: const EdgeInsets.only(
                              left: 25, top: 0, right: 0, bottom: 0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.blue.shade900, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), //color of shadow
                                spreadRadius: 5, //spread radius
                                blurRadius: 7, // blur radius
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              )
                            ],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 25, top: 0, right: 0, bottom: 0),
                            child: Text(
                              // userprofilemodel.FirstName,
                              'Office Email',
                              softWrap: false,
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                  color: Colors.blue.shade900,
                                  fontSize: 20.0,
                                  fontFamily: 'source Sans Pro'),
                            ),
                          ),
                        ),
                        Stack(children: <Widget>[
                          CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Colors.blue.shade900,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.email,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                        ]),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 30.0,
                  width: 150.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 50,
                          // 335
                          //250
                          width: 300,
                          margin: const EdgeInsets.only(
                              left: 25, top: 0, right: 0, bottom: 0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.blue.shade900, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), //color of shadow
                                spreadRadius: 5, //spread radius
                                blurRadius: 7, // blur radius
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              )
                            ],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 25, top: 0, right: 0, bottom: 0),
                            child: Text(
                              // userprofilemodel.FirstName,
                              'Office Number',
                              softWrap: false,
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                  color: Colors.blue.shade900,
                                  fontSize: 20.0,
                                  fontFamily: 'source Sans Pro'),
                            ),
                          ),
                        ),
                        Stack(children: <Widget>[
                          CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Colors.blue.shade900,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.phone,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                        ]),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                  width: 150.0,
                ),
                SizedBox(
                  height: 10.0,
                  width: 150.0,
                ),
                InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => OfficeViewTrips()),
                    // );
                  },
                  child: Container(
                    height: 40,
                    width: 80,
                    margin: const EdgeInsets.only(
                        left: 0, top: 0, right: 0, bottom: 0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      border: Border.all(color: Colors.blue.shade900, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), //color of shadow
                          spreadRadius: 5, //spread radius
                          blurRadius: 7, // blur radius
                          offset: Offset(0, 2), // changes position of shadow
                        )
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Edit',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: 'source Sans Pro'),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
