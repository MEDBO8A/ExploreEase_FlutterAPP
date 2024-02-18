import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/helping%20widgets/sizedbox_widget.dart';
import 'package:project/model/user.dart';

class PostHeader extends StatelessWidget{
  final String userImage;
  final String userName;
  final String postTime;

  const PostHeader({super.key, required this.userImage, required this.userName, required this.postTime});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(userImage),
          radius: 25,
        ),
        addHorizentalSpace(15),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(userName,style: theme.textTheme.titleMedium,),
            Text(postTime,style: TextStyle(color: Colors.grey,fontSize: 13),),
          ],
        ),
      ],
    );
  }
}