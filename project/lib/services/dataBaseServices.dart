import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user.dart';

class DBServices {
  final CollectionReference _userCollection =
  FirebaseFirestore.instance.collection("user");

  Future<bool> saveUser(UserModel user) async {
    try {
      // Check if user with the same ID already exists
      if (await getUser(user.id) != null) {
        return false; // User with the same ID already exists
      }

      // Convert UserModel to a Map
      final Map<String, dynamic> userMap = user.toMap();

      // Save user to Firestore with a document ID equal to the user's ID
      await _userCollection.doc(user.id).set(userMap);

      return true; // User saved successfully
    } catch (e) {
      print(e);
      return false; // Error saving user
    }
  }

  Future<UserModel?> getUser(String id) async {
    try {
      // Get user from Firestore with a document ID equal to the user's ID
      final DocumentSnapshot userDoc = await _userCollection.doc(id).get();

      if (userDoc.exists) {
        final user =
        UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
        return user;
      }

      return null; // User not found
    } catch (e) {
      print(e);
      return null; // Error getting user
    }
  }
}
