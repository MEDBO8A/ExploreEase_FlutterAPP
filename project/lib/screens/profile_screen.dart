import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project/screens/home_screen.dart';
import '../helping widgets/loading_widget.dart';
import '../helping widgets/sizedbox_widget.dart';
import '../model/user.dart';
import '../services/database_services.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final Color navyBlue = const Color(0xFF000080);

  UserModel? user = UserModel.current;
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('user');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.05,
        iconTheme: IconThemeData(color: themeColors.onPrimary),
        backgroundColor: themeColors.background,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(
            color: themeColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyHomeScreen(),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.0125),
        child: Container(
          color: themeColors.background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              addVerticalSpace(screenHeight * 0.03),
              Stack(
                children: [
                  Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          user!.profPic,
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    right: -5,
                    child: IconButton(
                      onPressed: () {
                        selectAndUploadImage();
                      },
                      icon: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: themeColors.background,
                            width: 4,
                          ),
                          color: themeColors.primary,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: themeColors.surface,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              addVerticalSpace(screenHeight * 0.02),
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user!.username,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: themeColors.surface,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          showEditField(context, "username");
                        },
                        icon: Icon(
                          Icons.create_outlined,
                          size: 15,
                          color: themeColors.surface,
                        ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user!.bio,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: themeColors.surface,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          showEditField(context, "bio");
                        },
                        icon: Icon(
                          Icons.create_outlined,
                          size: 15,
                          color: themeColors.surface,
                        ))
                  ],
                ),
              ),
              addVerticalSpace(screenHeight * 0.02),
              Container(
                width: screenWidth,
                height: screenHeight * 0.8,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  color: themeColors.onBackground,
                ),
                child: Column(
                  children: [
                    addVerticalSpace(screenHeight * 0.01),
                    Text(
                      "Booked Packages",
                      style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2
                      ),
                    ),
                    addVerticalSpace(screenHeight * 0.01),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectAndUploadImage() async {
    final imagePicker = ImagePicker();

    final XFile? image =
    await imagePicker.pickImage(source: ImageSource.gallery);

    loading(context);

    if (image != null) {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('${user!.id}.jpg');

      await ref.putFile(File(image.path));

      String imageUrl = await ref.getDownloadURL();

      final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('user');
      await usersCollection.doc(user!.id).update({'profPic': imageUrl});

    }
    final userr = await DBServices().getUser(user!.id);
    setState(() {
      user = userr;
    });
    Navigator.pop(context);

  }

  Future showEditField(BuildContext context, String field) async {
    final themeColors = Theme.of(context).colorScheme;
    TextEditingController textController = TextEditingController();
    String newValue = "";

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit $field"),
        content: TextField(
          controller: textController,
          onChanged: (e) {
            newValue = e;
          },
          decoration: const InputDecoration(
            hintText: "Enter new value here",
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: themeColors.primary,
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              if (newValue.trim().isNotEmpty){
                await usersCollection.doc(user!.id).update({field:newValue});

                final userr = await DBServices().getUser(user!.id);
                setState(() {
                  user = userr;
                });
              }
            },
            child: const Text(
              "Edit",
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
    );

  }
}
