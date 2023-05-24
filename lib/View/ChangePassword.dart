import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../API/api.dart';

class ChangePassword extends StatefulWidget {
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController old_passwordController = TextEditingController();
  TextEditingController new_passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  Future _ChangeMyPassword() async {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['old_password'] = old_passwordController.text;
    data['new_password'] = new_passwordController.text;
    data['new_password_confirmation'] = confirmController.text;

    var response = await CallApi().postdata(data, 'user/changepassword');
    var body = json.decode(response.body);

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text('Password Changed successfuly'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Center(child: Text('Ok')))
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(body['message']),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Center(child: Text('Ok')))
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Edit Password'),
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
                onPressed: () => Navigator.pop(context)),
          )),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    //40
                    height: 50,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Row(children: <Widget>[
                            Text('previous password',
                                style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontSize: 20.0,
                                    fontFamily: 'source Sans Pro')),
                            const SizedBox(
                              width: 12,
                            ),
                            Flexible(
                              child: TextFormField(
                                controller: old_passwordController,
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    hintText: 'user previous password',
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
                                    //TODO CHECK THE PREVIOUS PASSWORD TRUE
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ]),
                          SizedBox(
                            height: 30,
                          ),
                          Row(children: <Widget>[
                            Text('new password',
                                style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontSize: 20.0,
                                    fontFamily: 'source Sans Pro')),
                            const SizedBox(
                              width: 50,
                            ),
                            Flexible(
                              child: TextFormField(
                                controller: new_passwordController,
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    hintText: 'user new password',
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
                            height: 30,
                          ),
                          Row(children: <Widget>[
                            Text('confirm password',
                                style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontSize: 20.0,
                                    fontFamily: 'source Sans Pro')),
                            const SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              child: TextFormField(
                                controller: confirmController,
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    hintText: 'user password confirmation',
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
                                  /* if(password.text!=confirmpassword.text)
                                      {
                                        return "password does not match";
                                      }*/
                                  return null;
                                },
                              ),
                            ),
                          ]),
                          SizedBox(
                            height: 40,
                          ),
                          InkWell(
                            onTap: () {
                              _ChangeMyPassword();
                            },
                            child: Container(
                              height: 50,
                              width: 120,
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
                                    fontSize: 23.0,
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
      ),
    );
  }
}
