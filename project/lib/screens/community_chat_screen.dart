import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/model/user.dart';
import 'package:project/screens/add_post_screen.dart';
import '../components/community chat/post/post_widget.dart';
import '../services/alert_dialog.dart';
import 'home_screen.dart';

class CommunityChatScreen extends StatefulWidget{
  const CommunityChatScreen({super.key});


  @override
  _CommunityChatScreenState createState() => _CommunityChatScreenState();
}
class _CommunityChatScreenState extends State<CommunityChatScreen>{
  UserModel? user = UserModel.current;
  final CollectionReference _postCollection =
  FirebaseFirestore.instance.collection("post");

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
          "Community chat",
          style: TextStyle(
            color: themeColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyHomeScreen(),
              ),
            );
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _postCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator.adaptive();
          }

          if (snapshot.hasError) {
            return showErrorAlert(context, snapshot.error.toString());
          }

          List<QueryDocumentSnapshot> post = snapshot.data!.docs;
          List<QueryDocumentSnapshot> posts = post.reversed.toList();

          if (posts.isNotEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0125,vertical: screenHeight * 0.0125),
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data =
                  posts[index].data() as Map<String, dynamic>;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: PostWidget(
                      userID: data["userID"],
                      userName: data["userName"],
                      userImage: data["userImage"],
                      postTime: data["time"],
                      postContent: data["content"],
                      lovesList: data["lovesList"],
                      images: data["images"],
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(
              child: Text("No Posts Yet",style: theme.textTheme.titleMedium,),
            );
          }
        },
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