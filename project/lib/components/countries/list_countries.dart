import 'package:flutter/material.dart';
import 'package:project/helping%20widgets/connection_alerts.dart';
import '../../helping widgets/sizedbox_widget.dart';
import '../../services/connectivity_services.dart';
import '../package/list_package.dart';
import 'box_country_widget.dart';

class CountriesList extends StatefulWidget {
  final bool show;

  const CountriesList({super.key, required this.show});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {

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
          CountryBox(
            country: "Tunisia",
            image: "assets/images/countries/tunisie.png",
            onTap: () async {
              final isConnected = await ConnectivityServices().getConnectivity();
              if (isConnected) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MyPackagesList(value: "Tunisia"),
                  ),
                );
              } else {
                NoConnectionAlert(context);
              }
            },
          ),
          addHorizentalSpace(10),
          CountryBox(
            country: "Spain",
            image: "assets/images/countries/spain.png",
            onTap: () async {
              final isConnected = await ConnectivityServices().getConnectivity();
              if (isConnected) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MyPackagesList(value: "Spain"),
                  ),
                );
              } else {
                NoConnectionAlert(context);
              }
            },
          ),
          addHorizentalSpace(10),
          CountryBox(
            country: "Italy",
            image: "assets/images/countries/italy.png",
            onTap: () async {
              final isConnected = await ConnectivityServices().getConnectivity();
              if (isConnected) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MyPackagesList(value: "Italy"),
                  ),
                );
              } else {
                NoConnectionAlert(context);
              }
            },
          ),
          addHorizentalSpace(10),
          CountryBox(
            country: "Greece",
            image: "assets/images/countries/greece.png",
            onTap: () async {
              final isConnected = await ConnectivityServices().getConnectivity();
              if (isConnected) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MyPackagesList(value: "Greece"),
                  ),
                );
              } else {
                NoConnectionAlert(context);
              }
            },
          ),
          addHorizentalSpace(10),
          if (widget.show)
            (
                Row(
                  children: [
                    CountryBox(
                      country: "U A E",
                      image: "assets/images/countries/UAE.png",
                      onTap: () async {
                        final isConnected = await ConnectivityServices().getConnectivity();
                        if (isConnected) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const MyPackagesList(value: "U.A.E"),
                            ),
                          );
                        } else {
                          NoConnectionAlert(context);
                        }
                      },
                    ),
                    addHorizentalSpace(10),
                    CountryBox(
                      country: "Australia",
                      image: "assets/images/countries/australia.png",
                      onTap: () async {
                        final isConnected = await ConnectivityServices().getConnectivity();
                        if (isConnected) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const MyPackagesList(value: "Australia"),
                            ),
                          );
                        } else {
                          NoConnectionAlert(context);
                        }
                      },
                    ),
                    addHorizentalSpace(10),
                    CountryBox(
                      country: "Croatia",
                      image: "assets/images/countries/croatia.png",
                      onTap: () async {
                        final isConnected = await ConnectivityServices().getConnectivity();
                        if (isConnected) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const MyPackagesList(value: "Croatia"),
                            ),
                          );
                        } else {
                          NoConnectionAlert(context);
                        }
                      },
                    ),
                    addHorizentalSpace(10),
                    CountryBox(
                      country: "Turkey",
                      image: "assets/images/countries/turkey.png",
                      onTap: () async{
                        final isConnected = await ConnectivityServices().getConnectivity();
                        if (isConnected) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const MyPackagesList(value: "Turkey"),
                            ),
                          );
                        } else {
                          NoConnectionAlert(context);
                        }
                      },
                    ),
                  ],
                )
            ),
        ],
      ),
    );
  }
}