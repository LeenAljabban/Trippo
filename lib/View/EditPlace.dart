import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:trippo/Models/placeModel.dart';

import '../API/api.dart';
import '../Models/CountryNameIdModel.dart';

class EditPlace extends StatefulWidget {
  final PlaceModel placeModel;
  const EditPlace({Key? key, required this.placeModel}) : super(key: key);
  @override
  _EditPlaceState createState() => _EditPlaceState();
}

class _EditPlaceState extends State<EditPlace> {
  String? value;
  int? id;
  TextEditingController place_nameController = TextEditingController();
  TextEditingController time_openlController = TextEditingController();
  TextEditingController time_closeController = TextEditingController();
  TextEditingController feesController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController place_priceController = TextEditingController();

  List<CountryNameIdModel> _countries = <CountryNameIdModel>[];

  Future<List<CountryNameIdModel>> _FetchCountries() async {
    var response = await CallApi().getdata('get_country_name_id');

    var countries = <CountryNameIdModel>[];
    var item = json.decode(response.body);

    for (var i in item) {
      countries.add(CountryNameIdModel.fromJson(i));
    }

    return countries;
  }

  @override
  void initState() {
    super.initState();

    _FetchCountries().then((v) {
      setState(() {
        _countries.addAll(v);
      });
    });
    setState(() {
      print(widget.placeModel.place_id);
      id = widget.placeModel.country_id;
      place_nameController.text = widget.placeModel.place_name;
      time_openlController.text = widget.placeModel.time_open;
      time_closeController.text = widget.placeModel.time_close;
      feesController.text = widget.placeModel.fees;
      locationController.text = widget.placeModel.location;
      place_priceController.text = widget.placeModel.place_price.toString();
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

  dynamic _returnResponseStream(http.StreamedResponse response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = 'Success';
        print('responseJson is $responseJson');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text('Place information updated successfuly'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Center(child: Text('Ok')))
            ],
          ),
        );
        return responseJson;
    }
  }

  Future UpdatePlace() async {
    // print(value);
    var url = 'http://192.168.43.164:8000/api/officer/edit_place';
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

    request.fields['place_id'] = widget.placeModel.place_id.toString();
    request.fields['id'] = id.toString();
    request.fields['place_name'] = place_nameController.text;
    request.fields['time_open'] = time_openlController.text;
    request.fields['time_close'] = time_closeController.text;
    request.fields['fees'] = feesController.text;
    request.fields['location'] = locationController.text;
    request.fields['rate'] = 5.toString();
    request.fields['place_price'] = place_priceController.text;
    request.headers.addAll({
      "content-type": "application/json",
      "Authorization": "Bearer ${token}"
    });
    var apiResponse;
    try {
      var res = await request.send();

      apiResponse = _returnResponseStream(res);
      var response = await http.Response.fromStream(res);
      print(response.body);
    } on SocketException {
      print('No net');

      // throw FetchDataException('No Internet connection');
    }
  }

  var isloading = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < _countries.length; i++) {
      print('reach here');
      if (_countries[i].countryId == widget.placeModel.country_id) {
        value = _countries[i].county_name;

        print(value);
        isloading = false;
      }
    }
    return SafeArea(
      child: isloading
          ? Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 20),
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
                color: Colors.blue.shade900,
              ),
            )
          : Scaffold(
              body: SingleChildScrollView(
                child: Stack(children: [
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(120),
                        bottomRight: Radius.circular(120),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      //40
                      horizontal: 40,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context, false),
                              icon: Icon(Icons.arrow_back),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Text(
                              'Edit Place',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          //40
                          height: 40,
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
                                    'http://192.168.43.164:8000/${widget.placeModel.photo}',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                /////////////////////
                                SizedBox(
                                  height: 15,
                                ),
                                Row(children: <Widget>[
                                  Text('Place name',
                                      style: TextStyle(
                                          color: Colors.blue.shade900,
                                          fontSize: 20.0,
                                          fontFamily: 'source Sans Pro')),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Flexible(
                                    child: TextFormField(
                                      controller: place_nameController,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 5, 10, 5),
                                          hintText: 'user previous name',
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
                                                color: Colors.blue, width: 2),
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
                                ]),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(children: <Widget>[
                                  Text('Country',
                                      style: TextStyle(
                                          color: Colors.blue.shade900,
                                          fontSize: 20.0,
                                          fontFamily: 'source Sans Pro')),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Flexible(
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.indigo, width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          value: value,
                                          isExpanded: true,
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.blue.shade900,
                                          ),
                                          iconSize: 30,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          items: _countries.map((itemsname) {
                                            return DropdownMenuItem(
                                              value: itemsname.county_name,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Text(
                                                  itemsname.county_name,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (String? newVal) {
                                            setState(() {
                                              value = newVal;
                                              for (int i = 0;
                                                  i < _countries.length;
                                                  i++) {
                                                if (_countries[i].county_name ==
                                                    value)
                                                  id = _countries[i].countryId;
                                                print(id);
                                                print('kkk');
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(children: <Widget>[
                                  Text('Time open',
                                      style: TextStyle(
                                          color: Colors.blue.shade900,
                                          fontSize: 20.0,
                                          fontFamily: 'source Sans Pro')),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  Flexible(
                                    child: TextFormField(
                                      controller: time_openlController,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 5, 10, 5),
                                          fillColor: Colors.blue.shade900,
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
                                                color: Colors.blue, width: 2),
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
                                    ),
                                  ),
                                ]),

                                SizedBox(
                                  height: 15,
                                ),
                                Row(children: <Widget>[
                                  Text('Time close',
                                      style: TextStyle(
                                          color: Colors.blue.shade900,
                                          fontSize: 20.0,
                                          fontFamily: 'source Sans Pro')),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  Flexible(
                                    child: TextFormField(
                                      controller: time_closeController,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 5, 10, 5),
                                          fillColor: Colors.blue.shade900,
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
                                                color: Colors.blue, width: 2),
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
                                        if (!RegExp(
                                                "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                            .hasMatch(value)) {
                                          return 'Please just enter Email';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ]),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(children: <Widget>[
                                  Text('Location',
                                      style: TextStyle(
                                          color: Colors.blue.shade900,
                                          fontSize: 20.0,
                                          fontFamily: 'source Sans Pro')),
                                  const SizedBox(
                                    width: 45,
                                  ),
                                  Flexible(
                                    child: TextFormField(
                                      controller: locationController,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 5, 10, 5),
                                          fillColor: Colors.blue.shade900,
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
                                                color: Colors.blue, width: 2),
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
                                ]),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(children: <Widget>[
                                  Text('Fees',
                                      style: TextStyle(
                                          color: Colors.blue.shade900,
                                          fontSize: 20.0,
                                          fontFamily: 'source Sans Pro')),
                                  const SizedBox(
                                    width: 80,
                                  ),
                                  Flexible(
                                    child: TextFormField(
                                      controller: feesController,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 5, 10, 5),
                                          fillColor: Colors.blue.shade900,
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
                                                color: Colors.blue, width: 2),
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
                                ]),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(children: <Widget>[
                                  Text('price',
                                      style: TextStyle(
                                          color: Colors.blue.shade900,
                                          fontSize: 20.0,
                                          fontFamily: 'source Sans Pro')),
                                  const SizedBox(
                                    width: 80,
                                  ),
                                  Flexible(
                                    child: TextFormField(
                                      controller: place_priceController,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 5, 10, 5),
                                          fillColor: Colors.blue.shade900,
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
                                                color: Colors.blue, width: 2),
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
                                ]),
                                SizedBox(
                                  height: 25,
                                ),

                                InkWell(
                                  onTap: () {
                                    UpdatePlace();
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 100,
                                    margin: const EdgeInsets.only(
                                        left: 0, top: 0, right: 0, bottom: 0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade900,
                                      border: Border.all(
                                          color: Colors.blue.shade900,
                                          width: 2),
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
                              ]),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
    );
  }
}
