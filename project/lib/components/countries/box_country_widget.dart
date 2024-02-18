import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'collections_sizes_generator.dart';
class CountryBox extends StatelessWidget {
  final String country;
  final String image;
  final VoidCallback onTap;

  CountryBox(
      {super.key,
        required this.country,
        required this.image,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Image.asset(
                    image,
                    fit: BoxFit.cover,
                    height: screenHeight * 0.22,
                    width: screenWidth * 0.33,
                  ),
                  Positioned(
                    left: 10,
                    bottom: 12,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      height: screenHeight * 0.082,
                      width: screenWidth * 0.26,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black26,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            country,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          getSize(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  CollectionReference tunisiaCollection =
  FirebaseFirestore.instance.collection("country_tunisia");
  CollectionReference spainCollection =
  FirebaseFirestore.instance.collection("country_spain");
  CollectionReference italyCollection =
  FirebaseFirestore.instance.collection("country_italy");
  CollectionReference greeceCollection =
  FirebaseFirestore.instance.collection("country_greece");
  CollectionReference UAECollection =
  FirebaseFirestore.instance.collection("country_UAE");
  CollectionReference australiaCollection =
  FirebaseFirestore.instance.collection("country_australia");
  CollectionReference croatiaCollection =
  FirebaseFirestore.instance.collection("country_croatia");
  CollectionReference turkeyCollection =
  FirebaseFirestore.instance.collection("country_turkey");

  Widget getSize(){
    switch (country){
      case "Tunisia":
        return CountryWidget(collection: tunisiaCollection,);
      case "Spain":
        return CountryWidget(collection: spainCollection,);
      case "Italy":
        return CountryWidget(collection: italyCollection,);
      case "Greece":
        return CountryWidget(collection: greeceCollection,);
      case "U A E":
        return CountryWidget(collection: UAECollection,);
      case "Australia":
        return CountryWidget(collection: australiaCollection,);
      case "Croatia":
        return CountryWidget(collection: croatiaCollection,);
      case "Turkey":
        return CountryWidget(collection: turkeyCollection,);
      default:
        break;
    }
    return Text("0");
  }
}
