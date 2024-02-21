import 'package:flutter/material.dart';
import 'package:project/helping%20widgets/sizedbox_widget.dart';

class PostFooter extends StatelessWidget{
  final int loves;
  final int likes;

  const PostFooter({super.key, required this.loves, required this.likes});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(5),
          child: const Icon(Icons.favorite,color: Colors.white,size: 20,),
        ),
        Text(" $loves",style: theme.textTheme.labelMedium,),
        addHorizentalSpace(20),
        Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(5),
          child: const Icon(Icons.thumb_up,color: Colors.white,size: 20,),
        ),
        Text(" $likes",style: theme.textTheme.labelMedium,),
      ],
    );
  }
}