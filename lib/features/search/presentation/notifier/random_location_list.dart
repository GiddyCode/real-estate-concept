
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:realestate/features/search/domain/usecase/get_random_locations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'random_location_list.g.dart';
@Riverpod(keepAlive: true)
Future<Set<Marker>> getLocations(Ref ref) async {
  final markers = RandomLocationsUseCase();
  return await markers(params: 7);
}