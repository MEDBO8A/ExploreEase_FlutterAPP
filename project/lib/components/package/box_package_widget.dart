import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/helping%20widgets/connection_alerts.dart';
import 'package:project/helping%20widgets/sizedbox_widget.dart';
import 'package:project/screens/package_screen.dart';
import '../../helping widgets/loading_image.dart';
import '../../model/user.dart';
import '../../services/connectivity_services.dart';

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
    this.onFavoriteChanged,
  });

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
      onTap: () async{
      final isConnected = await ConnectivityServices().getConnectivity();
      if (isConnected) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                MyPackageScreen(
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
      }else {
        NoConnectionAlert(context);
      }
      },
      child: Container(
        margin: const EdgeInsets.all(7),
        width: screenWidth * 0.9,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: themeColors.onBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              blurStyle: BlurStyle.normal,
              color: themeColors.onBackground,
              spreadRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ImageWithLoadingIndicator(
                      imageUrl: widget.image,
                      width: screenWidth * 0.97,
                      height: screenHeight * 0.2
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      onPressed: () async{
                        final isConnected = await ConnectivityServices().getConnectivity();
                        if (isConnected) {
                          if (currentUser!.favorite!.contains(widget.placeID)) {
                            setState(() {
                              currentUser!.favorite!.remove(widget.placeID);
                            });
                          } else {
                            setState(() {
                              currentUser!.favorite!.add(widget.placeID);
                            });
                          }

                          await userColl.doc(currentUser!.id).update({
                            "favorite": currentUser!.favorite
                          });

                          widget.onFavoriteChanged?.call();
                        }else{
                          NoConnectionAlert(context);
                        }
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
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: themeColors.onPrimary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.star_border_outlined,
                          size: 15,
                          color: Colors.white,
                        ),
                        Text(
                          " ${widget.rate} ",
                          style: const TextStyle(
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
