import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trippo/Models/UserModel.dart';
import 'package:http/http.dart' as http;
import 'ChangePassword.dart';
import 'UserProfile.dart';
import '../API/api.dart';

class EditProfile extends StatefulWidget {
  final UserModel userModel;
  const EditProfile({Key? key, required this.userModel}) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController first_nameController = TextEditingController();
  TextEditingController last_nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      first_nameController.text = widget.userModel.FirstName;
      last_nameController.text = widget.userModel.LastName;
      genderController.text = widget.userModel.Gender;
      emailController.text = widget.userModel.Email;
      numberController.text = widget.userModel.PhoneNumber;
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
            content: Text('User information updated successfuly'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Center(child: Text('Ok')))
            ],
          ),
        );
        return responseJson;
    }
  }

  Future editUser() async {
    var url = 'http://192.168.43.164:8000/api/user/edit_userinfo';

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
    request.fields['first_name'] = first_nameController.text;
    request.fields['last_name'] = last_nameController.text;
    request.fields['gender'] = genderController.text;
    request.fields['email'] = emailController.text;
    request.fields['phone'] = numberController.text;

    request.headers.addAll({
      "content-type": "application/json",
      "Authorization": "Bearer ${token}"
    });
    var apiResponse;
    try {
      var res = await request.send();

      apiResponse = _returnResponseStream(res);
    } on SocketException {
      print('No net');

      // throw FetchDataException('No Internet connection');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  Text(
                    'Edit Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    //40
                    height: 30,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Stack(children: [
                            CircleAvatar(
                              radius: 70.0,
                              backgroundColor: Colors.blue.shade900,
                              backgroundImage: _file != null
                                  ? FileImage(_file!) as ImageProvider
                                  : NetworkImage(
                                      'http://192.168.43.164:8000/${widget.userModel.photo}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(105, 80, 0, 0),
                              child: IconButton(
                                  onPressed: () {
                                    getImage();
                                  },
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.blue.shade900,
                                  )),
                            )
                          ]),
                          SizedBox(
                            height: 15,
                          ),
                          Row(children: <Widget>[
                            Text('first name',
                                style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontSize: 20.0,
                                    fontFamily: 'source Sans Pro')),
                            const SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              child: TextFormField(
                                controller: first_nameController,
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
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue.shade900,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue.shade900,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(20),
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
                            Text('last name',
                                style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontSize: 20.0,
                                    fontFamily: 'source Sans Pro')),
                            const SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              child: TextFormField(
                                controller: last_nameController,
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    fillColor: Colors.blue.shade900,
                                    hintText: 'user previous city',
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue.shade900,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue.shade900,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue.shade900,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(20),
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
                            Text('Gender',
                                style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontSize: 20.0,
                                    fontFamily: 'source Sans Pro')),
                            const SizedBox(
                              width: 40,
                            ),
                            Flexible(
                              child: TextFormField(
                                controller: genderController,
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
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue.shade900,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue.shade900,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                              ),
                            ),
                          ]),
                          /* SizedBox(
                             height: 15,
                           ),
                           Row(
                               children: <Widget>[
                                 Text(
                                     'Gender',
                                     style: TextStyle(
                                         color:Colors.blue.shade900,
                                         fontSize: 20.0,
                                         fontFamily: 'source Sans Pro'
                                     )
                                 ),
                                 const SizedBox(
                                   width:45.4,
                                 ),
                                 Flexible(
                                     child:
                                     TextFormField(
                                       decoration:  InputDecoration(
                                         contentPadding:
                                         EdgeInsets.fromLTRB(10, 5, 10, 5),
                                         fillColor: Colors.blue.shade900,
                                         hintText: 'user previous name',
                                         hintStyle: TextStyle(
                                           fontSize: 16,
                                           color: Colors.grey,
                                         ),
                                           enabledBorder: OutlineInputBorder(
                                             borderSide: BorderSide(color: Colors.blue.shade900,width: 2),
                                             borderRadius: BorderRadius.circular(20),
                                           ),
                                           focusedBorder: OutlineInputBorder(
                                             borderSide: BorderSide(color: Colors.blue,width:2),
                                             borderRadius: BorderRadius.circular(20),
                                           ),
                                           focusedErrorBorder: OutlineInputBorder(
                                             borderSide: BorderSide(color: Colors.blue.shade900,width:2),
                                             borderRadius: BorderRadius.circular(20),
                                           ),
                                           errorBorder: OutlineInputBorder(
                                             borderSide: BorderSide(color: Colors.blue.shade900,width:2),
                                             borderRadius: BorderRadius.circular(20),
                                           )
                                       ),
                                     ),
                                   ),
                               ]
                           ),*/
                          SizedBox(
                            height: 15,
                          ),
                          Row(children: <Widget>[
                            Text('Email',
                                style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontSize: 20.0,
                                    fontFamily: 'source Sans Pro')),
                            const SizedBox(
                              width: 59,
                            ),
                            Flexible(
                              child: TextFormField(
                                controller: emailController,
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
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue.shade900,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue.shade900,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(20),
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
                            Text('Number',
                                style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontSize: 20.0,
                                    fontFamily: 'source Sans Pro')),
                            const SizedBox(
                              width: 37.4,
                            ),
                            Flexible(
                              child: TextFormField(
                                controller: numberController,
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
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue.shade900,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue.shade900,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(20),
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
                          /*if (_formKey.currentState!.validate()) {
                                 // Process data.
                               }*/
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChangePassword()));
                            },
                            child: Container(
                              child: Text(
                                'Change Password',
                                style: TextStyle(
                                    color: Colors.blue.shade900,
                                    wordSpacing: 2.0,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    fontFamily: 'source Sans Pro'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              editUser();
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
