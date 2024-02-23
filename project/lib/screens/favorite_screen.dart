import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/package/box_package_widget.dart';
import '../model/user.dart';
import '../services/alert_dialog.dart';

class MyFavoriteScreen extends StatefulWidget {
  const MyFavoriteScreen({super.key});

  @override
  State<MyFavoriteScreen> createState() => _MyFavoriteScreenState();
}

class _MyFavoriteScreenState extends State<MyFavoriteScreen> {
  UserModel currentUser = UserModel.current!;
  final CollectionReference packagesCollection =
  FirebaseFirestore.instance.collection('packages');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: themeColors.background,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.05,
        iconTheme: IconThemeData(color: themeColors.onPrimary),
        backgroundColor: themeColors.background,
        centerTitle: true,
        title: Text(
          "Favorite",
          style: TextStyle(
            color: themeColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: packagesCollection
            .where('placeID', whereIn: currentUser.favorite ?? [])
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator.adaptive();
          }

          if (snapshot.hasError) {
            return showErrorAlert(context, snapshot.error.toString());
          }

          List<QueryDocumentSnapshot> favoritePackages =
              snapshot.data!.docs;

          if (favoritePackages.isNotEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05,vertical: screenHeight * 0.025),
              child: ListView.builder(
                itemCount: favoritePackages.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data =
                  favoritePackages[index].data() as Map<String, dynamic>;

                  return PackageBox(
                    page: 3,
                    placeID: data["placeID"] ?? "",
                    name: data["placeName"] ?? "",
                    city: data["city"] ?? "",
                    country: data["country"] ?? "",
                    image: data["imageUrl"] ?? "",
                    rate: data["rate"] ?? 0,
                    rateNB: data["rateNB"] ?? 0,
                    price: data["price"] ?? 0,
                    onFavoriteChanged: () {
                      setState(() {});
                    },
                  );
                },
              ),
            );
          } else {
            return Center(
              child: Text("You don't have a favorite package",style: theme.textTheme.titleMedium,),
            );
          }
        },
      ),
    );
  }
}
