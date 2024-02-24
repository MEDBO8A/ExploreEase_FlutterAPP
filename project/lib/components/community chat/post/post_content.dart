import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:project/helping%20widgets/sizedbox_widget.dart';

class PostContent extends StatefulWidget {
  final String postContent;
  final List<dynamic> images;

  const PostContent({Key? key, required this.postContent, required this.images}) : super(key: key);

  @override
  _PostContentState createState() => _PostContentState();
}

class _PostContentState extends State<PostContent> {
  int _selectedImage=0;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return widget.images.isEmpty? Text(widget.postContent,style: theme.textTheme.labelMedium,) : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(widget.postContent,style: theme.textTheme.labelMedium,),
        addVerticalSpace(5),
        SizedBox(
          width: double.infinity,
          height: 200,
          child: PhotoViewGallery.builder(
            itemCount: widget.images.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(widget.images[index]),
                minScale: PhotoViewComputedScale.contained * 0.8,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            scrollPhysics: BouncingScrollPhysics(),
            backgroundDecoration: BoxDecoration(color: Colors.transparent),
            pageController: PageController(),
            onPageChanged: (index){
              setState(() {
                _selectedImage = index;
              });
            },
          ),
        ),
        Center(
          child: DotsIndicator(
            dotsCount: widget.images.length,
            position: _selectedImage,
            decorator: DotsDecorator(
              color: Colors.grey, // Inactive dot color
              activeColor: theme.colorScheme.onSecondary, // Active dot color
            ),
          ),
        ),
      ],
    );
  }
}