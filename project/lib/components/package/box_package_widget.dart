import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/helping%20widgets/sizedbox_widget.dart';
import 'package:project/screens/package_screen.dart';

import '../../model/user.dart';

class PackageBox extends StatefulWidget {
  final int page;
  final String placeID;
  final String name;
  final String city;
  final String country;
  final String image;
  final num rate;
  final num rateNB;
  final num price;
  final VoidCallback? onFavoriteChanged;

  const PackageBox({
    Key? key,
    required this.page,
    required this.placeID,
    required this.name,
    required this.city,
    required this.country,
    required this.image,
    required this.rate,
    required this.rateNB,
    required this.price,
    this.onFavoriteChanged,
  }) : super(key: key);

  @override
  _PackageBoxState createState() => _PackageBoxState();
}

class _PackageBoxState extends State<PackageBox> {
  UserModel? currentUser;
  CollectionReference userColl = FirebaseFirestore.instance.collection("user");

  @override
  void initState() {
    super.initState();
    currentUser = UserModel.current;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MyPackageScreen(
              page: widget.page,
              placeID: widget.placeID,
              city: widget.city,
              country: widget.country,
              image: widget.image,
              name: widget.name,
              rate: widget.rate,
              rateNB: widget.rateNB,
              price: widget.price,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(7),
        width: screenWidth * 0.9,
        height: screenHeight * 0.29,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: themeColors.onBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              blurStyle: BlurStyle.normal,
              color: themeColors.onBackground,
              spreadRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.image,
                    width: screenWidth * 0.97,
                    height: screenHeight * 0.2,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    onPressed: () async{
                      if (currentUser!.favorite!.contains(widget.placeID)) {
                        setState(() {
                          currentUser!.favorite!.remove(widget.placeID);
                        });
                      } else {
                        setState(() {
                          currentUser!.favorite!.add(widget.placeID);
                        });
                      }

                      await userColl.doc(currentUser!.id).update({"favorite":currentUser!.favorite});

                      widget.onFavoriteChanged?.call();
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: currentUser!.favorite!.contains(widget.placeID)
                          ? Colors.red
                          : Colors.white,
                      size: 27,
                    ),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 10),
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: themeColors.onPrimary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.star_border_outlined,
                          size: 15,
                          color: Colors.white,
                        ),
                        Text(
                          " ${widget.rate} ",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  addHorizentalSpace(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      addVerticalSpace(3),
                      Text(
                        " ${widget.name}",
                        style: theme.textTheme.titleMedium,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.place,
                            size: 20,
                            color: themeColors.surface,
                          ),
                          Text(
                            "${widget.city}, ${widget.country}",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: themeColors.surface,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
