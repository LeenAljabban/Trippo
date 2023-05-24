import 'dart:convert';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:trippo/Models/UserModel.dart';
import 'package:trippo/Models/placeModel.dart';
import 'package:trippo/View/Country.dart';
import 'package:trippo/API/api.dart';
import 'package:trippo/Models/homeModel.dart';
import 'package:trippo/View/Discounts.dart';
import 'package:trippo/View/OffiecProfile_UserSide.dart';
import '../Models/TripModel.dart';
import 'Attractions.dart';
import 'Place.dart';
import 'Trip.dart';
import 'OfficesList.dart';
import 'NavBar.dart';
import 'package:filter_list/filter_list.dart';

List<TripModel> trips = <TripModel>[];
List<homeModel> countries = <homeModel>[];
String startDate = '';
String EndDate = '';
String Status = '';
int num = 0;

bool load = false;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

TabController? _tabController;

class _HomeState extends State<Home> with TickerProviderStateMixin {
  TextEditingController start = new TextEditingController();
  TextEditingController end = new TextEditingController();
  bool isload = false;
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text('Tripo');

  List<homeModel> _countries = <homeModel>[];
  List<TripModel> _trips = <TripModel>[];
  @override
  void initState() {
    _FetchCountries().then((value) {
      setState(() {
        _countries.addAll(value);
        countries.addAll(value);
      });
    });
    _FetchTrips().then((value) {
      setState(() {
        _trips.addAll(value);
        trips.addAll(value);
      });
    });
    isload = true;
    super.initState();
    _tabController = new TabController(length: 4, vsync: this);
  }

  // @override
  // void dispose() {
  //   _tabController?.dispose();
  //   super.dispose();
  // }
  Future FilterDate() async {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (startDate != '') {
      data['trip_start'] = startDate;
      data['trip_end'] = EndDate;
    }

    data['trip_status'] = selectedList;
    var response = await CallApi().postdata(data, 'user/tripsfilters');
    print(response.body);
    if (response.statusCode == 200) {
      var item = json.decode(response.body);
      setState(() {
        for (var i in item) {
          _trips.add(TripModel.fromJson(i));
          print(_trips.length);
        }
      });
      // load = true;
    } else
      print('vgbhjk');
  }

  Future<List<homeModel>> _FetchCountries() async {
    var response = await CallApi().getdata('get_all_country');
    // print(response.body);
    var countries = <homeModel>[];
    var item = json.decode(response.body);

    for (var i in item) {
      countries.add(homeModel.fromJson(i));
    }

    return countries;
  }

  Future<List<TripModel>> _FetchTrips() async {
    var response = await CallApi().getdata('get_trip_place');
    // print(response.body);
    var trips = <TripModel>[];
    var item = json.decode(response.body);

    for (var i in item) {
      trips.add(TripModel.fromJson(i));
    }

    return trips;
  }

  var selectedList = <String>[];
  Future<void> FilterDialog() {
    start.text = startDate;
    end.text = EndDate;

    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext Filter) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Container(
              // height: 800,
              //  color: Colors.grey.shade200,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Filters ',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Trip Status: ',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  Status = 'coming';
                                  if (selectedList.contains('coming')) {
                                    selectedList.remove('coming');
                                  } else
                                    selectedList.add('coming');
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(2),
                                width: 150.0,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: selectedList.contains('coming')
                                      ? Colors.blue
                                      : Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'coming',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Status = 'finished';
                                setState(() {
                                  if (selectedList.contains('finished')) {
                                    selectedList.remove('finished');
                                  } else
                                    selectedList.add('finished');
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(2),
                                width: 150.0,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: selectedList.contains('finished')
                                      ? Colors.blue
                                      : Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'finished',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Trip Time: ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: SizedBox(
                            height: 50,
                            width: 300,
                            child: TextField(
                              controller: start,
                              onChanged: (value) {
                                startDate = value;
                                if (EndDate != '') num = 1;
                              },
                              decoration: InputDecoration(
                                hintText: 'Trip start',
                                icon: Icon(
                                  Icons.date_range,
                                  color: Colors.blue.shade900,
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 20,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 2,
                                    color: Colors.indigo,
                                  ),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: SizedBox(
                            height: 50,
                            width: 300,
                            child: TextField(
                              controller: end,
                              onChanged: (value) {
                                EndDate = value;
                                if (EndDate != '') num = 2;
                              },
                              decoration: InputDecoration(
                                hintText: 'Trip End',
                                icon: Icon(
                                  Icons.date_range,
                                  color: Colors.blue.shade900,
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 20,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 2,
                                    color: Colors.indigo,
                                  ),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.blue.shade900,
                              borderRadius: BorderRadius.circular(50)),
                          child: FlatButton(
                            child: Text(
                              'Reset',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                selectedList.clear();
                                start.text = '';
                                end.text = '';
                              });
                            },
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.blue.shade900,
                              borderRadius: BorderRadius.circular(50)),
                          child: FlatButton(
                            child: Text(
                              'Apply',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              if (selectedList.isNotEmpty || startDate != '') {
                                _trips.clear();
                                FilterDate();
                              }
                              // if (load == true)
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    // print(_tabController?.index);
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
              return <Widget>[
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  backgroundColor: Colors.blue.shade900,
                  title: cusSearchBar,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: IconButton(
                        icon: cusIcon,
                        onPressed: () {
                          setState(() {
                            if (this.cusIcon.icon == Icons.search) {
                              this.cusIcon = Icon(Icons.cancel);

                              this.cusSearchBar = _tabController?.index == 0
                                  ? TypeAheadField(
                                      debounceDuration:
                                          Duration(milliseconds: 500),
                                      hideSuggestionsOnKeyboardHide: false,
                                      textFieldConfiguration:
                                          TextFieldConfiguration(
                                        autofocus: true,
                                      ),
                                      suggestionsCallback: (pattern) =>
                                          tripSearch(pattern),
                                      itemBuilder: (context, itemData) {
                                        TripModel trip = itemData as TripModel;
                                        return ListTile(
                                          title: Text(
                                            trip.trip_name,
                                          ),
                                        );
                                      },
                                      onSuggestionSelected: (suggestion) {
                                        TripModel trip =
                                            suggestion as TripModel;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Trip(tripModel: suggestion),
                                          ),
                                        );
                                      })
                                  : _tabController?.index == 1
                                      ? TypeAheadField(
                                          debounceDuration:
                                              Duration(milliseconds: 500),
                                          hideSuggestionsOnKeyboardHide: false,
                                          textFieldConfiguration:
                                              TextFieldConfiguration(
                                            autofocus: true,
                                          ),
                                          suggestionsCallback: (pattern) =>
                                              OfficeSearch(pattern),
                                          itemBuilder: (context, itemData) {
                                            UserModel office =
                                                itemData as UserModel;
                                            return ListTile(
                                              title: Text(
                                                office.FirstName,
                                              ),
                                            );
                                          },
                                          onSuggestionSelected: (suggestion) {
                                            UserModel office =
                                                suggestion as UserModel;
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    OffiecProfile_UserSide(
                                                        userModel: office),
                                              ),
                                            );
                                          })
                                      : _tabController?.index == 2
                                          ? TypeAheadField(
                                              debounceDuration:
                                                  Duration(milliseconds: 500),
                                              hideSuggestionsOnKeyboardHide:
                                                  false,
                                              textFieldConfiguration:
                                                  TextFieldConfiguration(
                                                autofocus: true,
                                              ),
                                              suggestionsCallback: (pattern) =>
                                                  AttractionSearch(pattern),
                                              itemBuilder: (context, itemData) {
                                                PlaceModel? attraction =
                                                    itemData as PlaceModel;
                                                return ListTile(
                                                  title: Text(
                                                    attraction.place_name,
                                                  ),
                                                );
                                              },
                                              onSuggestionSelected:
                                                  (suggestion) {
                                                PlaceModel? attraction =
                                                    suggestion as PlaceModel;
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => Place(
                                                        place: attraction),
                                                  ),
                                                );
                                              })
                                          : _tabController?.index == 3
                                              ? TypeAheadField(
                                                  debounceDuration: Duration(
                                                      milliseconds: 500),
                                                  hideSuggestionsOnKeyboardHide:
                                                      false,
                                                  textFieldConfiguration:
                                                      TextFieldConfiguration(
                                                    autofocus: true,
                                                  ),
                                                  suggestionsCallback:
                                                      (pattern) =>
                                                          discountSearch(
                                                              pattern),
                                                  itemBuilder:
                                                      (context, itemData) {
                                                    TripModel? discount =
                                                        itemData as TripModel;
                                                    return ListTile(
                                                      title: Text(
                                                        discount.trip_name,
                                                      ),
                                                    );
                                                  },
                                                  onSuggestionSelected:
                                                      (suggestion) {
                                                    TripModel? discount =
                                                        suggestion as TripModel;
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Trip(
                                                                tripModel:
                                                                    discount),
                                                      ),
                                                    );
                                                  })
                                              : Container();
                            } else {
                              this.cusIcon = Icon(Icons.search);
                              this.cusSearchBar = Center(child: Text('Tripo'));
                            }
                          });
                        },
                      ),
                    ),
                  ],
                  bottom: TabBar(
                    onTap: (c) => {print(_tabController?.index)},
                    controller: _tabController,
                    labelColor: Colors.white70,
                    unselectedLabelColor: Colors.white,
                    tabs: [
                      Tab(
                        text: "Home",
                      ),
                      Tab(
                        text: "Offices",
                      ),
                      Tab(
                        text: "Attractions",
                      ),
                      Tab(
                        text: "Discounts",
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                ListView(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    // Container(),
                    SizedBox(
                      // margin: EdgeInsets.all(10),
                      height: 200,
                      //color: Colors.lightBlueAccent,
                      // color: Colors.pinkAccent,
                      child: ListView.builder(
                        itemCount: _countries.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Country(homemodel: _countries[index])),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0, 7, 0, 4),
                              width: 200,
                              //  color: Colors.purple,
                              child: Column(
                                //alignment: Alignment.topCenter,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                            color: Colors.blueGrey.shade800),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(0.0, 2.0),
                                            blurRadius: 6.0,
                                          )
                                        ]),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image(
                                        height: 120,
                                        width: 180,

                                        image: NetworkImage(
                                          //  'http://192.168.1.109:8000/appimages/mmmm.jpg',
                                          'http://192.168.43.164:8000/${_countries[index].image}',
                                        ),
                                        // color: Colors.white.withOpacity(0.7),
                                        colorBlendMode: BlendMode.modulate,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 200,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      //  color: Colors.deepPurpleAccent,
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 3),
                                        child: Text(
                                          _countries[index].county_name,
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    //   child: Divider(
                    //     color: Colors.grey.shade400,
                    //     thickness: 2,
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 50,
                            width: 250,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.5), //color of shadow
                                    spreadRadius: 2, //spread radius
                                    blurRadius: 7, // blur radius
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  )
                                ],
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            child: Center(
                              child: Text(
                                'Our Trips',
                                style: TextStyle(
                                    fontSize: 27, color: Colors.grey.shade700),
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 60,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.5), //color of shadow
                                    spreadRadius: 2, //spread radius
                                    blurRadius: 7, // blur radius
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  )
                                ],
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            child: IconButton(
                              onPressed: () {
                                FilterDialog();
                              },
                              icon: Icon(Icons.filter_alt,
                                  color: Colors.grey.shade700),
                            ),
                          )
                        ],
                      ),
                    ),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _trips.length,
                        padding: EdgeInsets.only(top: 10, bottom: 15),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Trip(tripModel: _trips[index])),
                              );
                            },
                            child: Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 5, 15, 5),
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        120, 10, 10, 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              // color: Colors.red,
                                              width: 150,
                                              child: Text(
                                                _trips[index].trip_name,
                                                style: TextStyle(
                                                    fontSize: 19.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text(
                                              _trips[index]
                                                      .total_trip_price
                                                      .toString() +
                                                  ' SP',
                                              style: TextStyle(
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(2),
                                          width: 100.0,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            _trips[index].trip_status,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(3),
                                              width: 100.0,
                                              decoration: BoxDecoration(
                                                color: Colors.blue.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                _trips[index].trip_start,
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(3),
                                              width: 100.0,
                                              decoration: BoxDecoration(
                                                color: Colors.blue.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                _trips[index].trip_start,
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 15,
                                  top: 8,
                                  bottom: 8,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image(
                                      width: 110,
                                      image: NetworkImage(
                                          'http://192.168.43.164:8000/${_trips[index].photo}'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ],
                ),
                OfficesList(),
                Attractions(),
                Discounts(),
              ],
            ),
          ),
          drawer: NavBar(),
          backgroundColor: Colors.grey.shade200,
        ),
      ),
    );
  }
}
