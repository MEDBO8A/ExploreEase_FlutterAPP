import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/helping%20widgets/sizedbox_widget.dart';
import 'package:project/model/user.dart';
import 'package:project/screens/community_chat_screen.dart';
import 'package:project/helping%20widgets/alert_dialog.dart';
import 'package:project/services/database_services.dart';

class EditPostScreen extends StatefulWidget{
  final String content;
  final List<dynamic> images;
  final String userID;
  final int postTime;
  const EditPostScreen({super.key, required this.content, required this.images, required this.userID, required this.postTime});


  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}
class _EditPostScreenState extends State<EditPostScreen> {
  UserModel? user = UserModel.current;
  TextEditingController _postController = TextEditingController();
  List<dynamic> selectedImages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedImages = widget.images;
    _postController.text = widget.content;
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme
        .of(context)
        .colorScheme;
    final theme = Theme.of(context);
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: themeColors.background,
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.05,
        iconTheme: IconThemeData(color: themeColors.onPrimary),
        backgroundColor: themeColors.background,
        centerTitle: true,
        title: Text(
          "Edit Post",
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
                builder: (context) => const CommunityChatScreen(),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.0125, vertical: screenHeight * 0.025),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    addHorizentalSpace(10),
                    CircleAvatar(
                      backgroundImage: NetworkImage(user!.profPic),
                      radius: 25,
                    ),
                    addHorizentalSpace(15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user!.username, style: theme.textTheme.titleMedium,),
                      ],
                    ),
                  ],
                ),
                addVerticalSpace(10),
                SizedBox(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.3,
                  child: TextField(
                    controller: _postController,
                    expands: true,
                    maxLines: null,
                    // Set to null for multiline
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: themeColors.onBackground,
                      hintText: 'Write your post here...',
                      contentPadding: const EdgeInsets.only(top: 8.0, left: 5),
                      hintStyle: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                addVerticalSpace(10),
                selectedImages.isNotEmpty ?
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (final image in selectedImages)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 10),
                          child: Stack(
                            children: [
                              Image.network(
                                image,
                                width: 130,
                                height: 100,
                                fit: BoxFit.fill,
                              ),
                              Positioned(
                                top: -1, right: -1,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedImages.remove(image);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: themeColors.error,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Icon(Icons.remove_circle_outline,
                                      color: Colors.white,),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ) : Text(""),
                addVerticalSpace(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeColors.primary,
                      ),
                      onPressed: () async {
                        await DBServices().editPost(
                            widget.userID,
                            widget.postTime,
                            "content",
                            _postController.text);
                        await DBServices().editPost(
                            widget.userID,
                            widget.postTime,
                            "images",
                            selectedImages);

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CommunityChatScreen()));
                      },
                      child: const Text(
                        "Edit Post",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeColors.onSecondary,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}