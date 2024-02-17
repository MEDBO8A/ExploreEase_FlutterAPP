// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names, deprecated_member_use, unnecessary_null_comparison, use_build_context_synchronously, unused_local_variable, unused_import, prefer_collection_literals

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coordinate_calculator/dlcoordinate_calculator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:project/screens/home_screen.dart';
import 'package:weather/weather.dart';
import 'package:wikipedia/wikipedia.dart';
import 'package:worldtime/worldtime.dart';

import '../components/package/list_package.dart';
import '../components/rating_bar.dart';
import '../model/user.dart';
import '../services/alert_dialog.dart';

class MyPackageScreen extends StatefulWidget {
  final int page;
  final String placeID;
  final String name;
  final String city;
  final String country;
  final String image;
  final num rate;
  final num rateNB;
  final num price;
  const MyPackageScreen({
    super.key,
    required this.page,
    required this.placeID,
    required this.name,
    required this.city,
    required this.country,
    required this.image,
    required this.rate,
    required this.rateNB,
    required this.price,
  });
  @override
  State<MyPackageScreen> createState() => _MyPackageScreenState();
}

class _MyPackageScreenState extends State<MyPackageScreen> {
  Color navyBlue = const Color(0xFF000080);
  int selectedIndex = 0;
  UserModel currentUser = UserModel.current!;
  final userColl = FirebaseFirestore.instance.collection("user");
  final userRatingsColl = FirebaseFirestore.instance.collection('userRatings');
  bool userRatedPack = false;

  num var_rate= 0;
  num var_rateNB=0;

  double lat=0;
  double long=0;

  Future getLongLat() async{
    final pack = await FirebaseFirestore.instance.collection("packages").doc(widget.placeID).get();
    final data = pack.data() as Map;
    setState(() {
      lat = data["latitude"];
      long = data["longitude"];
    });
  }


  Future isUserRatedPack() async {
    final doc =
        await userRatingsColl.doc("${currentUser.id}_${widget.placeID}").get();
    final bool result = doc.data() != null;

    setState(() {
      userRatedPack = result;
    });
  }

  @override
  void initState() {
    super.initState();
    var_rate = widget.rate;
    var_rateNB = widget.rateNB;
    isUserRatedPack();
    getCoord();
    getLongLat();
  }

  Future<void> showRatingDialog() async {
    num rateValue = 0;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(
            "Add your rating",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          content: Builder(
            builder: (context) => RatingBar.builder(
              initialRating: 0,
              minRating: 0.5,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.all(1),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
                size: 10,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  rateValue = rating;
                });
              },
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 40,
                  width: 80,
                  child: FloatingActionButton(
                    onPressed: () async {
                      await userRatingsColl
                          .doc("${currentUser.id}_${widget.placeID}")
                          .set({"rate": rateValue});
                      setState(() {
                        userRatedPack = true;
                      });

                      if (rateValue != 0) {
                        Navigator.of(context).pop();
                        showSuccessAlert(context, "Rated Successfully");

                        final packDoc = await FirebaseFirestore.instance
                            .collection("packages")
                            .doc(widget.placeID)
                            .get();

                        num cal =
                            ((packDoc.data()!["rate"] * packDoc.data()!["rateNB"]) + rateValue) /
                                (packDoc.data()!["rateNB"] + 1);
                        String format = cal.toStringAsFixed(1);
                        final newRate = double.parse(format);

                        num newNBRate = packDoc.data()!["rateNB"] + 1;

                        String packCountry = packDoc.data()!["country"];
                        String packTheme = packDoc.data()!["theme"];

                        if (packCountry == "United Arab Emirates") {
                          await FirebaseFirestore.instance
                              .collection("country_UAE")
                              .doc(widget.placeID)
                              .update({
                            "rate": newRate,
                            "rateNB": newNBRate,
                          });
                        } else {
                          await FirebaseFirestore.instance
                              .collection("country_${packCountry.toLowerCase()}")
                              .doc(widget.placeID)
                              .update({
                            "rate": newRate,
                            "rateNB": newNBRate,
                          });
                        }
                        await FirebaseFirestore.instance
                            .collection("package_${packTheme.toLowerCase()}")
                            .doc(widget.placeID)
                            .update({
                          "rate": newRate,
                          "rateNB": newNBRate,
                        });
                        await FirebaseFirestore.instance
                            .collection("packages")
                            .doc(widget.placeID)
                            .update({
                          "rate": newRate,
                          "rateNB": newNBRate,
                        });
                        setState(() {
                          var_rate = newRate;
                          var_rateNB = newNBRate;
                        });

                      }
                      },
                    child: Text(
                      "Add",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: 80,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Image.network(
                      widget.image,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height * 0.40,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  Positioned(
                    top: 30,
                    right: 20,
                    child: IconButton(
                      onPressed: () {
                        if (currentUser.favorite!.contains(widget.placeID)) {
                          currentUser.favorite!.remove(widget.placeID);
                        } else {
                          currentUser.favorite!.add(widget.placeID);
                        }
                        setState(() {
                          currentUser;
                        });
                        userColl.doc(currentUser.id).update({
                          "favorite": currentUser.favorite,
                        });
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: currentUser.favorite!.contains(widget.placeID)
                            ? Colors.red
                            : Colors.white,
                        size: 27,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    left: 10,
                    child: IconButton(
                      onPressed: () async {
                        final packDoc = await FirebaseFirestore.instance
                            .collection("packages")
                            .doc(widget.placeID)
                            .get();

                        String theme = packDoc.data()!["theme"];
                        switch (widget.page) {
                          case 5:
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => MyHomeScreen(),
                              ),
                            );
                            break;
                          case 1:
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    MyPackagesList(value: theme),
                              ),
                            );
                            break;
                          case 2:
                            widget.country == "United Arab Emirates"?Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    MyPackagesList(value: "U.A.E"),
                              ),
                            ) : Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    MyPackagesList(value: widget.country),
                              ),
                            );
                            break;
                          /*case 3:
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => MyFavoritePage(),
                              ),
                            );
                            break;
                           */
                          case 4:
                          default:
                            Navigator.pop(context);
                        }
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    right: 60,
                    child: IconButton(
                      onPressed: () async {
                        userRatedPack
                            ? showSuccessAlert(
                                context, "You have already rated this package.")
                            : showRatingDialog();
                      },
                      icon: Icon(
                        Icons.star_rate_rounded,
                        color: userRatedPack ? Colors.amber : Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.place,
                          size: 20,
                          color: Colors.grey,
                        ),
                        Text(
                          "${widget.city}, ${widget.country}",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${var_rate}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            MyRatingBar(
                              rating: var_rate,
                              size: 22,
                            ),
                            Text(
                              "${var_rateNB} Reviews",
                              style: TextStyle(
                                  color: Colors.grey[400], fontSize: 16),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 0.1,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2,
                              blurStyle: BlurStyle.normal,
                              color: Colors.grey,
                              spreadRadius: 0.5,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        // Header with clickable text buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = 0;
                                });
                              },
                              splashColor: Colors.transparent,
                              child: buildTextButton('Overview', 0),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = 1;
                                });
                              },
                              splashColor: Colors.transparent,
                              child: buildTextButton('Map', 1),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Content based on the selected index
                        selectedIndex == 0 ? overviewWidget() : mapWidget(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomWidget(),
    );
  }

  Widget buildTextButton(String text, int index) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            text,
            style: TextStyle(
              color:
                  selectedIndex == index ? Colors.lightBlue[500] : Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
        if (selectedIndex == index)
          Container(
            height: 4,
            width: 4,
            decoration: BoxDecoration(
              color: Colors.lightBlue[500],
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }

  Container overviewWidget() {
    const double temp = 12;
    return Container(
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.cloud,
                    size: 20,
                  ),
                  getPlaceWeather(lat,long),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.solidClock,
                    size: 20,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  getPlaceTime(lat,long),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: getPlaceDescription(widget.placeID),
          ),

        ],
      ),
    );
  }

  late GoogleMapController mapController;
  LatLng placeCoords = LatLng(0, 0);

  void getCoord() async {
    final packColl = await FirebaseFirestore.instance
        .collection("packages")
        .doc(widget.placeID)
        .get();
    final doc = packColl.data();
    setState(() {
      placeCoords = LatLng(doc?["latitude"], doc?["longitude"]);
    });
  }

  Container mapWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      child: GoogleMap(
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
          Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
        ].toSet(),
        onMapCreated: (controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: placeCoords,
          zoom: 11.5,
        ),
        markers: {
          Marker(
            markerId: MarkerId("Source"),
            position: placeCoords,
          ),
        },
      ),
    );
  }

  Container bottomWidget() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 9,
            blurStyle: BlurStyle.normal,
            color: Colors.grey,
            spreadRadius: 2,
            offset: Offset(1, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Price: ${widget.price} \$",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          GestureDetector(
            onTap: () {
              /*
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MyBookPackage(),
                ),
              );

               */
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 23, vertical: 15),
              decoration: BoxDecoration(
                color: navyBlue,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white70,
                  width: 0.5,
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 9,
                    blurStyle: BlurStyle.normal,
                    color: const Color.fromARGB(186, 158, 158, 158),
                    spreadRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(
                    'Book now',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 10,
                    color: Colors.white30,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: Colors.white54,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Colors.white70,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getPlaceTime(double lat, double long) {
    return FutureBuilder<String>(
      future: placeTime(lat, long),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("--");
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Text(snapshot.data!.split(", ")[0].split("- ")[1]);
        }
      },
    );
  }
  Future<String> placeTime(double lat, double long) async{
    final _worldtimePlugin = Worldtime();
    const String myFormatter = 'time - \\h:\\m, date - \\D/\\M/\\Y';
    final DateTime timeAmsterdamGeo = await _worldtimePlugin
        .timeByLocation(latitude: lat, longitude: long);
    final String resultGeo = _worldtimePlugin
        .format(dateTime: timeAmsterdamGeo, formatter: myFormatter);
    return resultGeo;

  }

  Widget getPlaceWeather(double lat, double long){
    return FutureBuilder(
        future: placeWeather(lat, long),
        builder: (context,snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("  --");
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Text("  ${snapshot.data.round()} °C");
          }
        });
  }
  Future placeWeather(double lat, double long) async{
    WeatherFactory wf = WeatherFactory("32549f2ee99a8b413279a95b1ef502b6");
    Weather w = await wf.currentWeatherByLocation(lat,long);
    return w.temperature!.celsius;
  }

  Widget getPlaceDescription(String place){
    return FutureBuilder(
        future: placeDescription(place),
        builder: (context,snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("  --");
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Text("${snapshot.data}");
          }
        });
  }

  Future placeDescription(String place) async {
    String description = "";
    try{
      Wikipedia instance = Wikipedia();
      var result = await instance.searchQuery(searchQuery: "$place",limit: 1);
      for(int i=0; i<result!.query!.search!.length; i++){
        description+="${result.query!.search![i].snippet}. \n";
      }
      var resultt = await instance.searchQuery(searchQuery: "Talk about $place",limit: 1);
      for(int i=0; i<resultt!.query!.search!.length; i++){
        if (description != "${resultt.query!.search![i].snippet}. \n") {
          description += "${resultt.query!.search![i].snippet}. \n";
        }
      }
    }catch(e){
      print(e);
    }
    print(description);
    return description;
  }

}
