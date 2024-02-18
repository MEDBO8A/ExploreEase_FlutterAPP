import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> getPopular() async {
  final CollectionReference packageCollection =
  FirebaseFirestore.instance.collection('packages');
  final CollectionReference popPackCollection =
  FirebaseFirestore.instance.collection('popular');

  // Delete existing documents in the 'popular' collection
  await popPackCollection.get().then((snapshot) {
    for (DocumentSnapshot doc in snapshot.docs) {
      doc.reference.delete();
    }
  });

  // Retrieve documents from the 'packages' collection
  final QuerySnapshot packageSnapshot = await packageCollection.get();

  if (packageSnapshot.docs.isNotEmpty) {
    // Convert the QuerySnapshot to a List<DocumentSnapshot>
    List dataList = packageSnapshot.docs;

    // Sort the list based on the 'rate' property in descending order
    dataList.sort(
          (a, b) => (b.data()!['rate'] as num).compareTo(a.data()!['rate'] as num),
    );

    // Set the top 5 documents in the 'popular' collection without changing the key
    for (int i = 0; i < dataList.length && i < 5; i++) {
      final String placeID = dataList[i].id;
      final Map<String, dynamic> packageData = dataList[i].data()! as Map<String, dynamic>;
      await popPackCollection.doc(placeID).set(packageData);
    }
  }
}