import 'package:flutter/material.dart';

class WhoCard extends StatefulWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const WhoCard(
      {Key? key, required this.title, required this.image, required this.onTap})
      : super(key: key);

  @override
  _WhoCardState createState() => _WhoCardState();
}

class _WhoCardState extends State<WhoCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: 170,
          height: 170,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: widget.title == 'Office Owner'
                        ? EdgeInsets.all(3)
                        : EdgeInsets.all(0),
                    child: Image(
                      width: 110,
                      height: 110,
                      fit: BoxFit.contain,
                      image: AssetImage(
                        widget.image,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                          fontFamily: 'Segopr',
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.blue.shade900),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
