import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../API/api.dart';
import '../Models/TripModel.dart';

class OfficeEditTrip extends StatefulWidget {
  final TripModel tripModel;

  const OfficeEditTrip({Key? key, required this.tripModel}) : super(key: key);

  @override
  State<OfficeEditTrip> createState() => _OfficeEditTripState();
}

class _OfficeEditTripState extends State<OfficeEditTrip> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController trip_nameController = TextEditingController();
  TextEditingController start_Controller = TextEditingController();
  TextEditingController end_Controller = TextEditingController();

  TextEditingController durationController = TextEditingController();
  TextEditingController trip_planeController = TextEditingController();
  TextEditingController trip_statusController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController available_num_passengerController =
      TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  int? id;
  @override
  void initState() {
    super.initState();
    id = widget.tripModel.id;
    setState(() {
      start_Controller.text = widget.tripModel.trip_start;
      end_Controller.text = widget.tripModel.trip_end;
      trip_nameController.text = widget.tripModel.trip_name;
      durationController.text = widget.tripModel.duration.toString();
      trip_planeController.text = widget.tripModel.trip_plane;
      trip_statusController.text = widget.tripModel.trip_status;
      priceController.text = widget.tripModel.total_trip_price.toString();
      available_num_passengerController.text =
          widget.tripModel.available_num_passenger.toString();
      noteController.text = widget.tripModel.note;
      discountController.text = widget.tripModel.dicounts.toString();
    });
  }

  File? _file;
  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    setState(() {
      _file = File(image.path);
    });
  }

  String url = "http://192.168.43.164:8000/api/officer/edit_trip";
  dynamic _returnResponseStream(http.StreamedResponse response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = 'Success';
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Center(
                child: Text(
              'Trip Updated Successfully',
            )),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Center(child: Text('Ok')))
            ],
          ),
        );
        print('responseJson is $responseJson');
        return responseJson;
      case 201:
        var responseJson = 'Success';
        print('responseJson is $responseJson');
        return responseJson;
      default:
        print(response.request);
    }
  }

  Future updateTrip() async {
    print(id);
    var token = await getFromSharedPreferences('token');
    var request = http.MultipartRequest('POST', Uri.parse(url));
    debugPrint('the image is ${_file}');
    if ('${_file}' != 'null') {
      request.files.add(http.MultipartFile(
          'photo',
          File(_file!.path).readAsBytes().asStream(),
          File(_file!.path).lengthSync(),
          filename: _file!.path.split("/").last));
    }

    request.fields['trip_id'] = id.toString();
    request.fields['trip_name'] = trip_nameController.text;
    request.fields['trip_start'] = start_Controller.text;
    request.fields['trip_end'] = end_Controller.text;
    request.fields['duration'] = durationController.text.toString();
    // request.fields['price'] = 500.toString();

    request.fields['trip_plane'] = trip_planeController.text;
    request.fields['trip_status'] = trip_statusController.text;
    request.fields['note'] = noteController.text;
    request.fields['total_trip_price'] = priceController.text;
    request.fields['available_num_passenger'] =
        available_num_passengerController.text;
    request.fields['discounts'] = discountController.text;

    request.headers.addAll({
      // "content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer ${token}"
    });

    var apiResponse;
    try {
      var res = await request.send();
      print(res.statusCode);
      var response = await http.Response.fromStream(res);
      print(response.body);
      apiResponse = _returnResponseStream(res);
    } on SocketException {
      print('No net');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Edit Trip'),
            titleTextStyle: TextStyle(
              fontSize: 30,
            ),
            centerTitle: true,
            backgroundColor: Colors.blue.shade900,
            toolbarHeight: 80,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(120),
                  bottomLeft: Radius.circular(120)),
            ),
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
              child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    // Navigator.push(context,
                    // MaterialPageRoute(builder: (context) => OfficeViewTrips()));
                  }),
            )),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Text('Trip Name',
                                style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontSize: 20.0,
                                    fontFamily: 'source Sans Pro')),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.drive_file_rename_outline,
                                  color: Colors.blue.shade900,
                                ),
                                Flexible(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: TextFormField(
                                      controller: trip_nameController,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.fromLTRB(15, 5, 15, 5),
                                          hintText: 'user previous password',
                                          hintStyle: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          )),
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 2,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Trip Start',
                                style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontSize: 20.0,
                                    fontFamily: 'source Sans Pro')),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  color: Colors.blue.shade900,
                                ),
                                Flexible(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                    child: TextFormField(
                                      controller: start_Controller,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.fromLTRB(15, 5, 15, 5),
                                          hintStyle: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          )),
                                      // validator: (value) {
                                      //   if (value == null || value.isEmpty) {
                                      //     return 'Please enter some text';
                                      //   }
                                      //   if (value
                                      //       .compareTo((EndSelectedDate!
                                      //               .compareTo(
                                      //                   StartSelectedDate!))
                                      //           .toString())
                                      //       .isNegative) {
                                      //     return 'wrong duration';
                                      //   }
                                      // },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 2,
                            ),
                            Text('Trip End',
                                style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontSize: 20.0,
                                    fontFamily: 'source Sans Pro')),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  color: Colors.blue.shade900,
                                ),
                                Flexible(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                    child: TextFormField(
                                      controller: end_Controller,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.fromLTRB(15, 5, 15, 5),
                                          hintStyle: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          )),
                                      // validator: (value) {
                                      //   if (value == null || value.isEmpty) {
                                      //     return 'Please enter some text';
                                      //   }
                                      //   if (value
                                      //       .compareTo((EndSelectedDate!
                                      //               .compareTo(
                                      //                   StartSelectedDate!))
                                      //           .toString())
                                      //       .isNegative) {
                                      //     return 'wrong duration';
                                      //   }
                                      // },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 2,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('available passengers number',
                                style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontSize: 20.0,
                                    fontFamily: 'source Sans Pro')),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  color: Colors.blue.shade900,
                                ),
                                Flexible(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                    child: TextFormField(
                                      controller:
                                          available_num_passengerController,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.fromLTRB(15, 5, 15, 5),
                                          hintStyle: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          )),
                                      // validator: (value) {
                                      //   if (value == null || value.isEmpty) {
                                      //     return 'Please enter some text';
                                      //   }
                                      //   if (value
                                      //       .compareTo((EndSelectedDate!
                                      //               .compareTo(
                                      //                   StartSelectedDate!))
                                      //           .toString())
                                      //       .isNegative) {
                                      //     return 'wrong duration';
                                      //   }
                                      // },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 2,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Trip Duration',
                                style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontSize: 20.0,
                                    fontFamily: 'source Sans Pro')),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  color: Colors.blue.shade900,
                                ),
                                Flexible(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                    child: TextFormField(
                                      controller: durationController,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.fromLTRB(15, 5, 15, 5),
                                          hintStyle: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          )),
                                      // validator: (value) {
                                      //   if (value == null || value.isEmpty) {
                                      //     return 'Please enter some text';
                                      //   }
                                      //   if (value
                                      //       .compareTo((EndSelectedDate!
                                      //               .compareTo(
                                      //                   StartSelectedDate!))
                                      //           .toString())
                                      //       .isNegative) {
                                      //     return 'wrong duration';
                                      //   }
                                      // },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 2,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Trip Price',
                                style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontSize: 20.0,
                                    fontFamily: 'source Sans Pro')),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.monetization_on,
                                  color: Colors.blue.shade900,
                                ),
                                Flexible(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                    child: TextFormField(
                                      controller: priceController,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.fromLTRB(15, 5, 15, 5),
                                          hintStyle: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          )),
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 2,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Trip discount',
                                style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontSize: 20.0,
                                    fontFamily: 'source Sans Pro')),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.monetization_on,
                                  color: Colors.blue.shade900,
                                ),
                                Flexible(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                    child: TextFormField(
                                      controller: discountController,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.fromLTRB(15, 5, 15, 5),
                                          hintStyle: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          )),
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 2,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Trip Status',
                                style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontSize: 20.0,
                                    fontFamily: 'source Sans Pro')),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.alarm_on_outlined,
                                  color: Colors.blue.shade900,
                                ),
                                Flexible(
                                    child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                  child: TextFormField(
                                    controller: trip_statusController,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.fromLTRB(15, 5, 15, 5),
                                        hintStyle: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue.shade900,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue.shade900,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue.shade900,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue.shade900,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        )),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                    },
                                  ),
                                ))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 2,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Trip Plan',
                                style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontSize: 20.0,
                                    fontFamily: 'source Sans Pro')),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.reorder,
                                  color: Colors.blue.shade900,
                                ),
                                Flexible(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                    child: TextFormField(
                                      controller: trip_planeController,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 10,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.fromLTRB(15, 5, 15, 5),
                                          hintStyle: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          )),
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 2,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Trip Notes',
                                style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontSize: 20.0,
                                    fontFamily: 'source Sans Pro')),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.format_list_numbered,
                                  color: Colors.blue.shade900,
                                ),
                                Flexible(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                    child: TextFormField(
                                      controller: noteController,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 10,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.fromLTRB(15, 5, 15, 5),
                                          hintText: 'user previous password',
                                          hintStyle: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue.shade900,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          )),
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 2,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: getImage,
                              child: Container(
                                width: 275,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: const Color(0xffE6E6E6),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: _file != null
                                    ? Image.file(
                                        _file!,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        'http://192.168.43.164/${widget.tripModel.photo}',
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  updateTrip();
                                }
                              },
                              child: Container(
                                height: 40,
                                width: 80,
                                margin: const EdgeInsets.only(
                                    left: 0, top: 0, right: 0, bottom: 0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade900,
                                  border: Border.all(
                                      color: Colors.blue.shade900, width: 2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontFamily: 'source Sans Pro'),
                                ),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              )
            ],
          ),
        ));
  }

  // _selectstartDate(BuildContext context) async {
  //   final DateTime? selected = await showDatePicker(
  //     context: context,
  //     //TODO USER INIT DATE From API
  //     initialDate: StartSelectedDate!,
  //     //he cant make a trip start yesterday
  //     firstDate: DateTime.now(),
  //     lastDate: DateTime(2025),
  //     helpText: "Select when the trip start",
  //     cancelText: "Cancel",
  //     confirmText: "Start of the trip ",
  //     errorFormatText: "Enter A Valid Date",
  //     errorInvalidText: "Date Out Of Range",
  //   );
  //   if (selected != null && selected != StartSelectedDate) {
  //     setState(() {
  //       StartSelectedDate = selected;
  //     });
  //   }
  // }
  //
  // _selectendDate(
  //   BuildContext context,
  // ) async {
  //   final DateTime? eselected = await showDatePicker(
  //       context: context,
  //       initialDate: EndSelectedDate!,
  //       firstDate: DateTime.now(),
  //       lastDate: DateTime(2035),
  //       helpText: "Select when the trip end",
  //       cancelText: "Cancel",
  //       confirmText: "End of the trip ",
  //       errorFormatText: "Enter A Valid Date",
  //       errorInvalidText: "Date Out Of Range");
  //   if (eselected != null && eselected != StartSelectedDate) {
  //     if (eselected.compareTo(StartSelectedDate!).isNegative) {
  //       setState(() {
  //         EndSelectedDate = DateTime.now();
  //       });
  //     } else {
  //       setState(() {
  //         EndSelectedDate = eselected;
  //       });
  //     }
  //   }
  // }
}
