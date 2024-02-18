import 'package:flutter/material.dart';
import 'package:project/components/countries/collections_sizes_generator.dart';

import '../../helping widgets/sizedbox_widget.dart';
import '../package/list_package.dart';
import 'box_country_widget.dart';

class CountriesList extends StatelessWidget {
  final bool show;

  const CountriesList({super.key, required this.show});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = Theme
        .of(context)
        .colorScheme;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CountryBox(
            country: "Tunisia",
            image: "assets/images/countries/tunisie.png",
            onTap: () {

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      MyPackagesList(value: "Tunisia"),
                ),
              );


            },
          ),
          addHorizentalSpace(10),
          CountryBox(
            country: "Spain",
            image: "assets/images/countries/spain.png",
            onTap: () {

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      MyPackagesList(value: "Spain"),
                ),
              );


            },
          ),
          addHorizentalSpace(10),
          CountryBox(
            country: "Italy",
            image: "assets/images/countries/italy.png",
            onTap: () {

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      MyPackagesList(value: "Italy"),
                ),
              );

            },
          ),
          addHorizentalSpace(10),
          CountryBox(
            country: "Greece",
            image: "assets/images/countries/greece.png",
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      MyPackagesList(value: "Greece"),
                ),
              );

            },
          ),
          addHorizentalSpace(10),
          if (show)
            (Row(
              children: [
                CountryBox(
                  country: "U A E",
                  image: "assets/images/countries/UAE.png",
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            MyPackagesList(value: "U.A.E"),
                      ),
                    );

                  },
                ),
                addHorizentalSpace(10),
                CountryBox(
                  country: "Australia",
                  image: "assets/images/countries/australia.png",
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            MyPackagesList(value: "Australia"),
                      ),
                    );

                  },
                ),
                addHorizentalSpace(10),
                CountryBox(
                  country: "Croatia",
                  image: "assets/images/countries/croatia.png",
                  onTap: () {

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            MyPackagesList(value: "Croatia"),
                      ),
                    );


                  },
                ),
                addHorizentalSpace(10),
                CountryBox(
                  country: "Turkey",
                  image: "assets/images/countries/turkey.png",
                  onTap: () {

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            MyPackagesList(value: "Turkey"),
                      ),
                    );

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