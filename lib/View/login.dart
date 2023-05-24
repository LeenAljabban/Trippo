import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trippo/View/Country.dart';

import 'package:trippo/API/api.dart';
import 'package:trippo/View/home.dart';
import 'package:trippo/Models/loginModel.dart';
import 'package:trippo/View/User_Register.dart';
import 'User_Type.dart';
import 'officerDashboard.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String? fcm;
  void initState() {
    FirebaseMessaging.instance.getToken().then((value) {
      fcm = value;
      print(fcm);
    });
    super.initState();
  }

  Future _Login() async {
    loginModel loginmodel =
        new loginModel(EmailController.text, PasswordController.text
            // , fcm!
            );

    var response = await CallApi().postdata(loginmodel.toJson(), 'login');
    var body = json.decode(response.body);
    // print(body);

    if (body['success']) {
      saveToSharedPreferences('token', body['token']);
      if (body['role'] == "user") {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      } else if (body['role'] == "officer") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => OfficerDashBoard()));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invalid email or password')));
    }
  }

  // showMsg(msg) {
  //   final snackbar = SnackBar(
  //     content: Text(msg),
  //     action: SnackBarAction(
  //       label: 'Close',
  //       onPressed: () {
  //         //some
  //       },
  //     ),
  //   );
  //   Scaffold.of(context).showSnackBar(snackbar);
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Image.asset(
            //TODO update this

            'assets/img_5.png',
            // color: Colors.blue.withOpacity(0.7),
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
            //color: const Color.fromRGBO(255, 255, 255, 1.9),
            colorBlendMode: BlendMode.modulate,
          ),
          Form(
            key: _formkey,
            child: Padding(
              padding: EdgeInsets.only(bottom: 120),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    //TODO update this
                    'Join Tripo App!',
                    style: TextStyle(
                      fontSize: 19.0,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextFormField(
                      // textAlign: TextAlign.end,

                      //  autofillHints: TextInputType.emailAddress,
                      controller: EmailController,

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
                          borderSide:
                              BorderSide(color: Colors.blue.shade900, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide:
                              BorderSide(color: Colors.blue.shade900, width: 2),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide:
                              BorderSide(color: Colors.blue.shade900, width: 2),
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
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9]+.[a-z]")
                            .hasMatch(value)) {
                          return 'please enter valid email';
                        }
                        // EmailValidator.validate(value)
                        //     ? null
                        //     : "Please enter a valid email";

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
                      //   textAlign: TextAlign.center,
                      controller: PasswordController,
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
                          borderSide:
                              BorderSide(color: Colors.blue.shade900, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide:
                              BorderSide(color: Colors.blue.shade900, width: 2),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide:
                              BorderSide(color: Colors.blue.shade900, width: 2),
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
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade900,
                        borderRadius: BorderRadius.circular(50)),
                    margin: EdgeInsets.fromLTRB(150, 10, 150, 10),
                    child: Center(
                      child: FlatButton(
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            _Login();
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
                    height: 50,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Center(
                        child: Text(
                      "Don't have an account",
                      style:
                          TextStyle(fontSize: 16, color: Colors.blue.shade900),
                    )),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WhoAreYouPage()),
                      );
                    },
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50)),
                      margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Center(
                          child: Text(
                        "Create account",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue.shade900,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
