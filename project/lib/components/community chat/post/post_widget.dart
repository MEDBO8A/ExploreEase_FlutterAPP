import 'package:flutter/material.dart';
import 'package:project/components/community%20chat/post/post_content.dart';
import 'package:project/components/community%20chat/post/post_footer.dart';
import 'package:project/components/community%20chat/post/post_header.dart';
import 'package:project/helping%20widgets/sizedbox_widget.dart';

import '../../../services/database_services.dart';

class PostWidget extends StatefulWidget{
  final int postTime;
  final String postContent;
  final List<dynamic> lovesList;
  final List<dynamic> images;
  final String userID;

  const PostWidget({
    super.key,
    required this.postTime,
    required this.postContent,
    required this.images, required this.userID, required this.lovesList,
  });


  @override
  _PostWidgetState createState() => _PostWidgetState();
}
class _PostWidgetState extends State<PostWidget>{

  late String userImage = "";
  late String userName = "";

  getInfo() async{
    final userRes = await DBServices().getUser(widget.userID);
    setState(() {
      userName = userRes!.username;
      userImage = userRes!.profPic;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfo();
  }

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
          PostHeader(postContent: widget.postContent, images: widget.images, userID: widget.userID, postTime: widget.postTime, userImage: userImage, userName: userName),
          addVerticalSpace(10),
          PostContent(images: widget.images, postContent: widget.postContent),
          addVerticalSpace(10),
          PostFooter(userID: widget.userID, lovesList: widget.lovesList, postTime: widget.postTime),
        ],
      ),
    );
  }
}