import 'package:flutter/material.dart';
import 'package:project/components/community%20chat/post/post_content.dart';
import 'package:project/components/community%20chat/post/post_footer.dart';
import 'package:project/components/community%20chat/post/post_header.dart';
import 'package:project/helping%20widgets/sizedbox_widget.dart';

class PostWidget extends StatefulWidget{
  final String userImage;
  final String userName;
  final int postTime;
  final String postContent;
  final List<dynamic> lovesList;
  final List<dynamic> images;
  final String userID;

  const PostWidget({
    super.key,
    required this.userImage,
    required this.userName,
    required this.postTime,
    required this.postContent,
    required this.images, required this.userID, required this.lovesList,
  });


  @override
  _PostWidgetState createState() => _PostWidgetState();
}
class _PostWidgetState extends State<PostWidget>{

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: themeColors.onBackground,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          PostHeader(postContent: widget.postContent, images: widget.images, userID: widget.userID, postTime: widget.postTime, userImage: widget.userImage, userName: widget.userName),
          addVerticalSpace(10),
          PostContent(images: widget.images, postContent: widget.postContent),
          addVerticalSpace(10),
          PostFooter(userID: widget.userID, lovesList: widget.lovesList, postTime: widget.postTime),
        ],
      ),
    );
  }
}