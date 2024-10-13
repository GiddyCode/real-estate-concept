import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:realestate/core/usecase/usecase.dart';

class RandomLocationsUseCase implements UseCase<Set<Marker>, int> {
  final LatLng _centralPoint = const LatLng(52.5200, 13.4050);
  final GlobalKey _markerKey = GlobalKey();
  @override
  Future<Set<Marker>> call({int? params}) async => await _generateNearbyMarkers(params!);

  Future<Set<Marker>> _generateNearbyMarkers(int numMarkers) async {
    print("i was called");
//    BitmapDescriptor customMarkerIcon = await createCustomMarkerIcon(_markerKey);
    Set<Marker> markers = {};
    const double earthRadius = 6371.0; // Radius of Earth in kilometers

    for (int i = 0; i < numMarkers; i++) {
      // Random angle and distance within 20 km
      double distanceKm = Random().nextDouble() * 20; // 0 to 20 km
      double angle = Random().nextDouble() * 2 * pi; // Random direction

      // Calculate new latitude and longitude
      double deltaLat = distanceKm / earthRadius;
      double deltaLng = distanceKm / (earthRadius * cos(pi * _centralPoint.latitude / 180.0));

      double newLat = _centralPoint.latitude + deltaLat * cos(angle);
      double newLng = _centralPoint.longitude + deltaLng * sin(angle);

      markers.add(
        Marker(
            markerId: MarkerId('marker_$i'),
            position: LatLng(newLat, newLng),
            infoWindow: InfoWindow(title: 'Marker $i'),
            // icon: customMarkerIcon
        ),
      );
    }
    print("Markers loaded completely");
    return markers;
  }

  Future<BitmapDescriptor> createCustomMarkerIcon(GlobalKey key) async {
    try {
      // Capture the widget from the GlobalKey
      RenderRepaintBoundary boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Convert Uint8List to BitmapDescriptor
      return BitmapDescriptor.fromBytes(pngBytes);
    } catch (e) {
      print("Error capturing widget as image: $e");
      throw Exception('Error capturing marker');
    }
  }

  // Create an image from widget
}
