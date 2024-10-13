import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:realestate/core/utils/image_constants.dart';
import 'package:realestate/features/search/presentation/notifier/maps_change_notifier.dart';
import 'package:realestate/features/search/presentation/notifier/random_location_list.dart';
import 'package:realestate/features/search/presentation/widgets/maps_circle_widget.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final newData = ref.watch(nearByVendorVM);
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
                  MapCircleWidget(
                    asset: AllImages().stackIcon,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  MapCircleWidget(
                    asset: AllImages().navigationIcon,
                  ),
                ],
              ),
              Container(
                height: 51.h,
                width: 180.w,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20)),
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
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        body: Stack(
          children: [
            ref.watch(getLocationsProvider).when(
                data: (data) => loadedMap(newData, data),
                error: (e, r) => emptyMap(newData),
                loading: () => emptyMap(newData)),
            Positioned(
              top: 50.h,
              left: 24.w,
              right: 24.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      height: 41.h,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Transform.scale(
                            scale: 0.7,
                            child: SvgPicture.asset(
                                AllImages().outlinedSearchIcon),
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
                  Gap(5.w),
                  MapCircleWidget(
                    itemHeight: 40,
                    itemWidth: 40,
                    itemColor: Colors.white,
                    assetColor: Colors.black,
                    asset: AllImages().settingsIcon,
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  // Function to convert Flutter widget to Bitmap
}

Widget emptyMap(NearByVendorsVM locationData) => GoogleMap(
      initialCameraPosition: locationData.kGooglePlex,
      myLocationButtonEnabled: false,
    );
Widget loadedMap(NearByVendorsVM locationData, Set<Marker> markers) =>
    GoogleMap(
      initialCameraPosition: locationData.kGooglePlex,
      myLocationButtonEnabled: false,
      mapType: MapType.hybrid,
      mapToolbarEnabled: false,
      markers: Set<Marker>.from(markers),
      onMapCreated: (GoogleMapController controller) =>
          locationData.mapController = controller,
    );
