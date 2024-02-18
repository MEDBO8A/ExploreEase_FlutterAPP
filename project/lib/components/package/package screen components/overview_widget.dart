import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/components/package/package%20screen%20components/package_online_details.dart';

import '../../../helping widgets/sizedbox_widget.dart';

Container overviewWidget(BuildContext context,LatLng coords, String placeID) {
  final theme = Theme.of(context);
  final themeColors = Theme.of(context).colorScheme;
  getTheme(theme);
  return Container(
    padding: EdgeInsets.all(10),
    width: MediaQuery.of(context).size.width,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.cloud,
                  color: themeColors.surface,
                  size: 20,
                ),
                getPlaceWeather(coords.latitude,coords.longitude),
              ],
            ),
            Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.solidClock,
                  color: themeColors.surface,
                  size: 20,
                ),
                getPlaceTime(coords.latitude,coords.longitude),
              ],
            ),
          ],
        ),
        addVerticalSpace(10),
        getPlaceDescription(placeID),
      ],
    ),
  );
}
