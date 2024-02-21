import 'package:flutter/material.dart';
import 'package:project/components/package/package%20screen%20components/package_online_details.dart';
import 'package:project/helping%20widgets/sizedbox_widget.dart';
import 'package:project/model/user.dart';

import '../components/community chat/post/images_picker/image_picker_popup.dart';
import '../components/community chat/post/post_widget.dart';

class AddPostScreen extends StatefulWidget{
  const AddPostScreen({super.key});


  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}
class _AddPostScreenState extends State<AddPostScreen>{
  UserModel? user = UserModel.current;
  TextEditingController _postController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: themeColors.background,
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.05,
        iconTheme: IconThemeData(color: themeColors.onPrimary),
        backgroundColor: themeColors.background,
        centerTitle: true,
        title: Text(
          "Create Post",
          style: TextStyle(
            color: themeColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10,),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user!.profPic),
                    radius: 25,
                  ),
                  addHorizentalSpace(15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user!.username,style: theme.textTheme.titleMedium,),
                    ],
                  ),
                ],
              ),
              addVerticalSpace(10),
              Stack(
                children: [
                  SizedBox(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.3,
                    child: TextField(
                      controller: _postController,
                      expands: true,
                      maxLines: null, // Set to null for multiline
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: themeColors.onBackground,
                        hintText: 'Write your post here...',
                        contentPadding: const EdgeInsets.only(top: 8.0,left: 5),
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: InkWell(
                      onTap: () {
                        imagePickerPopup(context);
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.image,
                            color: Colors.grey,
                          ),
                          Text(" Add Photos",style: TextStyle(color: Colors.grey),)
                        ],
                      ),
                    ),
                  )
                ],
              ),
              addVerticalSpace(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeColors.primary,
                      ),
                      onPressed: () {

                      },
                      child: const Text(
                        "Share Post",
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
    );
  }
}