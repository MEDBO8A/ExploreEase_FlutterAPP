import 'package:flutter/material.dart';
class CountryBox extends StatelessWidget {
  final String country;
  final num number;
  final String image;
  final VoidCallback onTap;

  const CountryBox(
      {super.key,
        required this.country,
        required this.number,
        required this.image,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Image.asset(
                    image,
                    fit: BoxFit.cover,
                    height: screenHeight * 0.22,
                    width: screenWidth * 0.33,
                  ),
                  Positioned(
                    left: 10,
                    bottom: 12,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      height: screenHeight * 0.07,
                      width: screenWidth * 0.26,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black26,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            country,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            " $number Packages",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
