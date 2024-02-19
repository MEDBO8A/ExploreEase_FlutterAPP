import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'box_popular_widget.dart';

class PopularPacksList extends StatelessWidget {
  const PopularPacksList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('popular').snapshots(),
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

        // Create a list of objects
        List<Map<String, dynamic>> dataList = [];

        // Populate the list with document data
        for (var doc in documents) {
          dataList.add(doc.data()! as Map<String, dynamic>);
        }

        // Sort the list based on the 'rate' attribute in descending order
        dataList.sort((a, b) =>
            (b['rate'] as num).compareTo(a['rate'] as num));

        return ListView(
          scrollDirection: Axis.horizontal,
          children: dataList.map((data) {
            return PopularPackageBox(
              placeID: data['placeID']?? "",
              name: data['placeName'],
              city: data['city'],
              country: data['country'],
              image: data['imageUrl'],
              rate: data['rate'],
              rateNB: data['rateNB'],
              price: data['price'],
            );
          }).toList(),
        );
      },
    );
  }
}
