import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trippo/Models/TripModel.dart';
import 'package:trippo/View/Reservation.dart';

class Trip extends StatefulWidget {
  final TripModel tripModel;
  const Trip({Key? key, required this.tripModel}) : super(key: key);
  @override
  _TripState createState() => _TripState();
}

class _TripState extends State<Trip> {
  final _controller = PageController();
  int activePage = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 230,
                width: double.infinity,
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _controller,
                      itemCount: widget.tripModel.places.length,
                      onPageChanged: (page) {
                        setState(() {
                          activePage = page;
                        });
                      },
                      itemBuilder: (BuildContext context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    'http://192.168.43.164:8000/${widget.tripModel.places[index].photo}'),
                                fit: BoxFit.fill),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: SmoothPageIndicator(
                            controller: _controller,
                            count: widget.tripModel.places.length,
                            effect: SwapEffect(
                                activeDotColor: Colors.white,
                                dotHeight: 10,
                                dotWidth: 10),
                          )),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.tripModel.trip_name,
                      style: TextStyle(
                          color: Colors.indigo[900],
                          //  r: Colors.indigo[900],
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.1),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.date_range,
                              color: Colors.indigo[900],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Start :',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              widget.tripModel.trip_start,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.date_range,
                              color: Colors.indigo[900],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'End :',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              widget.tripModel.trip_end,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),

                    Row(
                      children: [
                        Icon(
                          Icons.monetization_on_outlined,
                          color: Colors.indigo[900],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Price :',
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          widget.tripModel.total_trip_price.toString() + 'SP',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.timelapse,
                          color: Colors.indigo[900],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Duration :',
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          widget.tripModel.duration.toString() + 'days',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.data_usage,
                          color: Colors.indigo[900],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Status :',
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          widget.tripModel.trip_status,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    // Divider(
                    //   height: 15,
                    //   thickness: 1,
                    //   color: Colors.grey,
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Trip Places :',
                      style: TextStyle(
                          color: Colors.indigo[900],
                          //  r: Colors.indigo[900],
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.1),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 170,
                      width: double.infinity,
                      child: ListView.builder(
                          shrinkWrap: false,
                          itemCount: widget.tripModel.places.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                child: Text(
                              widget.tripModel.places[index].place_name,
                              style: TextStyle(
                                color: Colors.black87,
                                //  r: Colors.indigo[900],
                                fontSize: 20,
                              ),
                            ));
                          }),
                    ),
                    Divider(
                      height: 15,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Trip Plan :',
                      style: TextStyle(
                          color: Colors.indigo[900],
                          //  r: Colors.indigo[900],
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.1),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.tripModel.trip_plane,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Divider(
                      height: 15,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'What You need to know :',
                      style: TextStyle(
                          color: Colors.indigo[900],
                          //  r: Colors.indigo[900],
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.1),
                    ),
                    Text(
                      widget.tripModel.note +
                          ' -There are Avilable time for shopping',
                      style: TextStyle(
                        color: Colors.black87,
                        //  r: Colors.indigo[900],
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade900,
                            borderRadius: BorderRadius.circular(50)),
                        child: FlatButton(
                          child: Text(
                            'Reserve',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Reservation(tripModel: widget.tripModel)),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
