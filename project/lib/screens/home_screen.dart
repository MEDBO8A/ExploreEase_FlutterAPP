import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/sign_in_screen.dart';

import '../components/navigationDrawer.dart';
import '../model/user.dart';
import '../services/authServices.dart';
import '../services/dataBaseServices.dart';

class MyHomeScreen extends StatefulWidget {
  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  AuthServices auth = AuthServices();
  UserModel? userdata;
  bool show = false;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userRes = await DBServices().getUser(user.uid);

        if (userRes != null) {
          setState(() {
            userdata = userRes;
            UserModel.current = userRes;
          });
        } else {
          print("User data from DB is null.");
        }
      }
    } catch (e) {
      print("Error getting user: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: themeColors.background,
      drawer: NavigationDrawerBar(),
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.05,
        iconTheme: IconThemeData(color: themeColors.onPrimary),
        backgroundColor: themeColors.background,
        centerTitle: true,
        title: Text(
          "Explore Ease",
          style: TextStyle(
            color: themeColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await auth.signOut();
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MySignInScreen(),
                  ),
                );
              },
              icon: Icon(Icons.arrow_back),
              ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              child: CircleAvatar(
                radius: 20,
                backgroundImage:
                userdata != null ? NetworkImage(userdata!.profPic) : null,
              ),
              onTap: () {
                /*Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MyProfilePage(),
                  ),
                );*/
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(
          vertical: 40,
          horizontal: 20,
        ),
        child: Center(
          child: Column(
            children: [
              Text("HElllooo")
            ],
          ),
        ),
      ),
    );
  }
}