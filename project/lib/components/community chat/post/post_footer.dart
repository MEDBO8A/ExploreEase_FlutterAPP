import 'package:flutter/material.dart';
import 'package:project/helping%20widgets/sizedbox_widget.dart';
import 'package:project/services/dataBaseServices.dart';

import '../../../model/user.dart';

class PostFooter extends StatefulWidget {
  final List<dynamic> lovesList;
  final int postTime;
  final String userID;

  const PostFooter({super.key, required this.lovesList, required this.postTime, required this.userID});

  @override
  _PostFooterState createState() => _PostFooterState();
}

class _PostFooterState extends State<PostFooter> {
  UserModel? currentUser = UserModel.current;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        InkWell(
          onTap: () async{
            if (widget.lovesList.contains(currentUser!.id)){
              setState(() {
                widget.lovesList.remove(currentUser!.id);
              });
            }else{
              setState(() {
                widget.lovesList.add(currentUser!.id);
              });
            }
            DBServices().editPost(
                widget.userID,
                widget.postTime,
                "lovesList",
                widget.lovesList
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(5),
            child: const Icon(Icons.favorite,color: Colors.white,size: 20,),
          ),
        ),
        Text(" ${widget.lovesList.length}",style: theme.textTheme.labelMedium,),
      ],
    );
  }
}