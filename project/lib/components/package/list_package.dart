import 'package:flutter/material.dart';
import 'package:project/components/package/list_view_package.dart';
import 'package:project/screens/home_screen.dart';

class MyPackagesList extends StatefulWidget {
  final String value;
  const MyPackagesList({super.key, required this.value});

  @override
  State<MyPackagesList> createState() => _PackagesState();
}

class _PackagesState extends State<MyPackagesList> {
  final themes = ["Beach", "Desert", "Historic", "Island", "Mount"];

  content() {
    if (widget.value == "U.A.E") {
      return MyListView(packName: "country_UAE",page: 2,);
    }
    if (themes.contains(widget.value)) {
      return MyListView(packName: "package_${widget.value.toLowerCase()}",page: 1,);
    } else {
      return MyListView(packName: "country_${widget.value.toLowerCase()}",page: 2,);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.05,
        iconTheme: IconThemeData(color: themeColors.onPrimary),
        backgroundColor: themeColors.background,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "${widget.value} Packages",
          style: TextStyle(
            color: themeColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyHomeScreen(),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15,),
        child: content(),
      ),
    );
  }
}
