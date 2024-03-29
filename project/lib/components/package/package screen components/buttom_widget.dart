import 'package:flutter/material.dart';
import 'package:project/helping%20widgets/alert_dialog.dart';
import 'package:project/screens/package_book_screen.dart';

import '../../../helping widgets/connection_alerts.dart';
import '../../../model/user.dart';
import '../../../services/connectivity_services.dart';

Container bottomWidget(BuildContext context, dynamic price, String placeID, String image) {
  final theme = Theme.of(context);
  final themeColors = Theme.of(context).colorScheme;
  final screenHeight = MediaQuery.of(context).size.height;

  UserModel? currentUser = UserModel.current;

  return Container(
    height: screenHeight * 0.1,
    decoration: BoxDecoration(
      color: themeColors.onBackground,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      boxShadow: const [
        BoxShadow(
          blurRadius: 9,
          blurStyle: BlurStyle.normal,
          color: Colors.grey,
          spreadRadius: 2,
          offset: Offset(1, 0),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "Price: $price \$",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () {
            ConnectivityServices().getConnectivity().then((value) {
              if (value){
                if (currentUser!.booked!.contains(placeID)){
                  showErrorAlert(context, "You have already booked this package");
                }else{
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MyBookingScreen(image: image, placeID: placeID),
                    ),
                  );
                }
              }else{
                NoConnectionAlert(context);
              }
            });

          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 15),
            decoration: BoxDecoration(
              color: themeColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Text(
                  'Book now',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  width: 7,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 10,
                  color: Colors.white30,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Colors.white54,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: Colors.white70,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}