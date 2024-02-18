import 'package:flutter/material.dart';
import 'package:project/components/community%20chat/post/post_content.dart';
import 'package:project/components/community%20chat/post/post_footer.dart';
import 'package:project/components/community%20chat/post/post_header.dart';
import 'package:project/helping%20widgets/sizedbox_widget.dart';

class PostWidget extends StatefulWidget{
  final String userImage;
  final String userName;
  final String postTime;
  final String postContent;
  final int loves;
  final int likes;
  final List<String> images;

  const PostWidget({
    super.key,
    required this.userImage,
    required this.userName,
    required this.postTime,
    required this.postContent,
    required this.loves,
    required this.likes,
    required this.images,
  });


  @override
  _PostWidgetState createState() => _PostWidgetState();
}
class _PostWidgetState extends State<PostWidget>{

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: themeColors.onBackground,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          PostHeader(postTime: widget.postTime,userImage: widget.userImage,userName: widget.userName),
          addVerticalSpace(10),
          PostContent(images: widget.images,postContent: widget.postContent),
          addVerticalSpace(10),
          PostFooter(likes: widget.likes,loves: widget.loves),
        ],
      ),
    );
  }
}