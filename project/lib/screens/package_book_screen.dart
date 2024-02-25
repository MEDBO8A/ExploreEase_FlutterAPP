import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/components/forums/booking_text_fields.dart';
import 'package:project/components/sign%20in&up%20components/buttons.dart';
import 'package:project/helping%20widgets/alert_dialog.dart';
import 'package:project/helping%20widgets/sizedbox_widget.dart';
import 'package:project/model/user.dart';
import '../helping widgets/connection_alerts.dart';
import '../services/connectivity_services.dart';

class MyBookingScreen extends StatefulWidget {

  final String placeID;
  final String image;
  const MyBookingScreen({super.key, required this.placeID, required this.image});

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> {


  UserModel? currentUser = UserModel.current;
  CollectionReference userColl = FirebaseFirestore.instance.collection("user");
  CollectionReference bookedColl = FirebaseFirestore.instance.collection("booked_packages");
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _num = TextEditingController();

  String? fNameError;
  String? lNameError;
  String? numError;

  void _validateInputs() {

    setState(() {
      fNameError = null;
      lNameError = null;
      numError = null;

      if ((_firstName.text.isEmpty) || (_firstName.text.length == 0)) {
        fNameError = 'Invalid First Name';
      }
      if ((_lastName.text.isEmpty) || (_lastName.text.length == 0)) {
        lNameError = 'Invalid Last Name ';
      }
      if ((_num.text.isEmpty) || (num.tryParse(_num.text) == null) || (_num.text.length != 8)){
        numError = "Invalid Phone Number";
      }
    }
    );
  }



  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.05,
        iconTheme: IconThemeData(color: themeColors.onPrimary),
        backgroundColor: themeColors.background,
        centerTitle: true,
        title: Text(
          widget.placeID,
          style: TextStyle(
            color: themeColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05,vertical: screenHeight * 0.025),
            child: Column(
              children: [
                addVerticalSpace(screenHeight * 0.04),
                Text(
                  "Fill this fields.",
                  style: theme.textTheme.titleMedium,
                ),
                Text(
                  " And we will contact you.",
                  style: theme.textTheme.titleMedium,
                ),
                addVerticalSpace(screenHeight * 0.04),
                MyFNameTextField(controller: _firstName, error: fNameError,),
                addVerticalSpace(screenHeight * 0.04),
                MyLNameTextField(controller: _lastName, error: lNameError,),
                addVerticalSpace(screenHeight * 0.04),
                MyNumTextField(controller: _num, error: numError),
                addVerticalSpace(screenHeight * 0.06),
                MainButtonWidget(
                  content: "Book Now",
                  onPressed: () async{
                    _validateInputs();
                    if (fNameError == null && lNameError == null && numError == null){
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: themeColors.background,
                            content: Text(
                              "Confirme to book the ${widget.placeID} package",
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
                                          currentUser!.booked!.add(widget.placeID);
                                        });
                                        await userColl.doc(currentUser!.id).update({
                                          "booked": currentUser!.booked
                                        });
                                        await bookedColl.doc("${currentUser!.id}_${widget.placeID}").set(
                                            {
                                              "userID": currentUser!.id,
                                              "placeID": widget.placeID,
                                              "firstName": _firstName.text,
                                              "lastName": _lastName.text,
                                              "phone": _num.text,
                                              "date": DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000,
                                            }
                                        );
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                        showSuccessAlert(context, "Package is booked succussfully");
                                      }else {
                                        NoConnectionAlert(context);
                                      }},
                                    child: const Text(
                                      "Book",
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
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


