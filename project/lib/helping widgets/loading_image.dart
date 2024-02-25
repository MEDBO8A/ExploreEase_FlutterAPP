import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

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
    return CachedNetworkImage(
      imageUrl: widget.imageUrl,
      cacheManager: CacheManager(
          Config(
              'customCacheKey',
              stalePeriod: const Duration(days: 7)
          )
      ),
      placeholder: (context, uri) => const CircularProgressIndicator(),
      imageBuilder: (context, imageProvider){
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
