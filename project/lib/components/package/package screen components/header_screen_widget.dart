import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:project/helping%20widgets/loading_image.dart';
import '../../../helping widgets/sizedbox_widget.dart';
import '../../../model/user.dart';
import '../../../screens/favorite_screen.dart';
import '../../../screens/home_screen.dart';
import '../../../helping widgets/alert_dialog.dart';
import '../../popular packages/popular_generator.dart';
import '../../rating_bar.dart';
import '../list_package.dart';

class HeaderScreen extends StatefulWidget {
  final int page;
  final String placeID;
  final String name;
  final String city;
  final String country;
  final String image;
  final num rate;
  final num rateNB;
  const HeaderScreen({
    super.key,
    required this.page,
    required this.placeID,
    required this.name,
    required this.city,
    required this.country,
    required this.image,
    required this.rate,
    required this.rateNB,
  });
  @override
  _HeaderScreenState createState() => _HeaderScreenState();
}

class _HeaderScreenState extends State<HeaderScreen> {
  UserModel currentUser = UserModel.current!;
  final userColl = FirebaseFirestore.instance.collection("user");
  final userRatingsColl = FirebaseFirestore.instance.collection('userRatings');

  bool userRatedPack = false;

  num var_rate= 0;
  num var_rateNB=0;

  Future isUserRatedPack() async {
    final doc =
    await userRatingsColl.doc("${currentUser.id}_${widget.placeID}").get();
    final bool result = doc.data() != null;

    setState(() {
      userRatedPack = result;
    });
  }

  @override
  void initState() {
    super.initState();
    var_rate = widget.rate;
    var_rateNB = widget.rateNB;
    isUserRatedPack();
  }

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
    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: ImageWithLoadingIndicator(
                  imageUrl: widget.image,
                  width: screenWidth,
                  height: screenHeight * 0.4
              ),
            ),
            Positioned(
              top: 30,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  onPressed: () {
                    if (currentUser.favorite!.contains(widget.placeID)) {
                      currentUser.favorite!.remove(widget.placeID);
                    } else {
                      currentUser.favorite!.add(widget.placeID);
                    }
                    setState(() {
                      currentUser;
                    });
                    userColl.doc(currentUser.id).update({
                      "favorite": currentUser.favorite,
                    });
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: currentUser.favorite!.contains(widget.placeID)
                        ? Colors.red
                        : Colors.white,
                    size: 27,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 30,
              left: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  onPressed: () async {
                    final packDoc = await FirebaseFirestore.instance
                        .collection("packages")
                        .doc(widget.placeID)
                        .get();

                    String packTheme = packDoc.data()!["theme"];
                    switch (widget.page) {
                      case 5:
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MyHomeScreen(),
                          ),
                        );
                        break;
                      case 1:
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                MyPackagesList(value: packTheme),
                          ),
                        );
                        break;
                      case 2:
                        widget.country == "United Arab Emirates" ? Navigator.of(
                            context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                const MyPackagesList(value: "U.A.E"),
                          ),
                        ) : Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                MyPackagesList(value: widget.country),
                          ),
                        );
                        break;
                      case 3:
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const MyFavoriteScreen(),
                          ),
                        );
                        break;

                      case 4:
                      default:
                        Navigator.pop(context);
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 30,
              right: 80,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  onPressed: () async {
                    userRatedPack
                        ? showSuccessAlert(
                        context, "You have already rated this package.")
                        : showRatingDialog();
                  },
                  icon: Icon(
                    Icons.star_rate_rounded,
                    color: userRatedPack ? Colors.amber : Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ),
          ],
        ),
        addVerticalSpace(10),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: theme.textTheme.titleLarge,
              ),
              addVerticalSpace(5),
              Row(
                children: [
                  const Icon(
                    Icons.place,
                    size: 20,
                    color: Colors.grey,
                  ),
                  Text(
                    "${widget.city}, ${widget.country}",
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
              addVerticalSpace(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$var_rate",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: themeColors.secondary,
                      fontSize: 40,
                    ),
                  ),
                  addHorizentalSpace(30),
                  Column(
                    children: [
                      MyRatingBar(
                        rating: var_rate,
                        size: 22,
                      ),
                      Text(
                        "$var_rateNB Reviews",
                        style: TextStyle(
                            color: themeColors.surface, fontSize: 16),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> showRatingDialog() async {
    final theme = Theme.of(context);
    final themeColors = Theme.of(context).colorScheme;
    num rateValue = 0.5;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: themeColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(
            "Add your rating",
            style: TextStyle(
              color: themeColors.onSurface,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: Builder(
            builder: (context) => RatingBar.builder(
              initialRating: 0.5,
              minRating: 0.5,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.all(1),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
                size: 10,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  rateValue = rating;
                });
              },
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
                  onPressed: () async {
                    await userRatingsColl
                        .doc("${currentUser.id}_${widget.placeID}")
                        .set({"rate": rateValue});
                    setState(() {
                      userRatedPack = true;
                    });

                    if (rateValue != 0) {
                      Navigator.of(context).pop();
                      showSuccessAlert(context, "Rated Successfully");

                      final packDoc = await FirebaseFirestore.instance
                          .collection("packages")
                          .doc(widget.placeID)
                          .get();

                      num cal =
                          ((packDoc.data()!["rate"] * packDoc.data()!["rateNB"]) + rateValue) /
                              (packDoc.data()!["rateNB"] + 1);
                      String format = cal.toStringAsFixed(1);
                      final newRate = double.parse(format);

                      num newNBRate = packDoc.data()!["rateNB"] + 1;

                      String packCountry = packDoc.data()!["country"];
                      String packTheme = packDoc.data()!["theme"];

                      if (packCountry == "United Arab Emirates") {
                        await FirebaseFirestore.instance
                            .collection("country_UAE")
                            .doc(widget.placeID)
                            .update({
                          "rate": newRate,
                          "rateNB": newNBRate,
                        });
                      } else {
                        await FirebaseFirestore.instance
                            .collection("country_${packCountry.toLowerCase()}")
                            .doc(widget.placeID)
                            .update({
                          "rate": newRate,
                          "rateNB": newNBRate,
                        });
                      }
                      await FirebaseFirestore.instance
                          .collection("package_${packTheme.toLowerCase()}")
                          .doc(widget.placeID)
                          .update({
                        "rate": newRate,
                        "rateNB": newNBRate,
                      });
                      await FirebaseFirestore.instance
                          .collection("packages")
                          .doc(widget.placeID)
                          .update({
                        "rate": newRate,
                        "rateNB": newNBRate,
                      });
                      setState(() {
                        var_rate = newRate;
                        var_rateNB = newNBRate;
                      });
                      getPopular();
                    }
                  },
                  child: const Text(
                    "Rate",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeColors.secondary,
                  ),
                  onPressed: () {
                    Navigator.pop(context);// Cancel button
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
  }
}

