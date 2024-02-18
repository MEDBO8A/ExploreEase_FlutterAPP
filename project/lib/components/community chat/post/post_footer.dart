import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/helping%20widgets/sizedbox_widget.dart';
import 'package:project/model/user.dart';

class PostFooter extends StatelessWidget{
  final int loves;
  final int likes;

  const PostFooter({super.key, required this.loves, required this.likes});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(5),
          child: Icon(Icons.favorite,color: Colors.white,size: 20,),
        ),
        Text(" $loves"),
        addHorizentalSpace(20),
        Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(5),
          child: Icon(Icons.thumb_up,color: Colors.white,size: 20,),
        ),
        Text(" $likes"),
      ],
    );
  }
}