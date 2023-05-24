import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:trippo/Models/UserModel.dart';
import '../API/api.dart';
import 'OfficeViewTrips.dart';

class OffiecProfile_OfficerSide extends StatefulWidget {
  @override
  State<OffiecProfile_OfficerSide> createState() =>
      _OffiecProfile_OfficerSideState();
}

class _OffiecProfile_OfficerSideState extends State<OffiecProfile_OfficerSide> {
  @override
  var isLoading = true;
  UserModel? _userModel;
  @override
  void initState() {
    _FetchUserData().then((value) {
      setState(() {
        _userModel = value;
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
  //

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
              appBar: AppBar(
                  toolbarHeight: 70,
                  centerTitle: true,
                  backgroundColor: Colors.blue.shade900,
                  title: Text('Office Profile'),
                  titleTextStyle: TextStyle(
                    fontSize: 30,
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      //TODO CHANGE ROUTE
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OfficeViewTrips())),
                    ),
                  )),
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 40.0,
                        width: 150.0,
                      ),
                      CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.blue.shade900,
                        backgroundImage: NetworkImage(
                            'http://192.168.43.164:8000/${_userModel!.photo}'),
                        // AssetImage('assets/travel.png'),
                      ),
                      SizedBox(
                        height: 30.0,
                        width: 150.0,
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
                                    _userModel!.FirstName,
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
                                    Icons.account_balance,
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
                                    _userModel!.Email,
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
                        height: 35.0,
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
                                    _userModel!.PhoneNumber,
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
                        height: 30.0,
                        width: 150.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
