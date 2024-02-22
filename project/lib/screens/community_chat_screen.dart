import 'package:flutter/material.dart';
import 'package:project/components/package/package%20screen%20components/package_online_details.dart';
import 'package:project/helping%20widgets/sizedbox_widget.dart';
import 'package:project/model/user.dart';
import 'package:project/screens/add_post_screen.dart';

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
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0125,vertical: screenHeight * 0.025),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              PostWidget(
                images: [user!.profPic,"https://images.ctfassets.net/hrltx12pl8hq/28ECAQiPJZ78hxatLTa7Ts/2f695d869736ae3b0de3e56ceaca3958/free-nature-images.jpg?fit=fill&w=1200&h=630",
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxZW-wnB1vGGGdKKzlvF92PsrnZV8Kx0-v1-CwXq5Hbw&s",],
                likes: 1,
                loves: 2,
                postContent: "HELLLOOOO",
                postTime: "1d",
                userImage: user!.profPic,
                userName: user!.username,
              ),
              addVerticalSpace(10),
              PostWidget(
                images: [],
                likes: 3,
                loves: 2,
                postContent: "BA8BOUGHAAAAAAAA",
                postTime: "1d",
                userImage: user!.profPic,
                userName: user!.username,
              ),
              addVerticalSpace(10),
              PostWidget(
                images: ["https://images.ctfassets.net/hrltx12pl8hq/28ECAQiPJZ78hxatLTa7Ts/2f695d869736ae3b0de3e56ceaca3958/free-nature-images.jpg?fit=fill&w=1200&h=630",
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxZW-wnB1vGGGdKKzlvF92PsrnZV8Kx0-v1-CwXq5Hbw&s",],
                likes: 1,
                loves: 2,
                postContent: "HELLLOOOO",
                postTime: "1d",
                userImage: user!.profPic,
                userName: user!.username,
              ),
              PostWidget(
                images: ["https://images.ctfassets.net/hrltx12pl8hq/28ECAQiPJZ78hxatLTa7Ts/2f695d869736ae3b0de3e56ceaca3958/free-nature-images.jpg?fit=fill&w=1200&h=630",
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxZW-wnB1vGGGdKKzlvF92PsrnZV8Kx0-v1-CwXq5Hbw&s",],
                likes: 1,
                loves: 2,
                postContent: "HELLLOOOO",
                postTime: "1d",
                userImage: user!.profPic,
                userName: user!.username,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddPostScreen(),),);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.add,color: Colors.white,),
                Text(" Add Post",style: theme.textTheme.labelMedium!.copyWith(color: Colors.white),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}