import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/helping%20widgets/connection_alerts.dart';
import 'package:project/helping%20widgets/sizedbox_widget.dart';
import '../components/package/package screen components/buttom_widget.dart';
import '../components/package/package screen components/header_screen_widget.dart';
import '../components/package/package screen components/map_widget.dart';
import '../components/package/package screen components/overview_widget.dart';
import '../model/user.dart';
import '../services/connectivity_services.dart';

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


  LatLng placeCoords=const LatLng(0, 0);
  Future getLongLat() async{
    final pack = await FirebaseFirestore.instance.collection("packages").doc(widget.placeID).get();
    final data = pack.data() as Map;
    setState(() {
      placeCoords = LatLng(data["latitude"], data["longitude"]);
    });
  }

  bool isConnected = true;

  @override
  void initState() {
    super.initState();
    getLongLat();
    ConnectivityServices().getConnectivity().then((value) {
      setState(() {
        isConnected = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addVerticalSpace(20),
                  const Divider(
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
                              ConnectivityServices().getConnectivity().then((value) {
                                if (value){
                                  setState(() {
                                    selectedIndex = 0;
                                  });
                                }else{
                                  NoConnectionAlert(context);
                                }
                              });
                            },
                            splashColor: Colors.transparent,
                            child: buildTextButton('Overview', 0),
                          ),
                          InkWell(
                            onTap: () {
                              ConnectivityServices().getConnectivity().then((value) {
                                if (value){
                                  setState(() {
                                    selectedIndex = 1;
                                  });
                                }else{
                                  NoConnectionAlert(context);
                                }
                              });
                            },
                            splashColor: Colors.transparent,
                            child: buildTextButton('Map', 1),
                          ),
                        ],
                      ),
                      addVerticalSpace(10),
                      // Content based on the selected index
                      isConnected ?
                        selectedIndex == 0 ?
                          overviewWidget(context,placeCoords,widget.placeID) :
                            mapWidget(context,placeCoords):
                          const NoConnectionRow(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomWidget(context,widget.price, widget.placeID, widget.image),
    );
  }

  Widget buildTextButton(String text, int index) {
    final themeColors = Theme.of(context).colorScheme;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
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


}
