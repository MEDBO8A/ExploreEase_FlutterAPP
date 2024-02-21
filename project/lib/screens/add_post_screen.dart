import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/helping%20widgets/sizedbox_widget.dart';
import 'package:project/model/user.dart';

class AddPostScreen extends StatefulWidget{
  const AddPostScreen({super.key});


  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}
class _AddPostScreenState extends State<AddPostScreen>{
  UserModel? user = UserModel.current;
  TextEditingController _postController = TextEditingController();
  List<String> selectedImages = [];

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
          child: Center(
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
                            padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 5),
                            child: Stack(
                              children: [
                                Image.file(
                                  File(image),
                                  width: 130,
                                  height: 100,
                                  fit: BoxFit.fill,
                                ),
                                Positioned(
                                  top: -1,right: -1,
                                  child: InkWell(
                                    onTap: (){
                                      setState(() {
                                        selectedImages.remove(image);
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: themeColors.error,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Icon(Icons.remove_circle_outline,color: Colors.white,),
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
      ),
    );
  }

  void imagePickerPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final themeColors = Theme.of(context).colorScheme;
        final theme = Theme.of(context);
        return AlertDialog(
          backgroundColor: themeColors.background,
          title: Text('Pick your image'),
          content: SizedBox(
            height: 60,
            child: Column(
              children: [
                InkWell(
                  onTap: () async{
                    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      Navigator.of(context).pop();
                      setState(() {
                        if (!selectedImages.contains(pickedFile.path)){
                          selectedImages.add(pickedFile.path);
                        }
                        print(pickedFile.path);
                      });
                    }
                  },
                  child: Row(
                    children: [
                      Icon(Icons.folder,color: themeColors.surface,),
                      Text("  Choose from gallery",style: theme.textTheme.labelMedium,),
                    ],
                  ),
                ),
                addVerticalSpace(10),
                InkWell(
                  onTap: () async{
                    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
                    if (pickedFile != null) {
                      Navigator.of(context).pop();
                      setState(() {
                        if (!selectedImages.contains(pickedFile.path)){
                          selectedImages.add(pickedFile.path);
                        }
                        print(pickedFile.path);
                      });
                    }
                  },
                  child:Row(
                    children: [
                      Icon(Icons.camera_alt,color: themeColors.surface,),
                      Text("  Take a photo",style: theme.textTheme.labelMedium,),
                    ],
                  ),
                ),
              ],
            ),

          ),
          actions: <Widget>[
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close',style: TextStyle(color: themeColors.onSecondary),),
              ),
            ),
          ],
        );
      },
    );
  }}