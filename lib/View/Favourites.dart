import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart';

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text('Favourites'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
      body: ListView.builder(
          itemCount: 12,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Container(
              // color: Colors.red,
              padding: EdgeInsets.all(11),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ListTile(
                title: Text(
                  'my favourite trip',
                  style: TextStyle(fontSize: 20),
                ),
                trailing: FavoriteButton(
                  isFavorite: true,
                  iconSize: 40,
                  valueChanged: () {},
                ),
              ),
            );
          }),
    );
  }
}
