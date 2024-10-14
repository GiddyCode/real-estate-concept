import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:latlong2/latlong.dart';
import 'package:realestate/core/themes/color_constants.dart';
import 'package:realestate/core/utils/image_constants.dart';
import 'package:realestate/features/search/presentation/widgets/animation/fade_in_expanded.dart';
import 'package:realestate/features/search/presentation/widgets/maps_circle_widget.dart';

class AnimatedMapIcons extends StatefulWidget {
  const AnimatedMapIcons({Key? key}) : super(key: key);

  @override
  _AnimatedMapIconsState createState() => _AnimatedMapIconsState();
}

class _AnimatedMapIconsState extends State<AnimatedMapIcons> with TickerProviderStateMixin, WidgetsBindingObserver {
  late final MapController _mapController;
  late final List<LatLng> _points;
  AnimationController? _cameraAnimationController;

  // Dimensions for the markers
  final double minWidth = 30.0;
  final double maxWidth = 60.0;
  late final double markerHeight;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();

    WidgetsBinding.instance.addObserver(this);

    final basePoint = LatLng(6.5244, 3.3792);

    final random = Random();

    _points = List.generate(6, (index) {
      final offsetLat = (random.nextDouble() - 0.5) * 0.04;
      final offsetLng = (random.nextDouble() - 0.5) * 0.04;
      return LatLng(basePoint.latitude + offsetLat, basePoint.longitude + offsetLng);
    });

    markerHeight = (30 / 60) * maxWidth;
  }



  @override
  void dispose() {
    // Remove the observer when the widget is disposed
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Function to move the camera to the selected marker
  void _onMarkerTap(LatLng destLocation) {
    final latTween = Tween<double>(
      begin: _mapController.center.latitude,
      end: destLocation.latitude,
    );

    final lngTween = Tween<double>(
      begin: _mapController.center.longitude,
      end: destLocation.longitude,
    );

    // No change in zoom level
    final zoomTween = Tween<double>(
      begin: _mapController.zoom,
      end: _mapController.zoom,
    );

    // Dispose of any existing animation controller
    _cameraAnimationController?.dispose();

    _cameraAnimationController = AnimationController(
      duration: const Duration(seconds: 2), // Adjust duration as needed
      vsync: this,
    );

    final animation = CurvedAnimation(
      parent: _cameraAnimationController!,
      curve: Curves.easeInOut,
    );

    _cameraAnimationController!.addListener(() {
      _mapController.move(
        LatLng(
          latTween.evaluate(animation),
          lngTween.evaluate(animation),
        ),
        zoomTween.evaluate(animation),
      );
    });

    _cameraAnimationController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _cameraAnimationController!.dispose();
        _cameraAnimationController = null;
      }
    });

    _cameraAnimationController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 120.h, left: 30.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FadeInExpandWidget(
                  child: MapCircleWidget(
                    asset: AllImages().stackIcon,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                FadeInExpandWidget(
                  child: MapCircleWidget(
                    asset: AllImages().navigationIcon,
                  ),
                )
              ],
            ),
            FadeInExpandWidget(
  child: Container(
              height: 51.h,
              width: 180.w,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5), borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Transform.scale(
                    scale: 1,
                    child: SvgPicture.asset(AllImages().menuIcon),
                  ),
                  Gap(5.w),
                  Text(
                    "List of variants",
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  )
                ],
              ),
            )),
          ],
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: _points[0],
              zoom: 14.0,
              onTap: (tapPosition, point) {},
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}@2x.png',
                subdomains: const ['a', 'b', 'c', 'd'],
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: List.generate(_points.length, (index) {
                  return Marker(
                    width: maxWidth, // Set to maxWidth
                    height: markerHeight,
                    point: _points[index],
                    anchorPos: AnchorPos.align(AnchorAlign.left),
                    builder: (ctx) => AnimatedMarker(
                      onTap: () => _onMarkerTap(_points[index]),
                      minWidth: minWidth,
                      maxWidth: maxWidth,
                      height: markerHeight,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }),
              ),
            ],
          ),
          // Add attribution text
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black54,
              padding: const EdgeInsets.all(4.0),
              child: const Text(
                '© Real-Estate App',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 10.0),
              ),
            ),
          ),

          Positioned(
            top: 50.h,
            left: 24.w,
            right: 24.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FadeInExpandWidget(
                  child: Flexible(
                    child: Container(
                      height: 41.h,
                      width: 255.w,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Transform.scale(
                            scale: 0.7,
                            child: SvgPicture.asset(AllImages().outlinedSearchIcon),
                          ),
                          Gap(5.w),
                          Text(
                            "List of variants",
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Gap(5.w),
                FadeInExpandWidget(
                  child: MapCircleWidget(
                    itemHeight: 40,
                    itemWidth: 40,
                    itemColor: Colors.white,
                    assetColor: Colors.black,
                    asset: AllImages().settingsIcon,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom widget for the animated marker
class AnimatedMarker extends StatefulWidget {
  final VoidCallback onTap;
  final double minWidth;
  final double maxWidth;
  final double height;
  final Duration duration;

  const AnimatedMarker({
    Key? key,
    required this.onTap,
    required this.minWidth,
    required this.maxWidth,
    required this.height,
    required this.duration,
  }) : super(key: key);

  @override
  _AnimatedMarkerState createState() => _AnimatedMarkerState();
}

class _AnimatedMarkerState extends State<AnimatedMarker> with TickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _animationController;
  late Animation<double> _widthAnimation;
  bool _animationStarted = false;

  @override
  void initState() {
    super.initState();

    // Register the observer to listen for app lifecycle changes
    WidgetsBinding.instance.addObserver(this);

    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _widthAnimation = Tween<double>(
      begin: widget.minWidth,
      end: widget.maxWidth,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animation if the widget is mounted and visible
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && ModalRoute.of(context)?.isCurrent == true) {
        _startAnimation();
      }
    });
  }

  void _startAnimation() {
    if (!_animationStarted) {
      _animationStarted = true;
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Start the animation when the app is resumed
    if (state == AppLifecycleState.resumed) {
      if (mounted && !_animationController.isCompleted) {
        _startAnimation();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _widthAnimation,
        builder: (context, child) {
          print("this is the width ${_widthAnimation.value}");
          return Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: _widthAnimation.value,
              height: widget.height,
              decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(0),
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
              child: _widthAnimation.value < 60 ? Transform.scale(
                scale: 0.5,
                  child: SvgPicture.asset(AllImages().officeIcon)) :Text("600 P",style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorConstants().stoneWhite), ),
            ),
          );
        },
      ),
    );
  }
}
