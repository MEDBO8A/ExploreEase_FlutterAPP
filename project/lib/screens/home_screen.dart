import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/profile_screen.dart';
import 'package:project/screens/sign_in_screen.dart';

import '../components/categories/box_categorie_widget.dart';
import '../components/categories/list_categories.dart';
import '../components/countries/list_countries.dart';
import '../components/forums/text_fields.dart';
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
        setState(() {
          userdata = userRes;
          UserModel.current = userRes;
        });
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
              icon: const Icon(Icons.arrow_back),
              ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              child: CircleAvatar(
                radius: 20,
                backgroundImage:
                userdata != null ? NetworkImage(userdata!.profPic) : null,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MyProfileScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Hello, ${userdata?.username}",
              style: theme.textTheme.titleLarge,
            ),
            Text(
              "Explore the beauty of the world ",
              style: theme.textTheme.bodyLarge,
            ),
            MySearchTextField(),
            Text(
              "Categories",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 2
              ),
            ),
            CategoriesList(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Countries",
                  style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      show = !show;
                    });
                  },
                  child: Text(
                    show ? "See Less" : "See All",
                  ),
                ),
              ],
            ),
            CountriesList(show: show),
            Text(
              "Popular",
              style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2
              ),
            ),
          ],
        ),
      ),
    );
  }
}