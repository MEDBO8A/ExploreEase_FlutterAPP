import 'package:flutter/material.dart';
import 'package:project/helping%20widgets/sizedbox_widget.dart';

class PostHeader extends StatelessWidget{
  final String userImage;
  final String userName;
  final String postTime;

  const PostHeader({super.key, required this.userImage, required this.userName, required this.postTime});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
            Text(postTime,style: const TextStyle(color: Colors.grey,fontSize: 13),),
          ],
        ),
      ],
    );
  }
}