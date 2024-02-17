import 'package:flutter/material.dart';

class MyRatingBar extends StatelessWidget {
  final num rating;
  final double size;

  MyRatingBar({required this.rating,required this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        num difference = rating - index;

        // Check if the current star should be half-filled
        bool isHalf = difference > 0 && difference < 1;

        return Icon(
          isHalf
              ? Icons.star_half
              : (index < rating.ceil() ? Icons.star : Icons.star_border),
          color: Colors.yellow,
          size: size,
        );
      }),
    );
  }
}
