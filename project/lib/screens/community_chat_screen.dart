import 'package:flutter/material.dart';
import 'package:project/helping%20widgets/sizedbox_widget.dart';
import 'package:project/model/user.dart';

import '../components/community chat/post/post_widget.dart';

class CommunityChatScreen extends StatefulWidget{
  const CommunityChatScreen({super.key});


  @override
  _CommunityChatScreenState createState() => _CommunityChatScreenState();
}
class _CommunityChatScreenState extends State<CommunityChatScreen>{
  UserModel? user = UserModel.current;

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: themeColors.background,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.05,
        iconTheme: IconThemeData(color: themeColors.onPrimary),
        backgroundColor: themeColors.background,
        centerTitle: true,
        title: Text(
          "Community Chat",
          style: TextStyle(
            color: themeColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5,),
        child: Column(
          children: [
            PostWidget(
              images: [user!.profPic],
              likes: 1,
              loves: 2,
              postContent: "HELLLOOOO",
              postTime: "1d",
              userImage: user!.profPic,
              userName: user!.username,
            ),
            addVerticalSpace(10),
            addVerticalSpace(10),
          ],
        ),
      ),
    );
  }
}