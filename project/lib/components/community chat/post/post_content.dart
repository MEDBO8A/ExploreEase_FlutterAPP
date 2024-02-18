import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/helping%20widgets/sizedbox_widget.dart';
import 'package:project/model/user.dart';

class PostContent extends StatelessWidget{
  final String postContent;
  final List<String> images;

  const PostContent({super.key, required this.postContent, required this.images});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(postContent,style: theme.textTheme.labelMedium,),
        ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(8),
              child: Image.network(
                images[index],
                width: 100,
                fit: BoxFit.cover, // Adjust the BoxFit property as needed
              ),
            );
          },
        ),
      ],
    );
  }
}