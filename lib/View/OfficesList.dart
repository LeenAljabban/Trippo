import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trippo/Models/UserModel.dart';
import 'package:trippo/View/OffiecProfile_UserSide.dart';

import '../API/api.dart';
import 'home.dart';

List<UserModel> offices = <UserModel>[];

class OfficesList extends StatefulWidget {
  @override
  _OfficesListState createState() => _OfficesListState();
}

class _OfficesListState extends State<OfficesList> {
  List<UserModel> _offices = <UserModel>[];
  void initState() {
    _FetchOffices().then((value) {
      setState(() {
        _offices.addAll(value);
        offices.clear();
        offices.addAll(value);
      });
    });
    super.initState();
  }

  Future<List<UserModel>> _FetchOffices() async {
    var response = await CallApi().getdata('get_all_office');
    // print(response.body);
    var offices = <UserModel>[];
    var item = json.decode(response.body);

    for (var i in item) {
      offices.add(UserModel.fromJson(i));
    }

    return offices;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Container(
          // height: 380,
          child: ListView.builder(
            itemCount: _offices.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            OffiecProfile_UserSide(userModel: _offices[index])),
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(45, 5, 20, 5),
                      height: 110,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: 200,
                                  child: Text(
                                    _offices[index].FirstName,
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
                              'http://192.168.43.164:8000/${_offices[index].photo}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
