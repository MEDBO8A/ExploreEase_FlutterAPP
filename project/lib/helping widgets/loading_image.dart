import 'package:flutter/material.dart';

class ImageWithLoadingIndicator extends StatefulWidget {
  final String imageUrl;
  final double height;
  final double width;

  const ImageWithLoadingIndicator({Key? key, required this.imageUrl, required this.height, required this.width}) : super(key: key);

  @override
  _ImageWithLoadingIndicatorState createState() => _ImageWithLoadingIndicatorState();
}

class _ImageWithLoadingIndicatorState extends State<ImageWithLoadingIndicator> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.network(
          widget.imageUrl,
          fit: BoxFit.cover,
          height: widget.height,
          width: widget.width,
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              _isLoading = false;
              return child;
            } else {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
