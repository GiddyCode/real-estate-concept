import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:realestate/core/themes/color_constants.dart';
import 'package:realestate/core/utils/image_constants.dart';
import 'package:realestate/features/home/presentation/widgets/home_card_widget.dart';
import 'package:realestate/features/search/presentation/widgets/maps_circle_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 1100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorConstants().primaryColor,
              ColorConstants().secondaryColor.withOpacity(0.3),
              //  Colors.grey.withOpacity(0.3),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: const [
              0.4,
              0.7,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Gap(kTextTabBarHeight + 25.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 41.h,
                        width: 160.w,
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Transform.scale(
                              scale: 0.7,
                              child: SvgPicture.asset(
                                AllImages().locationIcon,
                                color: ColorConstants().secondaryColor,
                              ),
                            ),
                            Gap(5.w),
                            Text(
                              "Saint Petersburg",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: ColorConstants().secondaryColor),
                            ),
                          ],
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
                  const Gap(40),
                  Text(
                    "Hi, Marina",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: ColorConstants().secondaryColor,
                        fontWeight: FontWeight.w500),
                  ),
                  Gap(10.h),
                  Text(
                    "let's select your \nperfect place",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.w500, fontSize: 29),
                  ),
                  Gap(30.h),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        height: 139.h,
                        width: 139.w,
                        decoration: BoxDecoration(
                            color: ColorConstants().primaryColor,
                            shape: BoxShape.circle),
                        child: Column(
                          children: [
                            Text(
                              "BUY",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                            Gap(10.h),
                            Text(
                              "1034",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "offers",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Gap(10.h),
                      Container(
                        height: 139.h,
                        width: 187.w,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        decoration: BoxDecoration(
                            color: ColorConstants().stoneWhite,
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          children: [
                            Text(
                              "RENT",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: ColorConstants().secondaryColor),
                            ),
                            Gap(10.h),
                            Text(
                              "2 212",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(
                                      color: ColorConstants().secondaryColor,
                                      fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "offers",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: ColorConstants().secondaryColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(40.h),
            Flexible(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                child: Column(
                  children: [
                    const HomeCardWidget(height: 179, width: double.infinity),
                    Gap(10.h),
                    Row(
                      children: [
                        const HomeCardWidget(height: 368, width: 175),
                        Gap(10.w),
                        Column(
                          children: [
                            const HomeCardWidget(),
                            Gap(10.h),
                            const HomeCardWidget(),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                // height: 500.h,
              ),
            )
          ],
        ),
      ),
    );
  }
}
