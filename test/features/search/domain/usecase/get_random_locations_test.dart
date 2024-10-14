


import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:realestate/features/search/domain/usecase/get_random_locations.dart';


void main() {
  late RandomLocationsUseCase useCase;

  setUp(() {
    useCase = RandomLocationsUseCase();
  });

  test('should return a set of markers', () async {
    final markers = await useCase.call(params: 10);
    expect(markers, isA<Set<Marker>>());
  });

  test('should return a set of markers with the correct size', () async {
    final markers = await useCase.call(params: 10);
    expect(markers.length, 10);
  });

  test('should throw an error if params is null', () async {
    expect(() async => await useCase.call(), throwsAssertionError);
  });

  test('should throw an error if params is less than or equal to 0', () async {
    expect(() async => await useCase.call(params: 0), throwsAssertionError);
    expect(() async => await useCase.call(params: -1), throwsAssertionError);
  });

  test('should return a set of markers with unique ids', () async {
    final markers = await useCase.call(params: 10);
    final ids = markers.map((marker) => marker.markerId.value).toSet();
    expect(ids.length, 10);
  });

  test('should generate markers within a 20km radius', () async {
    final markers = await useCase.generateTestMarkers(10);
    final centralPoint =  const LatLng(52.5200, 13.4050);
    final earthRadius = 6371.0; // Radius of Earth in kilometers



    double _calculateDistance(LatLng point1, LatLng point2) {
      final lat1 = point1.latitude * pi / 180;
      final lng1 = point1.longitude * pi / 180;
      final lat2 = point2.latitude * pi / 180;
      final lng2 = point2.longitude * pi / 180;

      final dLat = lat2 - lat1;
      final dLng = lng2 - lng1;

      final a = sin(dLat / 2) * sin(dLat / 2) +
          cos(lat1) * cos(lat2) * sin(dLng / 2) * sin(dLng / 2);
      final c = 2 * atan2(sqrt(a), sqrt(1 - a));

      return 6371.0 * c; // Radius of Earth in kilometers
    }

    for (final marker in markers) {
      final distanceKm = _calculateDistance(centralPoint, marker.position);
      expect(distanceKm, lessThanOrEqualTo(20));
    }

  });


  testWidgets('should create a custom marker icon', (tester) async {
    final GlobalKey markerKey = GlobalKey();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RepaintBoundary(
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );

    final markerIcon = await useCase.createCustomMarkerIcon(markerKey);
    expect(markerIcon, isA<BitmapDescriptor>());
  });

  test('should throw an error if the marker key is not found', () async {
    expect(() async => await useCase.createCustomMarkerIcon(GlobalKey()), throwsException);
  });
}