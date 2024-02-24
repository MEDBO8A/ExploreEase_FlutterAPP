import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:project/helping%20widgets/sizedbox_widget.dart';
import 'package:project/model/user.dart';
import 'package:project/screens/Edit_post_screen.dart';
import 'package:project/services/database_services.dart';

class PostHeader extends StatelessWidget{
  final String userImage;
  final String userName;
  final int postTime;
  final String userID;
  final List<dynamic> images;
  final String postContent;


  const PostHeader({super.key, required this.userImage, required this.userName, required this.postTime, required this.userID, required this.images, required this.postContent});
  @override
  Widget build(BuildContext context) {
    final date =DateTime.now().toUtc();
    Duration difference = date.difference(DateTime.fromMillisecondsSinceEpoch(postTime * 1000, isUtc: true));
    int hours = difference.inHours;
    int days = difference.inDays;
    int minutes = difference.inMinutes;

    UserModel? currentUser = UserModel.current;

    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
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
                Text(
                  days!=0 ? " ${days}d ago" : hours!=0 ? " ${hours}h ago" : " ${minutes}m ago" ,
                  style: const TextStyle(color: Colors.grey,fontSize: 13),),
              ],
            ),
          ],
        ),
        userID == currentUser!.id ? PopupMenuButton(
          iconColor: theme.colorScheme.surface,
          offset: Offset(-40, 0),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: theme.colorScheme.background,
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'Modify Post',
              child: InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditPostScreen(
                    userID: userID,
                    postTime: postTime,
                    images: images,
                    content: postContent,
                  )));
                },
                child: Text("Modify Post",style: TextStyle(color: theme.colorScheme.surface),),
              ),
            ),
            PopupMenuItem<String>(
              value: 'Delete Post',
              child: InkWell(
                onTap: (){
                  deleteDialog(context);
                },
                child: Text("Delete Post",style: TextStyle(color: theme.colorScheme.surface),),
              ),
            ),
          ],
        ):Text(""),
      ],
    );
  }

  void deleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return AlertDialog(
          backgroundColor: theme.colorScheme.background,
          content: Text(
            "Confirm to delete post",
            style: TextStyle(
              color: theme.colorScheme.surface,
              fontSize: 18,
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                  ),
                  onPressed: () async{
                    await DBServices().deletePost(userID, postTime);
                    Navigator.of(context).pop();
                    for(var i=0 ; i < images.length ; i++){
                      await FirebaseStorage.instance
                          .ref()
                          .child('post_images')
                          .child('${userID}_${postTime}_${i}.jpg').delete();
                    }
                    },
                  child: const Text(
                    "Delete",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.onSecondary,
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
        );
      },
    );
  }
}
