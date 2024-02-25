import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/helping%20widgets/connection_alerts.dart';
import 'package:project/helping%20widgets/sizedbox_widget.dart';
import 'package:project/screens/profile_screen.dart';
import 'package:project/services/connectivity_services.dart';
import '../components/categories/list_categories.dart';
import '../components/countries/list_countries.dart';
import '../components/forums/text_fields.dart';
import '../components/navigationDrawer.dart';
import '../components/popular packages/list_packages.dart';
import '../model/user.dart';
import '../services/auth_services.dart';
import '../services/database_services.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  AuthServices auth = AuthServices();
  UserModel? userdata;
  bool show = false;

  bool isConnected = true;

  @override
  void initState() {
    super.initState();
    getUser();
    ConnectivityServices().getConnectivity().then((value) {
      setState(() {
        isConnected = value;
      });
    });
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              child: isConnected?
              CircleAvatar(
                radius: 20,
                backgroundImage:
                userdata != null ?
                NetworkImage(userdata!.profPic,) :
                null,
              ):
              Icon(
                Icons.error,
                color: themeColors.error,
                size: 30,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MyProfileScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025,vertical: screenHeight * 0.025),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            addVerticalSpace(screenHeight * 0.025),
            Text(
              "Hello, ${userdata?.username == null ? "..." : userdata?.username}",
              style: theme.textTheme.titleLarge,
            ),
            Text(
              "Explore the beauty of the world ",
              style: theme.textTheme.bodyLarge,
            ),
            addVerticalSpace(screenHeight * 0.04),
            Text(
              "Categories",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 2
              ),
            ),
            addVerticalSpace(screenHeight * 0.02),
            const CategoriesList(),
            addVerticalSpace(screenHeight * 0.04),
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
            addVerticalSpace(screenHeight * 0.02),
            CountriesList(show: show),
            addVerticalSpace(screenHeight * 0.04),
            Text(
              "Popular",
              style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2
              ),
            ),
            addVerticalSpace(screenHeight * 0.02),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.98,
              height: MediaQuery.of(context).size.height * 0.11,
              child: isConnected?
              const PopularPacksList():
                  const NoConnectionRow(),
            ),
          ],
        ),
      ),
    );
  }
}