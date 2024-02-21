import 'package:flutter/material.dart';
import 'package:project/helping%20widgets/sizedbox_widget.dart';

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
                onTap: (){},
                child: Row(
                  children: [
                    Icon(Icons.folder,color: themeColors.surface,),
                    Text("  Choose from gallery",style: theme.textTheme.labelMedium,),
                  ],
                ),
              ),
              addVerticalSpace(10),
              InkWell(
                onTap: (){},
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
}