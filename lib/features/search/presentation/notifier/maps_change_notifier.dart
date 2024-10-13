import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:realestate/features/search/domain/usecase/get_random_locations.dart';

final nearByVendorVM = ChangeNotifierProvider((ref) => NearByVendorsVM(ref));

class NearByVendorsVM extends ChangeNotifier {
  final Ref ref;

  NearByVendorsVM(this.ref);

  GoogleMapController? _mapController;






  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(52.5200, 13.4050),
    zoom: 14.5,
  );
  set mapController(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }


  setUserLocation(LatLng latLng) {
    if (_mapController != null) {
      _mapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: latLng, zoom: 14.5, tilt: 50.0)));
      notifyListeners();
    }
  }


}
