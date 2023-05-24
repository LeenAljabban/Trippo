import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../API/api.dart';
import '../Models/UserModel.dart';

class OffiecProfile_UserSide extends StatefulWidget {
  UserModel userModel;
  OffiecProfile_UserSide({Key? key, required this.userModel}) : super(key: key);

  @override
  State<OffiecProfile_UserSide> createState() => _OffiecProfile_UserSideState();
}

class _OffiecProfile_UserSideState extends State<OffiecProfile_UserSide> {
  Future _Report() async {
    var data;
    data = {
      'id': '${widget.userModel.id}',
    };
    var response = await CallApi().postdata(data, 'user/report_office');
    print(response.body);
    print(widget.userModel.id);

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text('You have reported the office successfully'),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Center(child: Text('Ok')))
          ],
        ),
      );
    } else
      print('errrorr');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    height: 220,
                    width: 450,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.zero, bottomLeft: Radius.zero),
                      child: Image(
                        image: NetworkImage(
                            'http://192.168.43.164:8000/${widget.userModel.photo}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () async {
                            /*await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );*/
                          },
                          icon: Icon(Icons.arrow_back),
                          iconSize: 30,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
                width: 150.0,
              ),
              Text('-OFFICE INFORMATION-',
                  style: TextStyle(
                      color: Colors.blue.shade900,
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
                children: [
                  Icon(
                    Icons.account_balance_sharp,
                    color: Colors.blue.shade900,
                    size: 25,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('OFFICE NAME',
                      style: TextStyle(
                          color: Colors.blue.shade900,
                          fontFamily: 'Source Sans Pro',
                          fontSize: 20.0,
                          letterSpacing: 2.5,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(
                height: 30.0,
                width: 150.0,
              ),
              Text(widget.userModel.FirstName,
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontFamily: 'source Sans Pro',
                  )),
              Divider(
                height: 30,
                thickness: 2,
                indent: 30,
                endIndent: 30,
              ),
              SizedBox(
                height: 30.0,
                width: 150.0,
              ),
              Text('-CONTACT INFORMATION-',
                  style: TextStyle(
                      color: Colors.blue.shade900,
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
                children: [
                  Icon(
                    Icons.email,
                    color: Colors.blue.shade900,
                    size: 25,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('OFFICE Email',
                      style: TextStyle(
                          color: Colors.blue.shade900,
                          fontFamily: 'Source Sans Pro',
                          fontSize: 20.0,
                          letterSpacing: 2.5,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(
                height: 30.0,
                width: 150.0,
              ),
              Text(widget.userModel.Email,
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontFamily: 'source Sans Pro',
                  )),
              Divider(
                height: 30,
                thickness: 2,
                indent: 30,
                endIndent: 30,
              ),
              SizedBox(
                height: 40.0,
                width: 150.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.phone,
                    color: Colors.blue.shade900,
                    size: 25,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('OFFICE Number',
                      style: TextStyle(
                          color: Colors.blue.shade900,
                          fontFamily: 'Source Sans Pro',
                          fontSize: 20.0,
                          letterSpacing: 2.5,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(
                height: 30.0,
                width: 150.0,
              ),
              Text(widget.userModel.PhoneNumber,
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontFamily: 'source Sans Pro',
                  )),
              Divider(
                height: 30,
                thickness: 2,
                indent: 30,
                endIndent: 30,
              ),
              SizedBox(
                height: 30.0,
                width: 150.0,
              ),
              Text(' FACING  PROBLEM !!! ',
                  style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20.0,
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 8.0,
                width: 150.0,
              ),
              Text('Send Your Report Now',
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: Colors.blue.shade900,
                    fontSize: 20.0,
                    fontFamily: 'source Sans Pro',
                  )),
              SizedBox(
                height: 30.0,
                width: 150.0,
              ),
              InkWell(
                onTap: () {
                  _Report();
                },
                child: Container(
                  height: 40,
                  width: 120,
                  margin: const EdgeInsets.only(
                      left: 0, top: 0, right: 0, bottom: 0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade900,
                    border: Border.all(color: Colors.blue.shade900, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Report',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontFamily: 'source Sans Pro'),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
                width: 150.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
