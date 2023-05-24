import 'package:flutter/material.dart';
import 'package:trippo/View/AddTrip.dart';
import 'package:trippo/View/OfficeViewPlaces.dart';
import 'package:trippo/View/OfficeViewTrips.dart';
import 'package:trippo/View/OffiecProfile_OfficerSide.dart';
import 'package:trippo/View/addPlace.dart';
import 'package:trippo/View/login.dart';

import '../API/api.dart';

class OfficerDashBoard extends StatefulWidget {
  @override
  _OfficerDashBoardState createState() => _OfficerDashBoardState();
}

class _OfficerDashBoardState extends State<OfficerDashBoard> {
  Logout() async {
    var response = await CallApi().postdata(null, 'logout');
    // var body = json.decode(
    //     response.body);

    if (response.statusCode == 200) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) => Login(),
        ),
        (Route route) => false,
      );
    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .25,
              decoration: BoxDecoration(
                color: Colors.blue.shade900,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(150),
                  bottomRight: Radius.circular(150),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 60.0, left: 30, right: 30),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 12,
                primary: false,
                children: [
                  InkWell(
                    child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_location_alt,
                              color: Colors.blue.shade900,
                              size: 50,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Add Place',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue.shade900,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )),
                    onTap: () => Navigator.push(
                      this.context,
                      new MaterialPageRoute(
                        builder: (context) => AddPlace(),
                      ),
                    ),
                  ),
                  InkWell(
                    child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_box_outlined,
                              color: Colors.blue.shade900,
                              size: 50,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Add Trip',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue.shade900,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )),
                    onTap: () {
                      Navigator.push(
                        this.context,
                        new MaterialPageRoute(
                          builder: (context) => AddTrip(),
                        ),
                      );
                    },
                  ),
                  InkWell(
                    child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit_location_rounded,
                              color: Colors.blue.shade900,
                              size: 50,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Edit Place',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue.shade900,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OfficeViewPlaces(),
                        ),
                      );
                    },
                  ),
                  InkWell(
                    child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.blue.shade900,
                              size: 50,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Edit Trip',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue.shade900,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OfficeViewTrips(),
                        ),
                      );
                    },
                  ),
                  InkWell(
                    child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.blue.shade900,
                              size: 50,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Delete Trip',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue.shade900,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OfficeViewTrips(),
                        ),
                      );
                    },
                  ),
                  InkWell(
                    child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.blue.shade900,
                              size: 50,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Delete Places',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue.shade900,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OfficeViewPlaces(),
                        ),
                      );
                    },
                  ),
                  InkWell(
                    child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.blue.shade900,
                              size: 50,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'View Profile',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue.shade900,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OffiecProfile_OfficerSide(),
                        ),
                      );
                    },
                  ),
                  InkWell(
                    child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.blue.shade900,
                              size: 50,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Log Out',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue.shade900,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )),
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          title: Center(
                              child: Text(
                            'Log Out',
                          )),
                          content: Builder(
                            builder: (context) {
                              // Get available height and width of the build area of this widget. Make a choice depending on the size.
                              var height = MediaQuery.of(context).size.height;
                              var width = MediaQuery.of(context).size.width;

                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  child: Center(
                                      child: Text(
                                          'are you really want to logout? ')),
                                  height: height - 660,
                                  width: width - 20,
                                ),
                              );
                            },
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'cancel',
                                      // style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: Logout, child: Text('logout')),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
