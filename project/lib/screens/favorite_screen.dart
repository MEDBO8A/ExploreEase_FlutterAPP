import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore_ease/components/boxes.dart';
import 'package:explore_ease/model/user.dart';
import 'package:explore_ease/pages/home_page.dart';
import 'package:explore_ease/services/alert_dialog.dart';
import 'package:flutter/material.dart';

class MyFavoritePage extends StatefulWidget {
  const MyFavoritePage({super.key});

  @override
  State<MyFavoritePage> createState() => _MyFavoritePageState();
}

class _MyFavoritePageState extends State<MyFavoritePage> {
  Color navyBlue = const Color(0xFF000080);
  UserModel currentUser = UserModel.current!;
  final CollectionReference packagesCollection =
  FirebaseFirestore.instance.collection('packages');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.05,
        iconTheme: const IconThemeData(color: Colors.black87),
        backgroundColor: Colors.white60,
        centerTitle: true,
        title: Text(
          "Favorite",
          style: TextStyle(
            color: navyBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyHomePage(),
              ),
            );
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: packagesCollection
            .where('placeID', whereIn: currentUser.favorite ?? [])
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator.adaptive();
          }

          if (snapshot.hasError) {
            return showErrorAlert(context, snapshot.error.toString());
          }

          List<QueryDocumentSnapshot> favoritePackages =
              snapshot.data!.docs;

          if (favoritePackages.isNotEmpty) {
            return ListView.builder(
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
            );
          } else {
            return const Center(
              child: Text("You don't have a favorite package"),
            );
          }
        },
      ),
    );
  }
}
