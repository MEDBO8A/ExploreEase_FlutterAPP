import 'package:flutter/material.dart';

import '../../helping widgets/sizedbox_widget.dart';
import '../package/list_package.dart';
import 'box_categorie_widget.dart';

class CategoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CategorieBox(
            name: "Island",
            image: "assets/images/categories/island.jpg",
            onTap: () {

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                MyPackagesList(value: "Island"),
                          ),
                        );
      

            },
          ),
          addHorizentalSpace(10),
          CategorieBox(
            name: "Desert",
            image: "assets/images/categories/desert.jpg",
            onTap: () {

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      MyPackagesList(value: "Desert"),
                ),
              );
      

            },
          ),
          addHorizentalSpace(10),
          CategorieBox(
            name: "Mount",
            image: "assets/images/categories/mount.jpg",
            onTap: () {

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      MyPackagesList(value: "Mount"),
                ),
              );
      

            },
          ),
          addHorizentalSpace(10),
          CategorieBox(
            name: "Historic",
            image: "assets/images/categories/historic.jpg",
            onTap: () {

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      MyPackagesList(value: "Historic"),
                ),
              );
      

            },
          ),
          addHorizentalSpace(10),
          CategorieBox(
            name: "Beach",
            image: "assets/images/categories/beach.jpeg",
            onTap: () {

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      MyPackagesList(value: "Beach"),
                ),
              );
      

            },
          ),
        ],
      ),
    );
  }
}