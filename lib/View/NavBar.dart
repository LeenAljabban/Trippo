import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trippo/View/MyTrips.dart';
import 'package:trippo/View/UserProfile.dart';

import '../API/api.dart';
import 'BigMap.dart';
import 'Favourites.dart';
import 'login.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Leen Aljabban'),
            accountEmail: Text('Leenaljabban20@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/leen.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/sidebar.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('My Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfile()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.card_travel),
            title: Text('My trips'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyTrips()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Map'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BigMap()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log out'),
            onTap: () async {
              var response = await CallApi().postdata(null, 'logout');
              // var body = json.decode(
              //     response.body);

              if (response.statusCode == 200) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) => Login(),
                  ),
                  (Route route) => false,
                );
              } else {
                print('error');
              }
            },
          ),
        ],
      ),
    );
  }
}
