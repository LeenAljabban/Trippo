import 'package:flutter/material.dart';
import 'package:trippo/View/User_Register.dart';
import 'package:trippo/View/who_are_you_card.dart';

import 'Office_Register.dart';

class WhoAreYouPage extends StatefulWidget {
  const WhoAreYouPage({Key? key}) : super(key: key);

  @override
  _WhoAreYouPageState createState() => _WhoAreYouPageState();
}

class _WhoAreYouPageState extends State<WhoAreYouPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
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
            Form(
              key: _formKey,
              child: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Center(
                            child: Text(
                              'Who are you?',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.blue.shade900),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        WhoCard(
                          title: ' user',
                          image: 'assets/user_icon.png',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Register(),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        WhoCard(
                          title: 'office owner',
                          image: 'assets/office_icon.png',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Office_Register(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
