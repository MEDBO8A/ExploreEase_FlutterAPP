import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/helping%20widgets/sizedbox_widget.dart';
import 'package:project/model/user.dart';
import '../../helping widgets/alert_dialog.dart';
import '../../helping widgets/connection_alerts.dart';
import '../../helping widgets/loading_image.dart';
import '../../services/connectivity_services.dart';

class BookedPackageBox extends StatefulWidget {
  final String placeID;
  final String name;
  final String city;
  final String country;
  final String image;
  final num rate;
  final num rateNB;
  final num price;
  final VoidCallback? onDelete;

  BookedPackageBox({
    super.key,
    required this.placeID,
    required this.name,
    required this.city,
    required this.country,
    required this.image,
    required this.rate,
    required this.rateNB,
    required this.price,
    this.onDelete,
  });

  @override
  State<BookedPackageBox> createState() => _BookedPackageBoxState();
}

class _BookedPackageBoxState extends State<BookedPackageBox> {
  UserModel? currentUser = UserModel.current;
  CollectionReference userColl = FirebaseFirestore.instance.collection("user");
  CollectionReference bookedColl = FirebaseFirestore.instance.collection("booked_packages");

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 110,
        width: screenWidth * 0.95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: themeColors.background,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ImageWithLoadingIndicator(
                  imageUrl: widget.image,
                  width: screenWidth * 0.25,
                  height: screenHeight * 0.15
              ),
            ),
            Column(
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
                            " ${widget.rate} ",
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
                      widget.name,
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
                      widget.country == "United Arab Emirates" ?
                      "${widget.city}, U.A.E":
                      "${widget.city}, ${widget.country}",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: (){
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: themeColors.background,
                      content: Text(
                        "Confirme to unbook the ${widget.placeID} package",
                        style: TextStyle(
                          color: themeColors.surface,
                          fontSize: 18,
                        ),
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themeColors.primary,
                              ),
                              onPressed: () async{
                                final isConnected = await ConnectivityServices().getConnectivity();
                                if (isConnected) {
                                  setState(() {
                                    currentUser!.booked!.remove(widget.placeID);
                                  });
                                  await userColl.doc(currentUser!.id).update({
                                    "booked": currentUser!.booked
                                  });
                                  await bookedColl.doc("${currentUser!.id}_${widget.placeID}").delete();

                                  widget.onDelete?.call();

                                  Navigator.of(context).pop();
                                  showSuccessAlert(context, "Package is unbooked succussfully");

                                }else {
                                  NoConnectionAlert(context);
                                }},
                              child: const Text(
                                "UnBook",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themeColors.onSecondary,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                height: 70,
                width: 30,
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Icon(
                  Icons.delete_forever,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
