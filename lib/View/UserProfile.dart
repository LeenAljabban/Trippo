import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trippo/View/EditProfile.dart';

import '../API/api.dart';
import '../Models/UserModel.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var isLoading = true;
  UserModel? _user;
  @override
  void initState() {
    _FetchUserData().then((value) {
      setState(() {
        _user = value;
        isLoading = false;
      });
    });
  }

  Future _FetchUserData() async {
    var response = await CallApi().getdata('logged_info');
    var item = json.decode(response.body);
    UserModel user;
    user = UserModel.fromJson(item);

    return user;
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
              backgroundColor: Colors.white,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 5.0,
                    width: 150.0,
                  ),
                  CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.blue.shade900,
                    backgroundImage:
                        //AssetImage('assets/Aleppo.png'),
                        NetworkImage(
                            'http://192.168.43.164:8000/${_user!.photo}'),
                  ),
                  SizedBox(
                    height: 10.0,
                    width: 150.0,
                  ),
                  Text('USER INFORMATION',
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Source Sans Pro',
                          fontSize: 20.0,
                          letterSpacing: 2.5,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 20.0,
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
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                )
                              ],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 25, top: 0, right: 0, bottom: 0),
                              child: Text(
                                _user!.FirstName,
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
                                Icons.account_circle_rounded,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            height: 50,
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
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                )
                              ],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 25, top: 0, right: 0, bottom: 0),
                              child: Text(
                                _user!.LastName,
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
                                Icons.location_on,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            height: 50,
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
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                )
                              ],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 25, top: 0, right: 0, bottom: 0),
                              child: Text(
                                _user!.Gender,
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
                                Icons.transgender_sharp,
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
                  Text('CONTACT INFORMATION',
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Source Sans Pro',
                          fontSize: 20.0,
                          letterSpacing: 2.5,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 20.0,
                    width: 150.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            height: 50,
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
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                )
                              ],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 25, top: 0, right: 0, bottom: 0),
                              child: Text(
                                _user!.Email,
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
                                Icons.email_rounded,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            height: 50,
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
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                )
                              ],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 25, top: 0, right: 0, bottom: 0),
                              child: Text(
                                _user!.PhoneNumber,
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
                    height: 10.0,
                    width: 150.0,
                  ),
                  InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditProfile(userModel: _user!)),
                      );
                      _FetchUserData().then((value) {
                        setState(() {
                          _user = value;
                          isLoading = false;
                        });
                      });
                    },
                    child: Container(
                      height: 40,
                      width: 80,
                      margin: const EdgeInsets.only(
                          left: 0, top: 0, right: 0, bottom: 0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade900,
                        border:
                            Border.all(color: Colors.blue.shade900, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.grey.withOpacity(0.5), //color of shadow
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
            ),
    );
  }
}
