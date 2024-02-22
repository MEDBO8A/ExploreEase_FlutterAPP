import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user.dart';

class DBServices {
  final CollectionReference _userCollection =
  FirebaseFirestore.instance.collection("user");

  final CollectionReference _postCollection =
  FirebaseFirestore.instance.collection("post");



  Future<bool> savePost(Map<String, dynamic> post, String userID,int time) async {
    try {

      await _postCollection.doc("$userID-$time").set(post);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deletePost(String userID,DateTime time) async {
    try {

      await _postCollection.doc("$userID-$time").delete();

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> editPost(String userID,DateTime time) async {
    try {

      await _postCollection.doc("$userID-$time").delete();

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }



  Future<bool> saveUser(UserModel user) async {
    try {
      if (await getUser(user.id) != null) {
        return false;
      }

      final Map<String, dynamic> userMap = user.toMap();

      await _userCollection.doc(user.id).set(userMap);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel?> getUser(String id) async {
    try {
      final DocumentSnapshot userDoc = await _userCollection.doc(id).get();

      if (userDoc.exists) {
        final user =
        UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
        return user;
      }

      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }


}
