import 'package:flutter/material.dart';


class PostContent extends StatelessWidget{
  final String postContent;
  final List<String> images;

  const PostContent({super.key, required this.postContent, required this.images});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
              margin: const EdgeInsets.all(8),
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