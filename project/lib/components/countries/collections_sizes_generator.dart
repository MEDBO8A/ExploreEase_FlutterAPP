import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CountryWidget extends StatefulWidget {
  final CollectionReference collection;

  const CountryWidget({super.key, required this.collection});

  @override
  _CountryWidgetState createState() => _CountryWidgetState();
}

class _CountryWidgetState extends State<CountryWidget> {
  num size = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    QuerySnapshot querySnapshot = await widget.collection.get();
    setState(() {
      size = querySnapshot.size;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "$size packages",
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 13,
        color: Colors.white,
      ),
    );
  }
}