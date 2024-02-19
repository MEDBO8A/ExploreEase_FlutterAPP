import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'box_package_widget.dart';

class MyListView extends StatelessWidget {
  final String packName;
  final int page;

  const MyListView({
    super.key,
    required this.packName,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    final CollectionReference collection =
    FirebaseFirestore.instance.collection(packName);
    final theme = Theme.of(context);
    final themeColors = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<QuerySnapshot>(
      stream: collection.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

        return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> data = documents[index].data()! as Map<
                String,
                dynamic>;

            return PackageBox(
              page: page,
              placeID: data["placeID"] ?? "",
              name: data["placeName"] ?? "",
              city: data["city"] ?? "",
              country: data["country"] ?? "",
              image: data["imageUrl"] ?? "",
              rate: data["rate"] ?? 0,
              rateNB: data["rateNB"] ?? 0,
              price: data["price"] ?? 0,
            );
          },
        );
      },
    );
  }
}
