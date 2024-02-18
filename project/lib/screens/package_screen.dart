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
import 'package:project/helping%20widgets/sizedbox_widget.dart';
import 'package:project/screens/favorite_screen.dart';
import 'package:project/screens/home_screen.dart';
import 'package:weather/weather.dart';
import 'package:wikipedia/wikipedia.dart';
import 'package:worldtime/worldtime.dart';

import '../components/package/list_package.dart';
import '../components/package/package screen components/buttom_widget.dart';
import '../components/package/package screen components/header_screen_widget.dart';
import '../components/package/package screen components/map_widget.dart';
import '../components/package/package screen components/overview_widget.dart';
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
  int selectedIndex = 0;
  UserModel currentUser = UserModel.current!;
  final userColl = FirebaseFirestore.instance.collection("user");
  final userRatingsColl = FirebaseFirestore.instance.collection('userRatings');


  LatLng placeCoords=LatLng(0, 0);
  Future getLongLat() async{
    final pack = await FirebaseFirestore.instance.collection("packages").doc(widget.placeID).get();
    final data = pack.data() as Map;
    setState(() {
      placeCoords = LatLng(data["latitude"], data["longitude"]);
    });
  }


  @override
  void initState() {
    super.initState();
    getLongLat();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: themeColors.background,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            HeaderScreen(
              city: widget.city,
              country: widget.country,
              image: widget.image,
              name: widget.name,
              page: widget.page,
              placeID: widget.placeID,
              rate: widget.rate,
              rateNB: widget.rateNB,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addVerticalSpace(20),
                  Divider(
                    color: Colors.grey,
                    height: 1,
                  ),
                  addVerticalSpace(10),
                  Column(
                    children: [
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
                      addVerticalSpace(10),
                      // Content based on the selected index
                      selectedIndex == 0 ? overviewWidget(context,placeCoords,widget.placeID) : mapWidget(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomWidget(context,widget.price),
    );
  }

  Widget buildTextButton(String text, int index) {
    final themeColors = Theme.of(context).colorScheme;
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
                  selectedIndex == index ? themeColors.secondary : themeColors.surface,
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
              color: themeColors.secondary,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }

  late GoogleMapController mapController;
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
}
