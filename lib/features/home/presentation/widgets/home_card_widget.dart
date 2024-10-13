import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCardWidget extends StatelessWidget {
  const HomeCardWidget({super.key, this.width = 160, this.height = 179});
  final double height;
  final double width;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: width.h,
      decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(30)),
    );
  }
}
