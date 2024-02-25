import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../model/user.dart';
import 'box_booked_widget.dart';

class BookedpackagesList extends StatefulWidget {
  BookedpackagesList({super.key});

  @override
  State<BookedpackagesList> createState() => _BookedpackagesListState();
}

class _BookedpackagesListState extends State<BookedpackagesList> {
  UserModel currentUser = UserModel.current!;

  final CollectionReference packagesCollection =
  FirebaseFirestore.instance.collection('packages');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return StreamBuilder<QuerySnapshot>(
      stream: packagesCollection
          .where('placeID', whereIn: currentUser.booked ?? [])
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
            ),
          );
        }

        final documents = snapshot.data!.docs;
        List<Map<String, dynamic>> dataList = [];
        for (var doc in documents) {
          dataList.add(doc.data()! as Map<String, dynamic>);
        }

        return ListView(
          scrollDirection: Axis.vertical,
          children: dataList.map((data) {
            return BookedPackageBox(
              placeID: data['placeID']?? "",
              name: data['placeName'],
              city: data['city'],
              country: data['country'],
              image: data['imageUrl'],
              rate: data['rate'],
              rateNB: data['rateNB'],
              price: data['price'],
              onDelete: () {
                setState(() {});
              },
            );
          }).toList(),
        );
      },
    );
  }
}
