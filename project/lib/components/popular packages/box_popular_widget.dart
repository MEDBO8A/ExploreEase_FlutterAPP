import 'package:flutter/material.dart';
import 'package:project/helping%20widgets/sizedbox_widget.dart';
import 'package:project/screens/package_screen.dart';

import '../../helping widgets/connection_alerts.dart';
import '../../helping widgets/loading_image.dart';
import '../../services/connectivity_services.dart';

class PopularPackageBox extends StatelessWidget {
  final String placeID;
  final String name;
  final String city;
  final String country;
  final String image;
  final num rate;
  final num rateNB;
  final num price;
  const PopularPackageBox({
    super.key,
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
            builder: (context) => MyPackageScreen(
              page: 5,
              placeID: placeID,
              city: city,
              country: country,
              image: image,
              name: name,
              rate: rate,
              rateNB: rateNB,
              price: price,
            ),
          ),
        );
      }else {
        NoConnectionAlert(context);
      }
      },
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.only(right: 10),
        height: screenHeight * 0.17,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: themeColors.onBackground,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ImageWithLoadingIndicator(
                  imageUrl: image,
                  width: screenWidth * 0.25,
                  height: screenHeight * 0.17
              ),
            ),
            addHorizentalSpace(5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: themeColors.onPrimary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star_border_outlined,
                            size: 17,
                            color: Colors.white,
                          ),
                          Text(
                            " $rate ",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    addHorizentalSpace(10),
                    Text(
                      name,
                      style: theme.textTheme.titleMedium,
                    ),
                  ],
                ),
                addVerticalSpace(5),
                Row(
                  children: [
                    Icon(
                      Icons.place,
                      size: 20,
                      color: themeColors.surface,
                    ),
                    Text(
                      "$city, $country",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
