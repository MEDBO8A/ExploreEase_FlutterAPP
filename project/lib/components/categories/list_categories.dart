import 'package:flutter/material.dart';
import 'package:project/helping%20widgets/connection_alerts.dart';
import '../../helping widgets/sizedbox_widget.dart';
import '../../services/connectivity_services.dart';
import '../package/list_package.dart';
import 'box_categorie_widget.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {

  bool isConnected = true;

  @override
  void initState() {
    super.initState();
    ConnectivityServices().getConnectivity().then((value) {
      setState(() {
        isConnected = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CategorieBox(
            name: "Island",
            image: "assets/images/categories/island.jpg",
            onTap: () async {
              final isConnected = await ConnectivityServices().getConnectivity();
              if (isConnected) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MyPackagesList(value: "Island"),
                  ),
                );
              } else {
                NoConnectionAlert(context);
              }
            },
          ),
          addHorizentalSpace(10),
          CategorieBox(
            name: "Desert",
            image: "assets/images/categories/desert.jpg",
            onTap: () async {
              final isConnected = await ConnectivityServices().getConnectivity();
              if (isConnected) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MyPackagesList(value: "Desert"),
                  ),
                );
              } else {
                NoConnectionAlert(context);
              }
            },
          ),
          addHorizentalSpace(10),
          CategorieBox(
            name: "Mount",
            image: "assets/images/categories/mount.jpg",
            onTap: () async {
              final isConnected = await ConnectivityServices().getConnectivity();
              if (isConnected) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MyPackagesList(value: "Mount"),
                  ),
                );
              } else {
                NoConnectionAlert(context);
              }
            },
          ),
          addHorizentalSpace(10),
          CategorieBox(
            name: "Historic",
            image: "assets/images/categories/historic.jpg",
            onTap: () async {
              final isConnected = await ConnectivityServices().getConnectivity();
              if (isConnected) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MyPackagesList(value: "Historic"),
                  ),
                );
              } else {
                NoConnectionAlert(context);
              }
            },
          ),
          addHorizentalSpace(10),
          CategorieBox(
            name: "Beach",
            image: "assets/images/categories/beach.jpeg",
            onTap: () async {
              final isConnected = await ConnectivityServices().getConnectivity();
              if (isConnected) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MyPackagesList(value: "Beach"),
                  ),
                );
              } else {
                NoConnectionAlert(context);
              }
            },
          ),

        ],
      ),
    );
  }
}