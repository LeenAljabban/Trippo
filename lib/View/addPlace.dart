import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:trippo/API/api.dart';
import 'package:trippo/Models/CountryNameIdModel.dart';
import 'package:trippo/Models/placeModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Models/homeModel.dart';

class AddPlace extends StatefulWidget {
  @override
  _AddPlaceState createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController place_nameController = TextEditingController();
  TextEditingController time_openlController = TextEditingController();
  TextEditingController time_closeController = TextEditingController();
  TextEditingController feesController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController place_priceController = TextEditingController();

  File? _file;

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    setState(() {
      _file = File(image.path);
    });
  }

  String url = "http://192.168.43.164:8000/api/officer/add_place";
  dynamic _returnResponseStream(http.StreamedResponse response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = 'Success';
        print('responseJson is $responseJson');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Center(
                child: Text(
              'Place Added Successfully',
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
        return responseJson;
      case 201:
        var responseJson = 'Success';
        print('responseJson is $responseJson');
        return responseJson;
      case 404:
        var responseJson = 'fail';
        print('responseJson is $responseJson');
        return responseJson;
      default:
        print('errrorr');
    }
  }

  Future uploadImage(url) async {
    print(value);
    PlaceModel placeModel = new PlaceModel(
      place_nameController.text,
      time_openlController.text,
      time_closeController.text,
      feesController.text,
      locationController.text,
      5,
      _file!,
      int.parse(place_priceController.text),
    );
    var token = await getFromSharedPreferences('token');
    // http.use_s؟sl = true;
    var request = http.MultipartRequest('POST', Uri.parse(url));
    debugPrint('the image is ${placeModel.userfile}');
    if ('${placeModel.userfile}' != 'null') {
      request.files.add(http.MultipartFile(
          'photo',
          File(placeModel.userfile.path).readAsBytes().asStream(),
          File(placeModel.userfile.path).lengthSync(),
          filename: placeModel.userfile.path.split("/").last));
    }
    request.fields['id'] = id.toString();
    request.fields['place_name'] = placeModel.place_name;
    request.fields['time_open'] = placeModel.time_open;
    request.fields['time_close'] = placeModel.time_close;
    request.fields['fees'] = placeModel.fees;
    request.fields['location'] = placeModel.location;
    request.fields['rate'] = placeModel.rate.toString();
    request.fields['place_price'] = placeModel.place_price.toString();
    request.headers.addAll(
        {"Accept": "application/json", "Authorization": "Bearer ${token}"});
    var apiResponse;
    try {
      var res = await request.send();
      var response = await http.Response.fromStream(res);
      print(response.body);
      apiResponse = _returnResponseStream(res);
    } on SocketException {
      print('No net');
    }
  }

  List<CountryNameIdModel> _countries = <CountryNameIdModel>[];

  @override
  void initState() {
    _FetchCountries().then((value) {
      setState(() {
        _countries.addAll(value);
      });
    });
    super.initState();
  }

  Future<List<CountryNameIdModel>> _FetchCountries() async {
    var response = await CallApi().getdata('get_country_name_id');

    var countries = <CountryNameIdModel>[];
    var item = json.decode(response.body);

    for (var i in item) {
      countries.add(CountryNameIdModel.fromJson(i));
    }

    return countries;
  }

  String? value;

  int? id;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: 100,
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
                  horizontal: 40,
                  vertical: 40,
                ),
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      Text(
                        'Add Place',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter place name';
                          }

                          return null;
                        },
                        controller: place_nameController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 15.0),
                          // border: OutlineInputBorder(),
                          hintText: 'Enter Place name',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 20),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.indigo),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blue),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.indigo),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 2, color: Colors.indigo),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 2.0),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.indigo),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.blue),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.indigo),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.indigo),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select country';
                            }

                            return null;
                          },
                          value: value,
                          isExpanded: true,
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(
                              'Select Country',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.blue.shade900,
                          ),
                          iconSize: 30,
                          borderRadius: BorderRadius.circular(8),
                          items: _countries.map((itemsname) {
                            return DropdownMenuItem(
                              value: itemsname.county_name,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  itemsname.county_name,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (newVal) {
                            setState(() {
                              value = newVal as String?;
                              for (int i = 0; i < _countries.length; i++) {
                                if (_countries[i].county_name == value)
                                  id = _countries[i].countryId;
                                print(id);
                              }
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(children: [
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Open time';
                              }

                              return null;
                            },
                            controller: time_openlController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 15.0),
                              border: OutlineInputBorder(),
                              hintText: 'Time Open',
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 20),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Colors.indigo,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.blue),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.indigo),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.indigo),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter close Time';
                              }

                              return null;
                            },
                            controller: time_closeController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 15.0),
                              border: OutlineInputBorder(),
                              hintText: 'Time Close',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Colors.indigo,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.blue),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.indigo),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.indigo),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter place Location';
                          }

                          return null;
                        },
                        controller: locationController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 15.0),
                          border: OutlineInputBorder(),
                          hintText: 'Enter Place Location',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.indigo,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blue),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.indigo),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 2, color: Colors.indigo),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Fees';
                          }

                          return null;
                        },
                        controller: feesController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 15.0),
                          border: OutlineInputBorder(),
                          hintText: 'Enter Fees',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 20),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.indigo,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blue),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.indigo),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 2, color: Colors.indigo),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter place price';
                          }

                          return null;
                        },
                        controller: place_priceController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 15.0),
                          border: OutlineInputBorder(),
                          hintText: 'Enter Price',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 20),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.indigo,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blue),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.indigo),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 2, color: Colors.indigo),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // Container(
                      //   height: 50,
                      //   child: TextField(
                      //     decoration: InputDecoration(
                      //       border: OutlineInputBorder(),
                      //       hintText: 'Choose Image',
                      //       icon: Icon(
                      //         Icons.add_a_photo_outlined,
                      //         color: Colors.grey,
                      //       ),
                      //       hintStyle: TextStyle(color: Colors.grey),
                      //       filled: true,
                      //       fillColor: Colors.white,
                      //       enabledBorder: OutlineInputBorder(
                      //         borderSide: const BorderSide(
                      //           width: 2,
                      //           color: Colors.indigo,
                      //         ),
                      //         borderRadius: BorderRadius.circular(15),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      InkWell(
                        onTap: getImage,
                        child: Container(
                          width: 320,
                          height: 275,
                          decoration: BoxDecoration(
                            color: const Color(0xffE6E6E6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: _file != null
                              ? Image.file(
                                  _file!,
                                  fit: BoxFit.cover,
                                )
                              : Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/plus.svg',
                                      ),
                                      const Text(
                                        'upload photo',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade900,
                            borderRadius: BorderRadius.circular(50)),
                        child: FlatButton(
                          child: Text(
                            'Add',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            //  _Add();
                            if (_key.currentState!.validate()) {
                              uploadImage(
                                url,
                              );
                              return;
                            } else {
                              print("unsuccessful");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
