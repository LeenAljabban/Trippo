import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trippo/Models/UserModel.dart';
import 'package:trippo/View/login.dart';
import 'package:http/http.dart' as http;
import '../API/api.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController first_nameController = TextEditingController();
  TextEditingController last_nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  File? _file;
  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    setState(() {
      _file = File(image.path);
    });
  }

  String url = "http://192.168.43.164:8000/api/register";
  dynamic _returnResponseStream(http.StreamedResponse response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = 'Success';
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
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

  Future _Register() async {
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
    request.fields['email'] = emailController.text;
    request.fields['password'] = passwordController.text;
    request.fields['password_confirmation'] = passwordConfController.text;
    request.fields['phone'] = numberController.text;
    request.fields['gender'] = genderController.text;
    request.fields['location'] = locationController.text;
    request.headers.addAll({
      "content-type": "application/json",
      "Authorization": "Bearer ${token}"
    });
    var apiResponse;
    try {
      var res = await request.send();
      var response = await http.Response.fromStream(res);
      print(response.body + 'mmmm');
      apiResponse = _returnResponseStream(res);
    } on SocketException {
      print('No net');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: 1060,
              child: Image.asset(
                //TODO update this

                'assets/img_5.png',
                // color: Colors.blue.withOpacity(0.7),
                fit: BoxFit.cover,
                // height: double.infinity,
                // width: double.infinity,
                //color: const Color.fromRGBO(255, 255, 255, 1.9),
                colorBlendMode: BlendMode.modulate,
              ),
            ),
            Form(
              key: _key,
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      //TODO update this
                      'User Registeration',
                      style: TextStyle(
                        fontSize: 19.0,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Stack(children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.blue.shade900,
                        backgroundImage: _file != null
                            ? FileImage(_file!) as ImageProvider
                            : AssetImage(
                                'assets/img_4.png',
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(60, 60, 0, 0),
                        child: IconButton(
                            onPressed: () {
                              getImage();
                            },
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.blueGrey,
                            )),
                      )
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: TextFormField(
                        // textAlign: TextAlign.end,
                        controller: first_nameController,
                        //  autofillHints: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Fisrt Name',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: Colors.blue.shade900, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: Colors.blue.shade900, width: 2),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: Colors.blue.shade900, width: 2),
                          ),
                          prefixIcon: Icon(
                            Icons.account_circle_rounded,
                            size: 20,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: TextFormField(
                        // textAlign: TextAlign.end,
                        controller: last_nameController,
                        //  autofillHints: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Last Name',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: Colors.blue.shade900, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: Colors.blue.shade900, width: 2),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: Colors.blue.shade900, width: 2),
                          ),
                          prefixIcon: Icon(
                            Icons.account_circle_rounded,
                            size: 20,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: Colors.blue.shade900, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: Colors.blue.shade900, width: 2),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: Colors.blue.shade900, width: 2),
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                            size: 20,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        validator: (value) {
                          //TODO
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: TextFormField(
                        controller: numberController,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: Colors.blue.shade900, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: Colors.blue.shade900, width: 2),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: Colors.blue.shade900, width: 2),
                          ),
                          prefixIcon: Icon(
                            Icons.phone,
                            size: 20,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        validator: (value) {
                          //TODO
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: TextFormField(
                        controller: genderController,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Gender',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: Colors.blue.shade900, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: Colors.blue.shade900, width: 2),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: Colors.blue.shade900, width: 2),
                          ),
                          prefixIcon: Icon(
                            Icons.transgender_sharp,
                            size: 20,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        validator: (value) {
                          //TODO
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: TextFormField(
                        controller: locationController,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Location',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: Colors.blue.shade900, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: Colors.blue.shade900, width: 2),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: Colors.blue.shade900, width: 2),
                          ),
                          prefixIcon: Icon(
                            Icons.location_on,
                            size: 20,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        validator: (value) {
                          //TODO
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: TextFormField(
                        controller: passwordController,
                        //   textAlign: TextAlign.center,

                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: Colors.blue.shade900, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: Colors.blue.shade900, width: 2),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: Colors.blue.shade900, width: 2),
                          ),
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: Colors.grey.shade600,
                            size: 20,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          // if (value.length < 6) {
                          //   return 'password must be at least 6 characters';
                          // }
                          return null;
                        },
                        // onSaved: ,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: TextFormField(
                        controller: passwordConfController,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: Colors.blue.shade900, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: Colors.blue.shade900, width: 2),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: Colors.blue.shade900, width: 2),
                          ),
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            size: 20,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        validator: (value) {
                          //TODO
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          /* if(password.text!=confirmpassword.text)
                                        {
                                          return "password does not match";
                                        }*/
                          return null;
                        },
                      ),
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade900,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blue.shade900, spreadRadius: 2),
                        ],
                      ),
                      margin: EdgeInsets.fromLTRB(150, 20, 150, 10),
                      child: Center(
                        child: FlatButton(
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              _Register();
                              return;
                            } else {
                              print("unsuccessful");
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50)),
                      margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Center(
                          child: Text(
                        "Already have an account",
                        style: TextStyle(
                            fontSize: 16, color: Colors.blue.shade900),
                      )),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50)),
                        margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Center(
                            child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue.shade900,
                              fontWeight: FontWeight.w600),
                        )),
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
