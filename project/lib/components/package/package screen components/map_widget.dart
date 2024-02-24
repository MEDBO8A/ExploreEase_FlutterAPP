import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

late GoogleMapController mapController;
Container mapWidget(BuildContext context, LatLng placeCoords) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
    ),
    padding: const EdgeInsets.all(5),
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.5,
    child: GoogleMap(
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
        Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
      ].toSet(),
      onMapCreated: (controller) {
        mapController = controller;
      },
      initialCameraPosition: CameraPosition(
        target: placeCoords,
        zoom: 11.5,
      ),
      markers: {
        Marker(
          markerId: const MarkerId("Source"),
          position: placeCoords,
        ),
      },
    ),
  );
}