import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trippo/Models/PlacesNameIdModel.dart';
import 'package:trippo/Models/TripModel.dart';

import '../API/api.dart';

class AddTrip extends StatefulWidget {
  @override
  _AddTripState createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {
  @override
  void initState() {
    _FetchPlaces().then((value) {
      _places.addAll(value);
      // for (int y = 0; y < _places.length; y++) {
      //   print(_places.length);
      // }
    });

    super.initState();
  }

  List<PlacesNameIdModel> _places = <PlacesNameIdModel>[];
  Future<List<PlacesNameIdModel>> _FetchPlaces() async {
    var response = await CallApi().getdata('officer/get_all_places');
    //print(response);
    var places = <PlacesNameIdModel>[];

    var item = json.decode(response.body);

    for (var i in item) {
      places.add(PlacesNameIdModel.fromJson(i));
    }

    return places;
  }

  List<DynamicWidget> list = [];
  List<int> pricesList = [];
  List<int> placesList = [];
  List<Map<String, dynamic>> SaveData = [];

  void _addDynamic() {
    var item = new Map<String, dynamic>();
    SaveData.add(item);
    //print("longth ${SaveData.length}");
    list.add(DynamicWidget(SaveData.last, _places));

    setState(() {});
  }

  File? _file;
  String? fileName;
  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    setState(() {
      _file = File(image.path);
    });
  }

  TextEditingController trip_nameController = TextEditingController();
  TextEditingController trip_startController = TextEditingController();
  TextEditingController trip_endController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController trip_planeController = TextEditingController();
  TextEditingController trip_statusController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController available_num_passengerController =
      TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  String url = "http://192.168.43.164:8000/api/officer/add_trip";
  dynamic _returnResponseStream(http.StreamedResponse response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = 'Success';
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Center(
                child: Text(
              'Trip Added Successfully',
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

  Future uploadData() async {
    print(SaveData);
    SaveData.forEach((element) {
      placesList.add(element['Placename']);
      // print(placesList);
      pricesList.add(int.parse(element['price']));
      // print(pricesList);
    });
    // for (int i = 0; i < pricesList.length; i++) {
    //   print(pricesList[i]);
    // }
    //
    // for (int i = 0; i < placesList.length; i++) {
    //   print(placesList[i]);
    // }
    TripModel tripModel = new TripModel(
      trip_nameController.text,
      trip_startController.text,
      trip_endController.text,
      int.parse(durationController.text),
      trip_planeController.text,
      trip_statusController.text,
      int.parse(priceController.text),
      0,
      int.parse(available_num_passengerController.text),
      noteController.text,
      _file!,
      discountController.text,
    );
    var token = await getFromSharedPreferences('token');
    var request = http.MultipartRequest('POST', Uri.parse(url));
    debugPrint('the image is ${tripModel.userfile}');
    if ('${tripModel.userfile}' != 'null') {
      request.files.add(http.MultipartFile(
          'photo',
          File(tripModel.userfile.path).readAsBytes().asStream(),
          File(tripModel.userfile.path).lengthSync(),
          filename: tripModel.userfile.path.split("/").last));
    }
    request.fields['trip_name'] = tripModel.trip_name;
    request.fields['trip_start'] = tripModel.trip_start;
    request.fields['trip_end'] = tripModel.trip_end;
    request.fields['duration'] = tripModel.duration.toString();
    // request.fields['price'] = 500.toString();

    request.fields['trip_plane'] = tripModel.trip_plane;
    request.fields['trip_status'] = tripModel.trip_status;
    request.fields['note'] = tripModel.note;
    request.fields['total_trip_price'] = tripModel.total_trip_price.toString();
    request.fields['available_num_passenger'] =
        tripModel.available_num_passenger.toString();
    request.fields['discounts'] = tripModel.dicounts.toString();
    for (int i in placesList) {
      request.files
          .add(http.MultipartFile.fromString('place_id[]', i.toString()));
    }
    for (int j in pricesList) {
      request.files.add(
          http.MultipartFile.fromString('place_trip_price[]', j.toString()));
    }
    // for (int i in placesList) {
    //   request.fields['place_id[]'] = i.toString();
    // }
    // for (int j in pricesList) {
    //   request.fields['place_trip_price[]'] = j.toString();
    // }
////////////////////////////////////////////

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
      print('jjjjlllllllllllll');
      apiResponse = _returnResponseStream(res);
    } on SocketException {
      print('No net');

      // throw FetchDataException('No Internet connection');
    }
  }

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                horizontal: 29,
                vertical: 40,
              ),
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    Text(
                      'Add Trip',
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
                          return 'Please enter Trip name';
                        }

                        return null;
                      },
                      controller: trip_nameController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 13.0, horizontal: 15.0),
                        border: OutlineInputBorder(),
                        hintText: 'Enter Trip name',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
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
                          borderSide: BorderSide(width: 2, color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Colors.indigo),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 2, color: Colors.indigo),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(children: [
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Start date';
                            }

                            return null;
                          },
                          controller: trip_startController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 13.0, horizontal: 15.0),
                            border: OutlineInputBorder(),
                            hintText: 'Trip Start',
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
                        width: 5,
                      ),
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter End date';
                            }

                            return null;
                          },
                          controller: trip_endController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 13.0, horizontal: 15.0),
                            border: OutlineInputBorder(),
                            hintText: 'Trip End',
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
                          return 'Please enter the duration';
                        }

                        return null;
                      },
                      controller: durationController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 13.0, horizontal: 15.0),
                        border: OutlineInputBorder(),
                        hintText: 'Enter Trip Duration',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
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
                          borderSide: BorderSide(width: 2, color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Colors.indigo),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 2, color: Colors.indigo),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Trip Statuas';
                        }

                        return null;
                      },
                      controller: trip_statusController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 13.0, horizontal: 15.0),
                        border: OutlineInputBorder(),
                        hintText: 'Enter Trip Statuas',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
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
                          borderSide: BorderSide(width: 2, color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Colors.indigo),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 2, color: Colors.indigo),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Trip Price';
                        }

                        return null;
                      },
                      controller: priceController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 13.0, horizontal: 15.0),
                        border: OutlineInputBorder(),
                        hintText: 'Enter Trip Price',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
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
                          borderSide: BorderSide(width: 2, color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Colors.indigo),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 2, color: Colors.indigo),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 13,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Trip Plan';
                        }

                        return null;
                      },
                      controller: trip_planeController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 13.0, horizontal: 15.0),
                        border: OutlineInputBorder(),
                        hintText: 'Enter Trip Plan',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
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
                          borderSide: BorderSide(width: 2, color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Colors.indigo),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 2, color: Colors.indigo),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 8,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Notes';
                        }

                        return null;
                      },
                      controller: noteController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 13.0, horizontal: 15.0),
                        border: OutlineInputBorder(),
                        hintText: 'Enter Trip Notes',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
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
                          borderSide: BorderSide(width: 2, color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Colors.indigo),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 2, color: Colors.indigo),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter num of passengers';
                        }

                        return null;
                      },
                      controller: available_num_passengerController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 13.0, horizontal: 15.0),
                        border: OutlineInputBorder(),
                        hintText: 'Enter Available Passengers num',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
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
                          borderSide: BorderSide(width: 2, color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Colors.indigo),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 2, color: Colors.indigo),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter discounts';
                        }

                        return null;
                      },
                      controller: discountController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 13.0, horizontal: 15.0),
                        border: OutlineInputBorder(),
                        hintText: 'Enter discount',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
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
                          borderSide: BorderSide(width: 2, color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Colors.indigo),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 2, color: Colors.indigo),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            'Add Places',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.blue.shade900,
                              borderRadius: BorderRadius.circular(50)),
                          child: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: _addDynamic,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (_, index) => list[index],
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 20,
                        );
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
                          // print(SaveData);
                          if (_key.currentState!.validate()) {
                            uploadData();
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
            ),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////
class DynamicWidget extends StatefulWidget {
  @override
  var places;
  var itemModel;
  DynamicWidget(this.itemModel, this.places);
  State<DynamicWidget> createState() => _DynamicWidgetState();
}

class _DynamicWidgetState extends State<DynamicWidget> {
  //TextEditingController controller = new TextEditingController();

  String? value;
  int? id;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
        Container(
          height: 50,
          width: 180,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.indigo, width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: value,
              isExpanded: true,
              hint: Text(
                'Select Place',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.blue.shade900,
              ),
              iconSize: 30,
              borderRadius: BorderRadius.circular(8),
              items: widget.places.map<DropdownMenuItem<String>>((itemsname) {
                return DropdownMenuItem<String>(
                  value: itemsname.place_name,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      itemsname.place_name,
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
                  for (int i = 0; i < widget.places.length; i++) {
                    if (widget.places[i].place_name == value)
                      id = widget.places[i].id;
                    widget.itemModel["Placename"] = id;
                  }
                });
              },
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Container(
            height: 50,
            child: TextField(
              // controller: controller,
              onChanged: (value) {
                widget.itemModel["price"] = value;
              },
              decoration: InputDecoration(
                // border: OutlineInputBorder(),
                hintText: 'price',
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
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
