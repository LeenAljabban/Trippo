// import 'dart:convert';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import 'package:flutter/foundation.dart';
//
// class Registerl extends StatefulWidget {
//   @override
//   _RegisterlState createState() => _RegisterlState();
// }
//
// class _RegisterlState extends State<Registerl> {
//   final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formkey,
//           child: Padding(
//             padding: EdgeInsets.zero,
//             //EdgeInsets.only(bottom: 120),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               //crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Text(
//                   //TODO update this
//                   'Join Tripo App!',
//                   style: TextStyle(
//                     fontSize: 19.0,
//                     color: Colors.blue.shade900,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Stack(children: [
//                   CircleAvatar(
//                     radius: 50.0,
//                     backgroundColor: Colors.blue.shade900,
//                     backgroundImage: AssetImage('assets/profile.png'),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(60, 60, 0, 0),
//                     child: IconButton(
//                         onPressed: () {
//                           //TODO CHANGE IMAGE
//                         },
//                         icon: Icon(
//                           Icons.camera_alt,
//                           color: Colors.blueGrey,
//                         )),
//                   )
//                 ]),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
//                   child: TextFormField(
//                     // textAlign: TextAlign.end,
//
//                     //  autofillHints: TextInputType.emailAddress,
//                     decoration: InputDecoration(
//                       contentPadding:
//                           EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                       filled: true,
//                       fillColor: Colors.white,
//                       hintText: 'Fisrt Name',
//                       hintStyle: TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey.shade600,
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         borderSide:
//                             BorderSide(color: Colors.blue.shade900, width: 2),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         borderSide: BorderSide(color: Colors.blue, width: 2),
//                       ),
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         borderSide:
//                             BorderSide(color: Colors.blue.shade900, width: 2),
//                       ),
//                       focusedErrorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         borderSide: BorderSide(color: Colors.red, width: 2),
//                       ),
//                       prefixIcon: Icon(
//                         Icons.account_circle_rounded,
//                         size: 20,
//                         color: Colors.grey.shade600,
//                       ),
//                     ),
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.black,
//                     ),
//
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your email';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 SizedBox(
//                   height: 16,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
//                   child: TextFormField(
//                     // textAlign: TextAlign.end,
//
//                     //  autofillHints: TextInputType.emailAddress,
//                     decoration: InputDecoration(
//                       contentPadding:
//                           EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                       filled: true,
//                       fillColor: Colors.white,
//                       hintText: 'Last Name',
//                       hintStyle: TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey.shade600,
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         borderSide:
//                             BorderSide(color: Colors.blue.shade900, width: 2),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         borderSide: BorderSide(color: Colors.blue, width: 2),
//                       ),
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         borderSide:
//                             BorderSide(color: Colors.blue.shade900, width: 2),
//                       ),
//                       focusedErrorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         borderSide: BorderSide(color: Colors.red, width: 2),
//                       ),
//                       prefixIcon: Icon(
//                         Icons.account_circle_rounded,
//                         size: 20,
//                         color: Colors.grey.shade600,
//                       ),
//                     ),
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.black,
//                     ),
//
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your email';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 SizedBox(
//                   height: 16,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       contentPadding:
//                           EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                       filled: true,
//                       fillColor: Colors.white,
//                       hintText: 'Email',
//                       hintStyle: TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey.shade600,
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         borderSide:
//                             BorderSide(color: Colors.blue.shade900, width: 2),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         borderSide: BorderSide(color: Colors.blue, width: 2),
//                       ),
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         borderSide:
//                             BorderSide(color: Colors.blue.shade900, width: 2),
//                       ),
//                       focusedErrorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         borderSide: BorderSide(color: Colors.red, width: 2),
//                       ),
//                       prefixIcon: Icon(
//                         Icons.email,
//                         size: 20,
//                         color: Colors.grey.shade600,
//                       ),
//                     ),
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.black,
//                     ),
//                     validator: (value) {
//                       //TODO
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your email';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 SizedBox(
//                   height: 16,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       contentPadding:
//                           EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                       filled: true,
//                       fillColor: Colors.white,
//                       hintText: 'Phone Number',
//                       hintStyle: TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey.shade600,
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         borderSide:
//                             BorderSide(color: Colors.blue.shade900, width: 2),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         borderSide: BorderSide(color: Colors.blue, width: 2),
//                       ),
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         borderSide:
//                             BorderSide(color: Colors.blue.shade900, width: 2),
//                       ),
//                       focusedErrorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         borderSide: BorderSide(color: Colors.red, width: 2),
//                       ),
//                       prefixIcon: Icon(
//                         Icons.phone,
//                         size: 20,
//                         color: Colors.grey.shade600,
//                       ),
//                     ),
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.black,
//                     ),
//                     validator: (value) {
//                       //TODO
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your email';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 SizedBox(
//                   height: 16,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       contentPadding:
//                           EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                       filled: true,
//                       fillColor: Colors.white,
//                       hintText: 'Gender',
//                       hintStyle: TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey.shade600,
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         borderSide:
//                             BorderSide(color: Colors.blue.shade900, width: 2),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         borderSide: BorderSide(color: Colors.blue, width: 2),
//                       ),
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         borderSide:
//                             BorderSide(color: Colors.blue.shade900, width: 2),
//                       ),
//                       focusedErrorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         borderSide: BorderSide(color: Colors.red, width: 2),
//                       ),
//                       prefixIcon: Icon(
//                         Icons.transgender_sharp,
//                         size: 20,
//                         color: Colors.grey.shade600,
//                       ),
//                     ),
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.black,
//                     ),
//                     validator: (value) {
//                       //TODO
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your phone number';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 SizedBox(
//                   height: 16,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
//                   child: TextFormField(
//                     //   textAlign: TextAlign.center,
//
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Colors.white,
//                       contentPadding:
//                           EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                       hintText: 'Password',
//                       hintStyle: TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey.shade600,
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         borderSide:
//                             BorderSide(color: Colors.blue.shade900, width: 2),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         borderSide: BorderSide(color: Colors.blue, width: 2),
//                       ),
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         borderSide:
//                             BorderSide(color: Colors.blue.shade900, width: 2),
//                       ),
//                       focusedErrorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         borderSide: BorderSide(color: Colors.red, width: 2),
//                       ),
//                       prefixIcon: Icon(
//                         Icons.vpn_key,
//                         color: Colors.grey.shade600,
//                         size: 20,
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter some text';
//                       }
//                       // if (value.length < 6) {
//                       //   return 'password must be at least 6 characters';
//                       // }
//                       return null;
//                     },
//                     // onSaved: ,
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 16,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       contentPadding:
//                           EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                       filled: true,
//                       fillColor: Colors.white,
//                       hintText: 'Confirm Password',
//                       hintStyle: TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey.shade600,
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         borderSide:
//                             BorderSide(color: Colors.blue.shade900, width: 2),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         borderSide: BorderSide(color: Colors.blue, width: 2),
//                       ),
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         borderSide:
//                             BorderSide(color: Colors.blue.shade900, width: 2),
//                       ),
//                       focusedErrorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50),
//                         borderSide: BorderSide(color: Colors.red, width: 2),
//                       ),
//                       prefixIcon: Icon(
//                         Icons.vpn_key,
//                         size: 20,
//                         color: Colors.grey.shade600,
//                       ),
//                     ),
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.black,
//                     ),
//                     validator: (value) {
//                       //TODO
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your email';
//                       }
//                       /* if(password.text!=confirmpassword.text)
//                                     {
//                                       return "password does not match";
//                                     }*/
//                       return null;
//                     },
//                   ),
//                 ),
//                 Container(
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: Colors.blue.shade900,
//                     borderRadius: BorderRadius.circular(50),
//                     boxShadow: [
//                       BoxShadow(color: Colors.blue.shade900, spreadRadius: 2),
//                     ],
//                   ),
//                   margin: EdgeInsets.fromLTRB(150, 10, 150, 10),
//                   child: Center(
//                     child: FlatButton(
//                       child: Text(
//                         'Register',
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.white,
//                         ),
//                       ),
//                       onPressed: () {
//                         if (_formkey.currentState!.validate()) {
//                           return;
//                         } else {
//                           print("unsuccessful");
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   height: 50,
//                   decoration:
//                       BoxDecoration(borderRadius: BorderRadius.circular(50)),
//                   margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
//                   child: Center(
//                       child: Text(
//                     "Already have an account",
//                     style: TextStyle(fontSize: 16, color: Colors.blue.shade900),
//                   )),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     /*Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => Login()),
//                     );*/
//                   },
//                   child: Container(
//                     height: 30,
//                     decoration:
//                         BoxDecoration(borderRadius: BorderRadius.circular(50)),
//                     margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
//                     child: Center(
//                         child: Text(
//                       "Login",
//                       style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.blue.shade900,
//                           fontWeight: FontWeight.w600),
//                     )),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
